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
    RoundHelper.generate_fake_draft_data(@round.round_id, @all_tickers[0..2])
    @drafted_tickers = RoundHelper.drafted_tickers(@round.round_id)
    for draft in @drafted_tickers
      puts draft.symbol
      puts draft.user_id
    end
  end

  # Dashboard
  def show
    @round = Round.find(params[:id])
<<<<<<< HEAD
    @users = User.where(round_id: @round.round_id)
    @tickers = Tickers.get_tickers
=======
>>>>>>> 01d246afe5990923c24caeb04e60a5423a8ca92b
  end
end
