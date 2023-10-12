import numpy as np
import math
import matplotlib.pyplot as plt

def cir_model(beta, myu, sigma, r, t, T_list):
  Yield = []

  for T in T_list:  
    gamma = math.sqrt(beta*beta + 2*sigma*sigma)
    B = 2 *(math.exp(gamma * (T - t)) - 1)  / ( 2*gamma + (gamma + beta) * (math.exp(gamma * (T - t)) - 1))
    A = math.pow( ( 2*gamma*math.exp(0.5*(beta + gamma)*(T - t)) ) / (2*gamma + (gamma + beta)*(math.exp(gamma*(T - t)) - 1)), 2*beta*myu / (sigma*sigma) ) 
    P = A * math.exp(-B * r)
    y = -math.log(P) / (T - t)
    Yield.append(y)
  
  return Yield

values = [[0.02, 0.7, 0.02, 0.1], [0.7, 0.1, 0.3, 0.2], [0.06, 0.09, 0.5, 0.02]]
for ind in range(len(values)):
  beta, myu, sigma, r = values[ind]
  T = np.linspace(0.1, 10, num=10, endpoint=False)
  Yield = cir_model(beta, myu, sigma, r, 0, T)
  plt.plot(T, Yield, marker='o')
  plt.xlabel('Maturity (T)')
  plt.ylabel('Yield')
  plt.title('Term structure with 10 time units for parameter set - {}'.format(ind + 1))
  plt.show()

T = np.linspace(0.1, 600, num=600, endpoint=False)
r_list = [0.1 * i for i in range(1, 11)]
values = [[0.02, 0.7, 0.02]]
for ind in range(len(values)):
  beta, myu, sigma = values[ind]
  for r in r_list:
    Yield = cir_model(beta, myu, sigma, r, 0, T)
    plt.plot(T, Yield)
  plt.xlabel('Maturity (T)')
  plt.ylabel('Yield')
  plt.title('Term structure with 600 time units for parameter set - {}'.format(ind + 1))
  plt.show()