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
    @tickers = Tickers.get_tickers
  end

  # Dashboard
  def show
    @round = Round.find(params[:id])
  end
end
