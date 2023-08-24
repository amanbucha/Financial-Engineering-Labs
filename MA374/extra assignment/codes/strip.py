import matplotlib.pyplot as plt

def strip_profit_loss(S, K, c, p1, p2):
    return 2*max(K - S , 0) - c + max(S - K , 0) - p1 - p2

S = range(50, 151)
K = 100
c = 4 
p1 = 3 
p2 = 3 

profits_losses = [strip_profit_loss(s, K, c, p1, p2) for s in S]

plt.plot(S, profits_losses)
plt.axhline(y=0, color='gray', linestyle='--') 
plt.xlabel('Underlying Asset Price')
plt.ylabel('Profit or Loss')
plt.title('Strip Profit/Loss Curve')
plt.show()
