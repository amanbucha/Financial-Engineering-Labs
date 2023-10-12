import math, numpy as np, matplotlib.pyplot as plt
def calc(option,  S0=100, T=1, K=100, r=0.08, sigma=0.2, M=100):

    delt=T/M
    u=math.exp(sigma*math.sqrt(delt)+ delt*(r-0.5*sigma**2))
    d=math.exp(-sigma*math.sqrt(delt)+ delt*(r-0.5*sigma**2))
    R=math.exp(r*delt)
    p=(R-d)/(u-d)
    if not (R>=d and u>=R):
        print(r)
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
            dp[step][plus]=max(0 ,(-1 if option == 'call' else 1) *(K- S0* (u**plus)*(d**(step-plus))), (p*rec(step+1, plus+1)+(1-p)*rec(step+1, plus))/R)
        return dp[step][plus]
    return rec(0,0)

def graph(x, y, yy, var):
    plt.plot(x,y, label='call option')
    plt.plot(x, yy, label='put option')
    plt.legend()
    plt.xlabel(var)
    plt.ylabel('Initial Option Price')
    plt.show()

for option in ['call', 'put']:
    print(f'initial {option} option value: {calc(option)}')

x=[]
y=[]
yy=[]
for S0 in np.linspace(50, 150, 100):
    x.append(S0)
    y.append(calc('call', S0=S0))
    yy.append(calc('put',  S0=S0))
graph(x,y,yy,'S0' )
x.clear()
y.clear()
yy.clear()
for K in np.linspace(50, 150, 100):
    x.append(K)
    y.append(calc('call',  K=K))
    yy.append(calc('put',  K=K))
graph(x,y,yy,'K')
x.clear()
y.clear()
yy.clear()
for r in np.linspace(0.07, 0.09, 100):
    x.append(r)
    y.append(calc('call',  r=r))
    yy.append(calc('put',  r=r))
graph(x,y,yy,'r')
x.clear()
y.clear()
yy.clear()
for sigma in np.linspace(0.1, 0.5, 100):
    x.append(sigma)
    y.append(calc('call',  sigma=sigma))
    yy.append(calc('put',  sigma=sigma))
graph(x,y,yy,'sigma')
x.clear()
y.clear()
yy.clear()
for option in ['call', 'put']:
    for K in range(95, 106, 5):
        for M in np.linspace(50, 150, 100):
            x.append(M)
            y.append(calc(option,  M=int(M), K=K))
        plt.plot(x,y)
        #plt.title(f'option = {option}, K={K}')
        plt.xlabel('M')
        plt.ylabel('Initial Option Price')
        plt.show()
        x.clear()
        y.clear()       