import matplotlib.pyplot as plt

def strap_profit_loss(S, K, c1, c2, p):
    return 2*max(S - K , 0) - c1 + max(K - S , 0) - c2 - p

S = range(50, 151) 
K = 100 
c1 = 4 
c2 = 4 
p = 3 

profits_losses = [strap_profit_loss(s, K, c1, c2, p) for s in S]

# plt.plot(S, profits_losses)
# plt.axhline(y=0, color='gray', linestyle='--') 
# plt.xlabel('Underlying Asset Price')
# plt.ylabel('Profit or Loss')
# plt.title('Strap Profit/Loss Curve');plt.show()
for i in range(5): 
  print(i) 
print(5)