import matplotlib.pyplot as plt

def straddle_profit_loss(S, K, c, p):
    return max(S - K , 0)  + max(K - S , 0) -c-p

S = range(70, 131) 
K = 100 
c = 5 
p = 5 
profits_losses = [straddle_profit_loss(s, K, c, p) for s in S]

plt.plot(S, profits_losses)
plt.axhline(y=0, color='gray', linestyle='--') 
plt.xlabel('Underlying Asset Price')
plt.ylabel('Profit or Loss')
plt.title('Straddle Profit/Loss Curve')
plt.show()
