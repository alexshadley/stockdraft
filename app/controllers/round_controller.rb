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
    @users = RoundHelper.users_in_round(@round.round_id)
    @next_user = DraftHelper.current_up_for_draft(@drafted_tickers.length, @users)
  end

  # Dashboard
  def show
    @round = Round.find(params[:id])
    @users = User.where(round_id: @round.round_id)
    @drafts = StockDraft.where(round_id: @round.round_id)

    prices = AlpacaReader.get_data(Time.now - 7.days)
    @portfolios_by_user = @users.map{|user| [user, portfolio_series_for_user(user, @drafts, prices)]}
    
    if params[:portfolio].nil?
      @chart_data = @portfolios_by_user.map{|user, portfolio_series| {name: user.display_name, data: portfolio_series}}

    else
      symbols = @drafts.select{|draft| draft.user_id.to_s == params[:portfolio]}.map{|draft| draft.symbol}
      portfolio_prices = prices.select{|k, v| symbols.include? k}

      @chart_data = portfolio_prices.map{ |symbol, data|
        first_value = data.values[0]
        normalized = data.map{ |time, value| [time.in_time_zone('America/New_York').strftime('[%B %d, %I:%M]'), value / first_value]}.to_h
        {name: symbol, data: normalized}
      }
    end

    @mins = []
    @maxes = []

    for series in @chart_data
      if series[:data].values.length > 0
        @mins.append(series[:data].values.min)
      end
      if series[:data].values.length > 0
        @maxes.append(series[:data].values.max)
      end
    end
  end

  def portfolio_series_for_user(user, drafts, all_prices)
    symbols = drafts.select{|draft| draft.user_id == user.user_id}.map{|draft| draft.symbol}
    symbol_prices = all_prices.select{|k, v| symbols.include? k}

    if symbol_prices.size < 1
      return {}
    end

    summed_portfolio = {}
    for timestamp in symbol_prices.values[0].keys
      sum = 0
      for symbol, price_series in symbol_prices
        # draft associated with symbol for user
        draft = drafts.select{|draft| draft.user_id == user.user_id && draft.symbol == symbol}[0]

        if not price_series[timestamp].nil?
          sum += price_series[timestamp] * draft.position_size
        end
      end
      summed_portfolio[timestamp.strftime('[%B %d, %I:%M]')] = sum
    end

    return summed_portfolio
  end
end
