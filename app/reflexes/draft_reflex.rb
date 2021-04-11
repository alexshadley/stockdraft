class DraftReflex < ApplicationReflex
  def new_user
    @round = Round.find(params[:id])

    user = User.new(session_id: session.id, display_name: params[:name], round_id: @round.round_id)
    user.save

    # re-query all users
    @users = User.where(round_id: @round.round_id)
  end
  
  def pick_stock
    # 1) Pull round / user / active draft data based off session params
    # 2) Validate that pick is allowed
    # 3) Write pick to database
    # 4) Update next user || end draft
    # 5) Update view (idk how to push this to everyone)

    @round = Round.find(params[:id])
    @user = User.all.where({session_id: session.id.to_s, round_id: @round.round_id}).first
    @selected_symbol = element.dataset['symbol']
    puts @user.to_s
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
    unit_cost = PortfolioHelper.get_price_at_time(@selected_symbol, @round.creation_time)

    draft_write = StockDraft.new( 
      round_id: @round.round_id,
      user_id: @user.user_id,
      position_entry_time: @round.creation_time,
      symbol: @selected_symbol,
      position_size: Const::PORTFOLIO_START_VALUE_USD / unit_cost,
      per_unit_entry_cost: unit_cost
    )
    
    draft_write.save
    
    for draft in StockDraft.all.where({round_id: @round.round_id})
      puts (draft.to_s)
      puts draft.symbol + draft.user_id.to_s + "\n"
    end

    @drafted_tickers = DraftHelper.drafted_tickers(@round.round_id)

    puts "Post query \n"
    for ticker in @drafted_tickers
      puts (ticker.nil?.to_s)
      puts ticker.symbol + ticker.user_id.to_s + "\n"
    end
    # End draft if over
    if DraftHelper.draft_complete(@round)
      # TODO: Write draft-end time + redirect to show page + next_user set
      return
    end
    
    # Update @next_user
    @next_user = DraftHelper.get_next_up_for_draft(@round.round_id)


    # TODO: Update people with ~cables~
    
  end
end
