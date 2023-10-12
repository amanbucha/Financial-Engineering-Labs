import numpy as np, matplotlib.pyplot as plt
m = np.array([0.1, 0.2, 0.15])

C = np.array([
    [0.005, -0.010, 0.004],
    [-0.010, 0.040, -0.002],
    [0.004, -0.002, 0.023]
])

Cinv=np.linalg.inv(C)
u = np.array([1, 1, 1])
ut = np.transpose(u)
mt=np.transpose(m)

def func(myuv):
    A = [
    [1, u@Cinv@mt],
    [myuv, m@Cinv@mt]
    ]
    B = [
    [u@Cinv@ut, 1],
    [m@Cinv@ut, myuv]
    ]
    C = [
        [u@Cinv@ut, u@Cinv@mt],
        [m@Cinv@ut, m@Cinv@mt]
    ]

    w =(np.linalg.det(A)*u@Cinv + np.linalg.det(B)*m@Cinv)/np.linalg.det(C)

    varmin=  w@C@np.transpose(w)
    return varmin

s=[]
m=[]
for mmmm in np.arange(0,1,0.01):
    m.append(mmmm)
    s.append(func(mmmm))

plt.plot(s, m)



