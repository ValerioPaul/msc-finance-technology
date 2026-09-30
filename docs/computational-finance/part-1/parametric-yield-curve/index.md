# Present value on a parametric yield curve

<p class="ex-meta">Course exercise 53 · Part I</p>

## Problem

The yield curve is given by a quadratic function of maturity. Use it to price a five-year
bond paying an annual 6% coupon.

## Method

The yield to maturity at date $s$ and the corresponding annual rate are:

$$
h(s) = \alpha + \beta s + \gamma s^2, \qquad i(s) = e^{h(s)} - 1
$$

with $\alpha = 0.0024$, $\beta = 0.0097$, $\gamma = 0.0033$. The price is
$\sum_k F_k\,(1 + i(s_k))^{-s_k}$.

## Code

=== "S_exercise_53.m"

    ```matlab
    --8<-- "computational-finance/part-1/parametric-yield-curve/S_exercise_53.m"
    ```

## Results

Present value: **75.02**.

The curve rises steeply: the annual rate is 1.55% at 1 year and 14.27% at 5 years, so the
final payment of 106 is discounted heavily.

## Takeaways

- A parametric curve gives a rate for any maturity with three numbers; the quadratic term
  dominates at long maturities.
- A 6% bond priced at 75 is consistent with the curve: at 5 years the rate is far above the
  coupon.
