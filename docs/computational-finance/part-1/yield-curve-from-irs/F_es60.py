import numpy as np


def F_es60(v_spot, time, time_int):
    # inputs:    v_spot   : prices of the ZCBs
    #            time     : the original maturities
    #            time_int : the new maturities
    # output:    v_spot_int : ZCB prices on the new grid time_int

    yield_ = -np.log(v_spot) / time            # continuous spot rate of each price (rates interpolate well, prices do not)
                                               # (yield is a reserved word in Python, hence yield_)

    yield_int = np.interp(time_int, time, yield_, left=np.nan, right=np.nan)
    # MATLAB: interp1(time, yield, time_int, 'linear')   (outside the known points both give NaN)

    v_spot_int = np.exp(-yield_int * time_int)  # back to discount factors
    return v_spot_int
