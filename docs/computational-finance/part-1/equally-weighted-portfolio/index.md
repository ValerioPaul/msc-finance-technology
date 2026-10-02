# Expected return and variance of an equally weighted portfolio

<p class="ex-meta">Course exercise 32 · Part I</p>

## Problem

Five stocks have expected returns $\mu$ and a given variance-covariance matrix $\Sigma$. Build
the equally weighted portfolio and compute its expected return and variance.

## Method

With $n$ stocks the equally weighted portfolio puts $x_i = 1/n$ in each. Then:

$$
\mathbb{E}[R_p] = \mu\, x, \qquad \sigma^2_p = x^\top \Sigma\, x
$$

## Code

=== "MATLAB"

    === "S_exercise_32.m"

        ```matlab
        --8<-- "computational-finance/part-1/equally-weighted-portfolio/S_exercise_32.m"
        ```

=== "Python"

    === "S_exercise_32.py"

        ```python
        --8<-- "computational-finance/part-1/equally-weighted-portfolio/S_exercise_32.py"
        ```

## Results

| | Value |
|---|---:|
| Weights | 20% each |
| Expected return | 9.80% |
| Variance | 0.0520 (volatility 22.8%) |

!!! note "The covariance matrix in the exercise is not a valid one"
    A covariance matrix must be positive semi-definite. This one has a negative eigenvalue
    (−0.67): the covariance between stocks 1 and 5 is −0.70, while their variances (0.10 and
    0.40) allow at most $\sqrt{0.10 \cdot 0.40} = 0.20$ in absolute value, an implied correlation
    of −3.5. The equally weighted portfolio still gets a positive variance, but other weight
    vectors would get a negative one. The code is correct; the input data are not.

## Takeaways

- Expected return is linear in the weights; variance is quadratic, which is where
  diversification comes from.
- Before trusting a portfolio variance, check that $\Sigma$ is positive semi-definite
  (`eig(Sigma)` must have no negative values).
