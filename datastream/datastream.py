
from dotenv import load_dotenv
import os
import datetime
import alpaca_trade_api as alpaca
import time
import psycopg2


load_dotenv()
# connect to Postgres
conn = psycopg2.connect(f"dbname={os.getenv('DB_NAME')}")

cur = conn.cursor()




# connect to alpaca
api = alpaca.REST(os.getenv('ALPACA_API_KEY'), os.getenv('ALPACA_SECRET_KEY'), os.getenv('ALPACA_ENDPOINT'))


# fetch list of symbols to keep updated
assets = [a.symbol for a in api.list_assets() if a.tradable and a.status == 'active' and a.exchange == 'NYSE']

print(f'Retrieving {len(assets)} tickers!')

# fetch prices from alpaca and read them into database
def get_data():
    # pacakage requests in groups of 199 (for minimum request amount)
    for i in range(0,len(assets), 200):
        symbols = assets[i:min(i+200, len(assets))]
        bars = api.get_barset(symbols=symbols, timeframe='minute', limit=1)
        for b in bars:
            if b and bars[b]:
                cur.execute(f"INSERT INTO historical_prices(symbol, time, price, created_at, updated_at) VALUES (%s, %s, %s, now(), now())", (b, datetime.datetime.now().strftime("%Y-%m-%d %H:%M"), str(bars[b][0].c)))



while(True):
    now_minute = datetime.datetime.now().minute
    get_data()
    conn.commit()
    while(datetime.datetime.now().minute == now_minute):
        time.sleep(0.2)
    