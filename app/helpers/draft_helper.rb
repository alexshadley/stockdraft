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
    seen_so_far = drafted_tickers.length
    user_list = RoundHelper.users_in_round(active_round_id)

    # Calculate turn correctness (need to compare against sorted user_list)
    if seen_so_far % (2*user_list.length) >= user_list.length
      # decreasing segment for snake draft

      # TODO(trent)
    else
      #increasing segment
      # TODO(trent)
    end
      
    # Calculate if symbol is already picked
    # TODO(trent)

    # Calculate if the game is already over
    # TODO(trent)
    return true
  end

  def self.get_next_up_for_draft(active_round_id)
    # TODO(trent): Return the user object for the next picker in the draft
    return User
  end

  def self.draft_complete(active_round_id)
    # TODO(trent): Return whether enough stocks have been picked to end the draft
    return false
  end

end
