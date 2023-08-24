import math
from tabulate import tabulate
S0, T, K, r, sigma=100, 5, 105, 0.05, 0.3
rows=[]
for M in [1,5,10,20,50,100,200,400]:
    delt=T/M
    u=math.exp(sigma*math.sqrt(delt)+delt*(r-0.5*sigma**2))
    d=math.exp(-sigma*math.sqrt(delt)+delt*(r-0.5*sigma**2))
    R=math.exp(r*delt)
    if not (R>=d and u>=R):
        exit('No arbitrage principle violated')
    p=(R-d)/(u-d)
    dp=[[0 for i in range(M+1)] for j in range(M+1)]
    vstd={'call':[[False for i in range(M+1)] for j in range(M+1)], 'put':[[False for i in range(M+1)] for j in range(M+1)]}
    def rec(step, plus, option):
        if vstd[option][step][plus]:
            return dp[step][plus]
        vstd[option][step][plus]=True
        if step==M:
            dp[step][plus]= max(0, (-1 if option == 'call' else 1) *(K- S0* (u**plus)*(d**(step-plus))) )
        else:
            dp[step][plus]=(p*rec(step+1, plus+1, option)+(1-p)*rec(step+1, plus, option))/R
        return dp[step][plus]
    rows.append([M, rec(0, 0, 'call'), rec(0,0,'put')])

print(tabulate(rows, ['M', 'call option', 'put option'], tablefmt='grid'), '\n')