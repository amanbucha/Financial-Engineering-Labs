
import numpy as np
import math
import matplotlib.pyplot as plt

def vasicek_model(beta, myu, sigma, r, t, T_list):
  Yield = []
  for T in T_list:  
    B = (1 - math.exp(-beta *  (T - t))) / beta
    A = math.exp((B - T + t)*(beta*beta*myu - sigma*sigma*0.5)/(beta*beta) - math.pow(sigma * B, 2)/(4*beta))
    P = A * math.exp(-B * r)
    y = -math.log(P) / (T - t)
    Yield.append(y)
  return Yield

values = [[5.9, 0.2, 0.3, 0.1], [3.9, 0.1, 0.3, 0.2], [0.1, 0.4, 0.11, 0.1]]
for ind in range(len(values)):

    beta, myu, sigma, r = values[ind]
    T = np.linspace(0.01, 10, num=10, endpoint=False)
    Yield = vasicek_model(beta, myu, sigma, r, 0, T)

    plt.plot(T, Yield, marker='o')
    plt.xlabel('Maturity (T)')
    plt.ylabel('Yield')
    plt.title('Term structure with 10 time units for parameter set - {}'.format(ind + 1))
    plt.show()

T = np.linspace(0.01, 10, num=500, endpoint=False)
r_list = [0.1 * i for i in range(1, 11)]
for ind in range(len(values)):
    beta, myu, sigma, r = values[ind]
    for r in r_list:
        Yield = vasicek_model(beta, myu, sigma, r, 0, T)
        plt.plot(T, Yield)

    plt.xlabel('Maturity (T)')
    plt.ylabel('Yield')
    plt.title('Term structure with 500 time units for parameter set - {}'.format(ind + 1))
    plt.show()