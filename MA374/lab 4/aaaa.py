import pandas as pd, numpy as np, matplotlib.pyplot as plt
from mpl_toolkits import mplot3d

df=pd.read_csv('midsemdata.csv', index_col='Year')
a=df.pct_change().dropna()
cov_matrix=a.cov()

W1=[]
W2=[]
K=[]
for w1 in np.linspace(-10, 10, 50):
    for w2 in np.linspace(-10, 10, 50):
        w3=1-w1-w2
        K.append(w1*np.mean(a['Stock 1'])+w2*np.mean(a['Stock 2'])+w3*np.mean(a['Stock 3']))
        W1.append(w1)
        W2.append(w2)

fig=plt.figure()
ax=plt.axes(projection='3d')
ax.plot3D(W1, W2, K)
plt.show()