class RoundController < ApplicationController
  def create
  end

  def create_post
    round = Round.new(round_id: params[:name], display_name: params[:name])
    round.save

    puts round

    redirect_to action: "draft", id: params[:name]
  end

  def draft
    @round = Round.find(params[:id])
  end

  def show
    @round = Round.find(params[:id])
  end
end
