import matplotlib.pyplot as plt

def strangle_profit_loss(S, K1, K2, c, p):
    return max(S - K2 , 0) - c - p + max(K1 - S , 0)

S = range(70, 131) 
K1 = 90 
K2 = 110
c = 3 
p = 3 

profits_losses = [strangle_profit_loss(s, K1, K2, c, p) for s in S]

plt.plot(S, profits_losses)
plt.axhline(y=0, color='gray', linestyle='--')
plt.xlabel('Underlying Asset Price')
plt.ylabel('Profit or Loss')
plt.title('Strangle Profit/Loss Curve')
plt.show()
