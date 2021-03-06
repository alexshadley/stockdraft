require "alpaca/trade/api"

class AlpacaReader
  @@alpaca_client = Alpaca::Trade::Api::Client.new

  def self.get_data(start_time, end_time:Time.now)
    tickers = Tickers.get_tickers
    bars = @@alpaca_client.bars("15Min", tickers, limit:200)
    ticker_close_prices = {}
    for i in 0..tickers.length()-1
        ticker_close_prices[tickers[i]] = {}
        bars[tickers[i]].each { |bar|
            timestamp = bar.time
            if timestamp >= start_time && timestamp <= end_time
                close_price = bar.close.to_f()
                if close_price > 1.1
                    ticker_close_prices[tickers[i]][Time.at(timestamp)] = close_price
                end
            end
        }
    end
    return ticker_close_prices
  end

  def self.get_price_now(symbol)
    bars = @@alpaca_client.bars("15Min", Array.[](symbol), limit:20)
    for bar in bars[symbol].reverse
      if bar.close > 2
        return bar.close
      end
    end

    throw Exception.new("AUUUUGH")
  end
end
