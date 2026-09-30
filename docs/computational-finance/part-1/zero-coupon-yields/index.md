# Yields of zero-coupon bonds

<p class="ex-meta">Course exercise 54 · Part I</p>

## Problem

Write a function that turns zero-coupon bond prices into annual yields, and apply it to five
bonds with maturities from 3 months to 2 years.

## Method

A zero-coupon bond pays 100 at maturity $T$, so its price $P$ implies the annual yield:

$$
P = 100\,(1 + i)^{-T} \quad\Longrightarrow\quad i = \left(\frac{100}{P}\right)^{1/T} - 1
$$

## Code

=== "S_exercise_54.m"

    ```matlab
    --8<-- "computational-finance/part-1/zero-coupon-yields/S_exercise_54.m"
    ```

## Results

| Maturity | Price | Annual yield |
|---|---:|---:|
| 3 months | 99.88 | 0.481% |
| 4 months | 99.85 | 0.451% |
| 6 months | 99.76 | 0.482% |
| 1 year | 99.24 | 0.766% |
| 2 years | 97.33 | 1.362% |

## Takeaways

- Yields must be annualised with the exponent $1/T$ to be comparable across maturities.
- The prices imply a slight dip at 4 months, then a rising curve.
