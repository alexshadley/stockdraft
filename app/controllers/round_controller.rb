class RoundController < ApplicationController
  def create
  end

  def create_post
    puts params[:name]
    redirect_to action: "show", id: params[:name]
  end

  def show
  end

  def draft
  end
end
