module DraftHelper
  def self.drafted_tickers(active_round_id)
    return StockDraft.select(:user_id, :symbol).where(round_id: [active_round_id]).distinct
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
    # TODO: Validate draft
    return true
  end

  def self.get_next_up_for_draft(active_round_id)
    # TODO: Return the user object for the next picker in the draft
    return User
  end
end
