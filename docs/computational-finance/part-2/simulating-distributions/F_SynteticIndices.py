import numpy as np


def F_SynteticIndices(x):
    E_x = np.mean(x)
    print("E_x =", E_x)
    Var_x = np.mean((x - np.mean(x))**2)
    print("Var_x =", Var_x)
    Dev_x = np.sqrt(Var_x)
    Sk_x = np.mean(((x - np.mean(x)) / Dev_x)**3)
    print("Sk_x =", Sk_x)
    Ku_x = np.mean(((x - np.mean(x)) / Dev_x)**4)
    print("Ku_x =", Ku_x)
    return E_x, Var_x, Sk_x, Ku_x
