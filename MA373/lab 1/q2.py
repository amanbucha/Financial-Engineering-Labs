import math, numpy as np, matplotlib.pyplot as plt
S0, T, K, r, sigma=100, 5, 105, 0.05, 0.3
def calc(M, option):
    delt=T/M
    u=math.exp(sigma*math.sqrt(delt)+delt*(r-0.5*sigma**2))
    d=math.exp(-sigma*math.sqrt(delt)+delt*(r-0.5*sigma**2))
    R=math.exp(r*delt)
    p=(R-d)/(u-d)
    if not (R>=d and u>=R):
            exit('No arbitrage principle violated')
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
    return rec(0,0)

for option in ['call', 'put']:
    for Step in [1, 5]:
        x=[]
        y=[]
        for M in np.arange(Step, 400+Step, Step):
            x.append(M)
            y.append(calc(M, option))
        print(f'Convergent value of {option} option at step= {Step} is {y[-1]}')
        plt.plot(x, y)
        plt.title(option+' option price: '+ f' step = {Step}')
        plt.xlabel('Number of subintervals (M)')
        plt.ylabel('Initial option price')
        plt.show()