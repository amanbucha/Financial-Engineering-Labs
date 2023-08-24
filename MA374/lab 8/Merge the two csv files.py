# %%
import pandas as pd
from datetime import datetime
import numpy as np

# %%
ce = pd.read_csv('CE.csv')
pe = pd.read_csv('PE.csv')

# %%
needed_cols=['Date', 'Expiry', 'Strike Price', 'Close']
ce=ce[needed_cols]
pe=pe[needed_cols]
ce.rename(columns={'Close':'Call Option Price'}, inplace=True)
pe.rename(columns={'Close':'Put Option Price'}, inplace=True)


# %%
final = pd.merge(pe, ce, on=['Date', 'Strike Price', 'Expiry'])
final.head()

# %%
final.to_csv('NIFTY_OPTION_DATA.csv')

# %%



