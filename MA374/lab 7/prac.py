import math
from scipy.stats import norm
import numpy as np
import matplotlib.pyplot as plt
def bsm(t, T, K, r, S, sigma):
    if(t==T):
        return max(S-K, 0), max(K-S, 0) 
    tau=T-t
    d1=(math.log(S/K)+r*tau+0.5*(sigma**2)*tau)/(sigma*math.sqrt(tau))
    d2=d1-sigma*math.sqrt(tau)
    call=S*norm.cdf(d1)-K*math.exp(-r*tau)*norm.cdf(d2)
    put=call-S+K*math.exp(-r*tau)
    return call, put

def plot3d(x, y, z):
    ax=plt.axes(projection='3d')
    ax.plot_surface(x, y, z)
    plt.show()

t=[0,0.2,0.4,0.6,0.8,1]
s=np.arange(0.01,2.01,0.01)
Z=[]
t1=[]
s1=[]
for i in range(len(t)):
    z=[]
    for j in range(len(s)):
        c, p = bsm(t[i], 1, 1, 0.05, s[j], 0.6)
        t1.append(t[i])
        s1.append(s[j])
        z.append(c)
    Z.append(z)
s, t=np.meshgrid(s, t)
plot3d(t, s, np.array(Z))

