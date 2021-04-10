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
  end
end
