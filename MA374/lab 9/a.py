import yfinance as yf
import pandas as pd

# Define the list of stock tickers to fetch data for
sensex_tickers = ['AAPL', 'MSFT', 'AMZN', 'GOOG', 'FB'] # example tickers, you can modify it as per SENSEX stocks

# Define the option chain expiry date
expiry_date = '2023-06-16'

# Fetch the option chain data fo    r each ticker in the list
option_data = []
for ticker in sensex_tickers:
    # Fetch the option chain for the given expiry date
    option_chain = yf.Ticker(ticker).option_chain()
    
    # Store the option data in a DataFrame
    calls_df = option_chain.calls.reset_index(drop=True)
    puts_df = option_chain.puts.reset_index(drop=True)
    option_data.append(pd.concat([calls_df, puts_df], axis=0))
    
# Combine the option data for all tickers into a single DataFrame
options_df = pd.concat(option_data, keys=sensex_tickers, names=['Ticker', 'Option'])

# Save the data to a CSV file
options_df.to_csv('sensex_options_data.csv')
