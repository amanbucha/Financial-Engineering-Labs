import yfinance as yf
import pandas as pd
market_bse=['^BSESN']
bse = ['TATASTEEL.NS', 'HDFCBANK.NS', 'INFY.NS', 'ICICIBANK.NS', 'SBIN.NS', 'RELIANCE.NS', 'ITC.NS', 'HINDUNILVR.NS', 'WIPRO.NS', 'BAJFINANCE.NS']
nonbse=['PFS.NS', 'SYNGENE.NS', 'DIXON.NS', 'MUTHOOTCAP.NS', 'THYROCARE.NS', 'IEX.NS', 'LALPATHLAB.NS', 'SHRIRAMCIT.NS', 'NETWORK18.NS', 'PVR.NS']

stocks=market_bse+bse+nonbse
start_date = '2018-01-01'
end_date = '2022-12-31'
data = yf.download(stocks, start=start_date, end=end_date)
closing_prices = data['Close']
closing_prices=closing_prices[ stocks]
closing_prices.rename(columns={market_bse[0]: "Sensex"}, inplace=True)
closing_prices.to_csv('bsedata1.csv')   