module DraftHelper
  def self.drafted_tickers(active_round_id)
    return StockDraft.select(:user_id, :symbol).where(round_id: [active_round_id])
  end

  def self.generate_fake_draft_data(active_round_id, tickers)
    i = 0
      for ticker in tickers
        StockDraft.new(
          round_id: active_round_id,
          user_id: i,
          position_entry_time: Time.now.getutc,
          symbol: ticker,
          position_size: 10,
          per_unit_entry_cost: 20
        ).save
        i += 1
      end
  end

  
  def self.draft_allowed(active_round_id, drafted_tickers, user, selected_symbol)
    # Returns true if a symbol selection for a given round by 
    # a user is allowed for drafting
    drafts_made_count = drafted_tickers.length
    user_list = RoundHelper.users_in_round(active_round_id)
    
    # Calculate turn correctness (need to compare against sorted user_list)
    user_up = current_up_for_draft(drafts_made_count, user_list)

    if user_up.user_id != user.user_id
      return false
    end
    
    
    # Calculate if symbol is already picked
    picked = false
    drafted_tickers.each{|pick| picked = (picked || pick.symbol == selected_symbol)}
    if picked
      return false
    end

    # Calculate if the game is already over
    if drafted_tickers.length >= user_list.length * Const::DRAFTS_PER_USER
      return false
    end
    return true
  end

  def self.current_up_for_draft(drafts_made_count, user_list)
    if user_list.length == 0
      return nil
    end

    if drafts_made_count % (2*user_list.length) >= user_list.length
      # decreasing segment for snake draft
      return user_list[(user_list.length - 1 - (drafts_made_count%user_list.length)%user_list.length)]
    else
      #increasing segment
      return user_list[drafts_made_count%user_list.length]
    end
  end

  def self.draft_complete(active_round_id)
    # TODO(trent): Return whether enough stocks have been picked to end the draft
    return drafted_tickers(active_round_id).length >= RoundHelper.users_in_round(active_round_id).length * Const::DRAFTS_PER_USER
  end

end
