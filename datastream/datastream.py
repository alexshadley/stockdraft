
from dotenv import load_dotenv
import os
import datetime
import alpaca_trade_api as alpaca
import time
import psycopg2

# connect to Postgres
# conn = psycopg.connect("")

# cur = conn.cursor()

# get access to 
load_dotenv()



# connect to alpaca
api = alpaca.REST(os.getenv('ALPACA_API_KEY'), os.getenv('ALPACA_SECRET_KEY'), os.getenv('ALPACA_ENDPOINT'))


# fetch list of symbols to keep updated
assets = [a.symbol for a in api.list_assets() if a.tradable and a.status == 'active' and a.exchange == 'NYSE']

print(len(assets))

# fetch prices from alpaca and read them into database
def get_data():
    # pacakage requests in groups of 199 (for minimum request amount)
    for i in range(0,len(assets), 200):
        symbols = assets[i:min(i+200, len(assets))]
        bars = api.get_barset(symbols=symbols, timeframe='minute', limit=1)
        for b in bars:
            if b and bars[b]:
                #do postgres update here
                pass


while(True):
    now_minute = datetime.datetime.now().minute
    print(now_minute)
    get_data()
    while(datetime.datetime.now().minute == now_minute):
        time.sleep(0.2)
    