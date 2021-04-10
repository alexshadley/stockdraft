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
    @drafted_tickers = RoundHelper.drafted_tickers(@round.round_id)
    for draft in @drafted_tickers
      puts draft.symbol
      puts draft.user_id
    end
    @users = User.where(round_id: @round.round_id)
    @tickers = Tickers.get_tickers
  end

  # Dashboard
  def show
    @round = Round.find(params[:id])
  end
end
