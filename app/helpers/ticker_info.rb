require 'iex-ruby-client'

class TickerInfo
  sandbox_client = IEX::Api::Client.new(
    publishable_token: ENV['IEX_SANDBOX_KEY'],
    secret_token: ENV['IEX_SANDBOX_SECRET'],
    endpoint: 'https://sandbox.iexapis.com/v1'
  )
  @@ticker_company_names = Tickers.get_tickers.map{|ticker| [ticker, sandbox_client.company(ticker).company_name]}.to_h

  
  def self.get_company_name(symbol)
    return @@ticker_company_names[symbol]
  end

  def self.get_logo_url(symbol)
    return "https://storage.googleapis.com/iexcloud-hl37opg/api/logos/" + symbol + ".png"
  end
end
