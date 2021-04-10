module RoundHelper
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
end
