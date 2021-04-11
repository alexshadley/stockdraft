class RoundController < ApplicationController
  def create
  end

  def create_post
    round = Round.new(round_id: params[:name], display_name: params[:name])
    round.save

    redirect_to action: "draft", id: params[:name]
  end

  # Drafting Stocks
  def draft
    @round = Round.find(params[:id])
    @all_tickers = Tickers.get_tickers
    @drafted_tickers = DraftHelper.drafted_tickers(@round.round_id)
    @users = User.where(round_id: @round.round_id)
    @next_user = DraftHelper.get_next_up_for_draft(@round.round_id)
  end

  # Dashboard
  def show
    @round = Round.find(params[:id])
    @users = User.where(round_id: @round.round_id)
    @drafts = StockDraft.where(round_id: @round.round_id)

    @goog_time_series = {
      "2021-01-01T:00:00:00Z" => 100.00,
      "2021-01-01T:01:00:00Z" => 111.47,
      "2021-01-01T:02:00:00Z" => 94.62,
      "2021-01-01T:03:00:00Z" => 86.21,
      "2021-01-01T:04:00:00Z" => 90.17,
      "2021-01-01T:05:00:00Z" => 100.00,
      "2021-01-01T:06:00:00Z" => 111.47,
      "2021-01-01T:07:00:00Z" => 94.62,
      "2021-01-01T:08:00:00Z" => 86.21,
      "2021-01-01T:09:00:00Z" => 90.17,
      "2021-01-01T:10:00:00Z" => 100.00,
      "2021-01-01T:11:00:00Z" => 111.47,
      "2021-01-01T:12:00:00Z" => 94.62,
      "2021-01-01T:13:00:00Z" => 86.21,
      "2021-01-01T:14:00:00Z" => 90.17,
      "2021-01-01T:15:00:00Z" => 100.00,
      "2021-01-01T:16:00:00Z" => 111.47,
      "2021-01-01T:17:00:00Z" => 94.62,
      "2021-01-01T:18:00:00Z" => 86.21,
      "2021-01-01T:19:00:00Z" => 90.17,
      "2021-01-01T:20:00:00Z" => 100.00,
      "2021-01-01T:21:00:00Z" => 111.47,
      "2021-01-01T:22:00:00Z" => 94.62,
      "2021-01-01T:23:00:00Z" => 86.21,
    }

    @aapl_time_series = {
      "2021-01-01T:00:00:00Z" => 86.21,
      "2021-01-01T:01:00:00Z" => 100.00,
      "2021-01-01T:02:00:00Z" => 111.47,
      "2021-01-01T:03:00:00Z" => 94.62,
      "2021-01-01T:04:00:00Z" => 86.21,
      "2021-01-01T:05:00:00Z" => 90.17,
      "2021-01-01T:06:00:00Z" => 100.00,
      "2021-01-01T:07:00:00Z" => 111.47,
      "2021-01-01T:08:00:00Z" => 94.62,
      "2021-01-01T:09:00:00Z" => 86.21,
      "2021-01-01T:10:00:00Z" => 90.17,
      "2021-01-01T:11:00:00Z" => 100.00,
      "2021-01-01T:12:00:00Z" => 111.47,
      "2021-01-01T:13:00:00Z" => 94.62,
      "2021-01-01T:14:00:00Z" => 86.21,
      "2021-01-01T:15:00:00Z" => 90.17,
      "2021-01-01T:16:00:00Z" => 100.00,
      "2021-01-01T:17:00:00Z" => 111.47,
      "2021-01-01T:18:00:00Z" => 94.62,
      "2021-01-01T:19:00:00Z" => 86.21,
      "2021-01-01T:20:00:00Z" => 90.17,
      "2021-01-01T:21:00:00Z" => 100.00,
      "2021-01-01T:22:00:00Z" => 111.47,
      "2021-01-01T:23:00:00Z" => 94.62,
    }
  end
end
