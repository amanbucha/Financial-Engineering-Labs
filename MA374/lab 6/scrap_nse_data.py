import yfinance as yf
import pandas as pd
market_nse=['^NSEI']
nse=['ADANIPORTS.NS', 'ASIANPAINT.NS', 'BAJAJFINSV.NS', 'BAJFINANCE.NS', 'DIVISLAB.NS', 'HDFCLIFE.NS', 'HINDUNILVR.NS', 'NESTLEIND.NS', 'POWERGRID.NS', 'TATACONSUM.NS']
non_nse=['GNFC.NS', 'INDIANB.NS', 'NIACL.NS', 'RTNPOWER.NS', 'HSCL.NS', 'SPTL.NS', 'GPPL.NS', 'CHENNPETRO.NS', 'AVANTIFEED.NS', 'GTLINFRA.NS']

stocks=market_nse+nse+non_nse

start_date = '2018-01-01'
end_date = '2022-12-31'
data = yf.download(stocks, start=start_date, end=end_date)
closing_prices = data['Close']
closing_prices=closing_prices[ stocks]
closing_prices.rename(columns={market_nse[0]: "NIFTY50"}, inplace=True)
closing_prices.to_csv('nsedata1.csv')