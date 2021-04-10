class Tickers
  def self.get_tickers
    data = YAML.load_file('config/tickers.yaml')
    puts data
    return data["tickers"]
  end
end