# Discount factors, present value and duration

<p class="ex-meta">Course exercises 44–45 · Part I</p>

## Problem

On a half-yearly schedule up to five years, build the discount factors for a flat 2% rate and
for an upward-sloping rate curve (exercise 44). Then, for five assets whose cash flows are
stored in `Exercise_17.mat`, compute present value and duration under both curves, and the
duration of a portfolio of them (exercise 45).

## Method

$$
v(t) = (1 + i(t))^{-t}, \qquad PV = C\, v^\top, \qquad
D = \frac{C\,(t \circ v)^\top}{C\, v^\top}
$$

where each row of $C$ is one asset's cash flows. For a portfolio with quantities $q$, the
same formula applies to the combined flows $q\,C$.

The five assets are: a zero-coupon bond at 6 months, one at 1 year, and bonds with
half-yearly coupons maturing at 2, 3 and 5 years.

## Code

=== "MATLAB"

    === "S_exercise_44.m"

        ```matlab
        --8<-- "computational-finance/part-1/discount-factors-and-duration/S_exercise_44.m"
        ```

    === "S_exercise_45.m"

        ```matlab
        --8<-- "computational-finance/part-1/discount-factors-and-duration/S_exercise_45.m"
        ```

=== "Python"

    === "S_exercise_44.py"

        ```python
        --8<-- "computational-finance/part-1/discount-factors-and-duration/S_exercise_44.py"
        ```

    === "S_exercise_45.py"

        ```python
        --8<-- "computational-finance/part-1/discount-factors-and-duration/S_exercise_45.py"
        ```

## Results

| Asset | PV, flat 2% | PV, curve | Duration, flat | Duration, curve |
|---|---:|---:|---:|---:|
| ZCB 6 months | 99.01 | 99.60 | 0.50 | 0.50 |
| ZCB 1 year | 98.04 | 99.01 | 1.00 | 1.00 |
| Bond 2 years | 98.07 | 98.46 | 1.99 | 1.98 |
| Bond 3 years | 98.58 | 95.58 | 2.94 | 2.94 |
| Bond 5 years | 100.52 | 89.07 | 4.77 | 4.75 |

Portfolio duration: **1.95** years with the flat rate, **1.91** with the curve.

## Takeaways

- A zero-coupon bond's duration is its maturity; coupons pull the duration below maturity.
- The curve is below 2% at short maturities and above it at long ones, so it raises the value
  of short assets and cuts the 5-year bond from 100.52 to 89.07.
- Portfolio duration is the value-weighted average of the assets' durations, which is why it
  can be computed on the combined cash flows in one step.
