import matplotlib.pyplot as plt

def butterfly_profit_loss(S, K1, K2, K3, c1, c2, c3):
    return -c1+2*c2-c3 + max(S-K1, 0)+max(S-K3, 0) - 2* max(S-K2, 0) 

S = range(75, 140)
K1 = 100 
K2= 105
K3=110
c1 = 8 
c2 = 4 
c3 = 2 

profits_losses = [butterfly_profit_loss(s, K1, K2, K3, c1, c2, c3) for s in S]

plt.plot(S, profits_losses)
plt.axhline(y=0, color='gray', linestyle='--') 
plt.xlabel('Underlying Asset Price')
plt.ylabel('Profit or Loss')
plt.title('Butterfly Spread Profit/Loss Curve')
plt.show()
