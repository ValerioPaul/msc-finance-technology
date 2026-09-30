# Bootstrapping discount factors from swap rates

<p class="ex-meta">Course exercises 58–59 · Part I</p>

## Problem

From the par rates of interest rate swaps with annual payments, recover the discount factors
for each maturity: first by solving a linear system (exercise 58), then with a reusable
function, a recursive formula, and the inverse step from discount factors back to swap rates
(exercise 59).

## Method

A par swap with rate $z_n$ and maturity $n$ has zero value, so for each maturity:

$$
z_n \sum_{k=1}^{n} v_k + v_n = 1
$$

Stacking the equations for $n = 1, \dots, N$ gives a lower-triangular system $A\,v = \mathbf{1}$,
with the swap rates below the diagonal and $1 + z_n$ on it. The same condition, solved one
maturity at a time, gives the recursion and its inverse:

$$
v_n = \frac{1 - z_n \sum_{k<n} v_k}{1 + z_n}, \qquad
z_n = \frac{1 - v_n}{\sum_{k \le n} v_k}
$$

## Code

=== "S_exercise_58.m"

    ```matlab
    --8<-- "computational-finance/part-1/swap-rate-bootstrapping/S_exercise_58.m"
    ```

=== "S_exercise_59.m"

    ```matlab
    --8<-- "computational-finance/part-1/swap-rate-bootstrapping/S_exercise_59.m"
    ```

=== "F_bootstrap.m"

    ```matlab
    --8<-- "computational-finance/part-1/swap-rate-bootstrapping/F_bootstrap.m"
    ```

## Results

| Maturity | Swap rate (ex. 58) | Discount factor | Swap rate (ex. 59) | Discount factor |
|---|---:|---:|---:|---:|
| 1 | 2.10% | 0.9794 | 1.85% | 0.9818 |
| 2 | 2.50% | 0.9517 | 2.23% | 0.9568 |
| 3 | 3.20% | 0.9091 | 2.97% | 0.9152 |
| 4 | 4.30% | 0.8417 | 3.13% | 0.8830 |

In exercise 58, $A\,v$ returns a vector of ones. In exercise 59 the recursion gives the same
discount factors as the linear system, and the inverse formula returns the original swap
rates.

## Takeaways

- Bootstrapping is a triangular linear system: each maturity only needs the shorter ones.
- `A \ b` solves the system directly and is the numerically preferred way; `inv(A) * b` gives
  the same result here but computes a full inverse that is not needed.
- Being able to go from rates to discount factors and back is the check that both formulas
  are right.
