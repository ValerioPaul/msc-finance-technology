# Net present value and duration of a set of bonds

<p class="ex-meta">Course exercises 47–48 · Part I</p>

## Problem

Write a function that returns the net present value and the duration of several assets at
once, given their cash flows on a common schedule and a non-flat rate curve (exercise 47).
Apply it to four assets over five years (exercise 48).

## Method

With cash flows in the rows of $C$, payment dates $t$ and evaluation date $t_0$:

$$
v = (1 + \tilde{i})^{-(t - t_0)}, \qquad NPV = C\, v^\top, \qquad
D = \frac{C\,\big((t - t_0) \circ v\big)^\top}{NPV}
$$

## Code

=== "MATLAB"

    === "S_exercise_48.m"

        ```matlab
        --8<-- "computational-finance/part-1/bond-npv-and-duration/S_exercise_48.m"
        ```

    === "F_es47.m"

        ```matlab
        --8<-- "computational-finance/part-1/bond-npv-and-duration/F_es47.m"
        ```

=== "Python"

    === "S_exercise_48.py"

        ```python
        --8<-- "computational-finance/part-1/bond-npv-and-duration/S_exercise_48.py"
        ```

    === "F_es47.py"

        ```python
        --8<-- "computational-finance/part-1/bond-npv-and-duration/F_es47.py"
        ```

## Results

Rate curve: 5.0%, 4.6%, 4.4%, 4.9%, 5.2% for years 1 to 5.

| Asset | Cash flows | NPV | Duration |
|---|---|---:|---:|
| 7% bond, 5 years | 7, 7, 7, 7, 107 | 108.04 | 4.41 |
| 6% bond, 4 years | 6, 6, 6, 106 | 104.01 | 3.68 |
| Zero-coupon, 3 years | 100 at year 3 | 87.88 | 3.00 |
| Zero-coupon, 5 years | 100 at year 5 | 77.61 | 5.00 |

## Takeaways

- One matrix product values all the assets together: each row of $C$ is an asset.
- The zero-coupon bonds confirm the formula: their duration equals their maturity.
- Higher coupons shorten duration, because more of the value arrives early.
