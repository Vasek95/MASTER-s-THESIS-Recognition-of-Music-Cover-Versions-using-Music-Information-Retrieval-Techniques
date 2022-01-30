import numpy as np

def normalizace (X):
    Y = np.empty(X.shape)
    p = 0
    for i in X:
        M = np.mean(i)
        S = np.std(i)
        y = (i - M)/S
        Y[p] = y
        p = p+1
    return Y