import numpy as np

def format(X,s):
    X = X[s]
    X = np.squeeze(X)
    Y = np.empty((X.shape[0], X[0].shape[0], X[0].shape[1]))
    for i in range(Y.shape[0]):
        Y[i] = X[i]
    return Y

def format_H5PY(X1,s1):
    H5_array = X1[s1]
    T = np.empty((H5_array.shape[1], 180, 180))
    V = H5_array.value
    for j in range(V.shape[1]):
            T[j] = X1[V[0][j]].value
    return T

