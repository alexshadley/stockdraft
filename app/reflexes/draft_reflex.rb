

class DraftReflex < ApplicationReflex
  def new_user
    @round = Round.find(params[:id])

    user = User.new(session_id: session.id, display_name: params[:name], round_id: @round.round_id)
    user.save

    # re-query all users
    @users = RoundHelper.users_in_round(@round.round_id)

    cable_ready["draft:#{@round.round_id}"].morph(
      selector: '#stock-selection',
      html: render(partial: 'stock_selection', locals: {drafted_tickers: DraftHelper.drafted_tickers(@round.round_id), all_tickers: Tickers.get_tickers, round: @round, users: @users})
    ).broadcast
  end
  
  def pick_stock
    # 1) Pull round / user / active draft data based off session params
    # 2) Validate that pick is allowed
    # 3) Write pick to database
    # 4) Update next user || end draft
    # 5) Update view (idk how to push this to everyone)

    @round = Round.find(params[:id])
    @user = User.all.where({session_id: session.id.to_s, round_id: @round.round_id}).first
    @users = RoundHelper.users_in_round(@round.round_id)
    @selected_symbol = element.dataset['symbol']
    @all_tickers = Tickers.get_tickers

    if @user.nil?
      # Probably a spectator, don't let them in!
      puts "Spectator click\n"
      return
    end
    
    @drafted_tickers = DraftHelper.drafted_tickers(@round.round_id)
    #TODO(error message would be cool below)
    if !DraftHelper.draft_allowed(@round.round_id, @drafted_tickers, @user, @selected_symbol)
      return
    end

    # Write the valid draft pick
    unit_cost = AlpacaReader.get_price_now(@selected_symbol)
    
    StockDraft.new( 
      round_id: @round.round_id,
      user_id: @user.user_id,
      position_entry_time: @round.creation_time,
      symbol: @selected_symbol,
      position_size: Const::PORTFOLIO_START_VALUE_USD / Const::DRAFTS_PER_USER / unit_cost,
      per_unit_entry_cost: unit_cost
    ).save

    @drafted_tickers = DraftHelper.drafted_tickers(@round.round_id)

    # End draft if over
    if DraftHelper.draft_complete(@round)
      # TODO: Write draft-end time + redirect to show page + next_user set
      return
    end
    
    # Update @next_user
    @next_user = DraftHelper.current_up_for_draft(@drafted_tickers.length, @users)

    cable_ready["draft:#{@round.round_id}"].morph(
      selector: '#stock-selection',
      html: render(partial: 'stock_selection', locals: {drafted_tickers: @drafted_tickers, all_tickers: @all_tickers, round: @round})
    ).broadcast
  end
end
