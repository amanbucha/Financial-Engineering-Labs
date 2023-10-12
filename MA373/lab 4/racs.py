from matplotlib import pyplot as plt
import numpy as np
from numpy import linalg as la
import pandas as pd
from math import sqrt
from scipy.interpolate import CubicSpline


M = np.array([0.1, 0.2, 0.15])

C = np.array([
    [0.005, -0.010, 0.004],
    [-0.010, 0.040, -0.002],
    [0.004, -0.002, 0.023]
])

Cinv = la.inv(C)
Mt = np.transpose(M)

u = np.array([1, 1, 1])
ut = np.transpose(u)

def get_w(mu):
    A = [
        [1, u@Cinv@Mt],
        [mu, M@Cinv@Mt]
    ]
    B = [
        [u@Cinv@ut, 1],
        [M@Cinv@ut, mu]
    ]
    C = [
        [u@Cinv@ut, u@Cinv@Mt],
        [M@Cinv@ut, M@Cinv@Mt]
    ]

    return (la.det(A)*u@Cinv + la.det(B)*M@Cinv)/la.det(C)

def get_min_w():
    return (u@Cinv)/(u@Cinv@ut)

x_vals = []
y_vals =[]

for x in np.arange(0,1,0.01):
    w = get_w(x)
    var = w@C@np.transpose(w)
    y_vals.append(x)
    x_vals.append(sqrt(var))

w_min = get_min_w()
var_min = w_min@C@np.transpose(w_min)
sig_min = sqrt(var_min)
mu_min = np.transpose(w_min)@M


markov_x=[]
markov_y=[]

m_sigma=[]
m_mean=[]

for i in range(len(x_vals)):
    if y_vals[i] >= mu_min:
        markov_x.append(x_vals[i])
        markov_y.append(y_vals[i])
    else:
        m_sigma.append(x_vals[i])
        m_mean.append(y_vals[i])

m_sigma.reverse()
m_mean.reverse()

poly=CubicSpline(m_sigma, m_mean)
poly_max=CubicSpline(markov_x, markov_y)




print(poly(0.15))
print(poly_max(0.15))

w=((M-0.1*u)@Cinv)/((M-0.1*u)@Cinv@np.transpose(u))

sigmaM=sqrt(w@C@np.transpose(w))
meanM=poly_max(sigmaM)

print(sigmaM)
a=0.1
b=(meanM-0.1)/sigmaM
XX=[]
YY=[]
for sigma in np.linspace(0.001, 1, 5000):
    XX.append(sigma)
    YY.append(a+b*sigma)

plt.plot(XX, YY)

plt.plot(x_vals, y_vals, label='Minimum Variance Line')
plt.plot(markov_x, markov_y, label='Efficient Frontier')
plt.plot(sig_min, mu_min, marker='o', markersize=8, markerfacecolor='green', label='Minimum Variance Portfolio')

plt.legend()
plt.show()