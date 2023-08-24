import math, numpy as np
from tabulate import tabulate
S0, T, K, r, sigma=100, 5, 105, 0.05, 0.3
M=20
delt=T/M
times=[0,0.50,1,1.50,3,4.5 ]
indices=[round(time/delt) for time in times]
def calc(option):
    print(option, ' option:')
    u=math.exp(sigma*math.sqrt(delt)+delt*(r-0.5*sigma**2))
    d=math.exp(-sigma*math.sqrt(delt)+delt*(r-0.5*sigma**2))
    R=math.exp(r*delt)
    if not (R>=d and u>=R):
        exit('No arbitrage principle violated')
    p=(R-d)/(u-d)
    dp=[[0 for i in range(M+1)] for j in range(M+1)]
    vstd=[[False for i in range(M+1)] for j in range(M+1)]
    def rec(step, plus):
        if vstd[step][plus]:
            return dp[step][plus]
        vstd[step][plus]=True
        if step==M:
            dp[step][plus]= max(0, (-1 if option == 'call' else 1) *(K- S0* (u**plus)*(d**(step-plus))) )
        else:
            dp[step][plus]=(p*rec(step+1, plus+1)+(1-p)*rec(step+1, plus))/R
        return dp[step][plus]
    rec(0,0)
    rows=[]
    for index in indices:
        rows.append([index*delt, [round(x, 3) for x in dp[index][: index+1]]])
    return tabulate(rows, ['Time', f'{option} option'], tablefmt='grid')

for option in ['call', 'put']:
    print(calc(option))