require "alpaca/trade/api"

class DataHelper
    @@alpaca_client = Alpaca::Trade::Api::Client.new

    def self.get_data()
        tickers = Tickers.get_tickers
        bars = @@alpaca_client.bars("15Min", tickers)
        ticker_close_prices = {}
        
        for i in 0..tickers.length()-1
            ticker_close_prices[tickers[i]] = Array.[]()
            bars[tickers[i]].each { |bar|
                ticker_close_prices[tickers[i]].append(bar.close.to_f())
            }
        end
        
        return ticker_close_prices
    end
end


