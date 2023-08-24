import math, numpy as np, matplotlib.pyplot as plt

def calc(option, case, S0=100, T=1, K=100, r=0.08, sigma=0.2, M=5, matrix=False):

    delt=T/M
    u=math.exp(sigma*math.sqrt(delt)+ (0 if case == 0 else delt*(r-0.5*sigma**2)))
    d=math.exp(-sigma*math.sqrt(delt)+(0 if case == 0 else delt*(r-0.5*sigma**2)))
    R=math.exp(r*delt)
    p=(R-d)/(u-d)
    if not (R>=d and u>=R):
        print(r)
        exit('No arbitrage principle violated')
    def rec(step,maxi, curr):
        if step==M:
            return max(0, (-1 if option == 'call' else 1) *(K- maxi))
        else:
            return (p*rec(step+1, max(maxi, curr*u), curr*u)+(1-p)*rec(step+1, maxi, curr*d))/R
    return rec(0, S0, S0)

def graph(x, y, yy, var, case):
    plt.plot(x,y, label='call option')
    plt.plot(x, yy, label='put option')
    plt.title(f'Set = {case+1}')
    plt.legend()
    plt.xlabel(var)
    plt.ylabel('Initial Option Price')
    plt.show()

for option in ['call', 'put']:
    for M in [5, 10, 25, 50]:
        print(f'M= {M} : option price = {calc(option, M=M)}')
    
    dp=calc(matrix=True)
    print(dp)

