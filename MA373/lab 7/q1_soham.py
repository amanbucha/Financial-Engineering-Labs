from scipy.stats import norm
import math

def bsm(s,t,T,k,r,sigma):
    if t==T:
        return max(0,s-k),max(k-s,0)
    d1=math.log(s/k)+(r+(0.5*sigma*sigma))*(T-t)
    d2=math.log(s/k)+(r-(0.5*sigma*sigma))*(T-t)
    div=sigma*math.sqrt(T-t)
    d1/=div
    d2/=div
    call=s*norm.cdf(d1)-(k*math.exp(-r*(T-t))*norm.cdf(d2))
    put=(k*math.exp(-r*(T-t))*norm.cdf(-1*d2))-s*norm.cdf(-1*d1)
    return call,put

call,put=bsm(1,0,1,1,0.05,0.6)
print(call,put)