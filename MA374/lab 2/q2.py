import math, numpy as np, matplotlib.pyplot as plt

def calc(option, case, S0=100, T=1, K=100, r=0.08, sigma=0.2, M=10):

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
            return (p*rec(step+1, max(curr*u, maxi), curr*u)+(1-p)*rec(step+1, maxi, curr*d))/R
    return rec(0, S0, S0)

def graph(x, y, yy, var, case):
    plt.plot(x,y, label='call option')
    plt.plot(x, yy, label='put option')
    plt.title(f'Set = {case+1}')
    plt.legend()
    plt.xlabel(var)
    plt.ylabel('Initial Option Price')
    plt.show()

for case in [0, 1]:
    print(f'Set = {case}')
    for option in ['call', 'put']:
        print(f'initial {option} option value: {calc(option, case)}')

for case in [0, 1]:
    x=[]
    y=[]
    yy=[]
    for S0 in np.linspace(50, 150, 100):
        x.append(S0)
        y.append(calc('call', case, S0=S0))
        yy.append(calc('put', case, S0=S0))
    graph(x,y,yy,'S0', case)
    x.clear()
    y.clear()
    yy.clear()
    for K in np.linspace(50, 150, 100):
        x.append(K)
        y.append(calc('call', case, K=K))
        yy.append(calc('put', case, K=K))
    graph(x,y,yy,'K', case)
    x.clear()
    y.clear()
    yy.clear()
    for r in np.linspace(0.07, 0.09, 100):
        x.append(r)
        y.append(calc('call', case, r=r))
        yy.append(calc('put', case, r=r))
    graph(x,y,yy,'r', case)
    x.clear()
    y.clear()
    yy.clear()
    for sigma in np.linspace(0.1, 0.5, 100):
        x.append(sigma)
        y.append(calc('call', case, sigma=sigma))
        yy.append(calc('put', case, sigma=sigma))
    graph(x,y,yy,'sigma', case)
    x.clear()
    y.clear()
    yy.clear()
    for option in ['call', 'put']:
        for K in range(95, 106, 5):
            for M in range(3, 22):
                x.append(M)
                y.append(calc(option, case, M=int(M), K=K))
            plt.plot(x,y)
            plt.title(f'Set = {case+1},option = {option}, K={K}')
            plt.xlabel('M')
            plt.ylabel('Initial Option Price')
            plt.show()
            x.clear()
            y.clear()

