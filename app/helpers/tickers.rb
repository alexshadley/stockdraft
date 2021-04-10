class Tickers
  def self.get_tickers
    data = YAML.load_file('config/tickers.yaml')
    return data["tickers"]
  end
end