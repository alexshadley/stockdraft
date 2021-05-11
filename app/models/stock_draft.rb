class StockDraft < ApplicationRecord
  validates :symbol, uniqueness: { scope: :round_id,
    message: "should happen once per year" }
end
