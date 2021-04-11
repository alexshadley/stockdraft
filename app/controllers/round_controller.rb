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

    @mins = []
    @maxes = []

    prices = AlpacaReader.get_data(Time.now - 5.days)
    
    if params[:portfolio].nil?
    else
      symbols = @drafts.select{|draft| draft.user_id.to_s == params[:portfolio]}.map{|draft| draft.symbol}
      puts symbols

      portfolio_prices = prices.select{|k, v| symbols.include? k}
      puts portfolio_prices
      @chart_data = portfolio_prices.map{ |symbol, data|
        first_value = data.values[0]
        normalized = data.map{ |time, value| [time.strftime('[%B %d, %I:%M]'), value / first_value]}.to_h

        @mins.append(normalized.values.min)
        @maxes.append(normalized.values.max)
        
        {name: symbol, data: normalized}
      }
    end
  end
end
