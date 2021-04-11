require 'iex-ruby-client'

class TickerInfo
  @@client = client = IEX::Api::Client.new(
    endpoint: 'https://sandbox.iexapis.com/v1'
  )
  
  def self.get_company_name(symbol)
    return @@client.company(symbol).company_name
  end

  def self.get_logo_url(symbol)
    return 'https://s3.polygon.io/logos/' + symbol.downcase + "/logo.png"
  end
end
