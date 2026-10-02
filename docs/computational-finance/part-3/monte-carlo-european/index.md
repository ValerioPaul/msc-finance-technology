# Pricing European options by Monte Carlo

<p class="ex-meta">Course exercise 179 · Part III</p>

## Problem

Price a one-year European call and put, at the money ($S_0 = K = 100$), with $r = 5\%$ and
$\sigma = 20\%$, by simulating 10,000 prices at maturity, and compare with the closed form.

## Method

Under the risk-neutral measure the price at maturity is log-normal with drift $r$:

$$
S_T = S_0 \exp\!\Big(\big(r - \tfrac12\sigma^2\big)T + \sigma\sqrt{T}\,Z\Big), \qquad
C \approx e^{-rT}\,\frac{1}{n}\sum_{i=1}^{n}\max\big(S_T^{(i)} - K,\ 0\big)
$$

and the same for the put. Only one draw per path is needed, because the payoff depends on the
final price alone.

## Code

=== "MATLAB"

    === "S_exercise_179.m"

        ```matlab
        --8<-- "computational-finance/part-3/monte-carlo-european/S_exercise_179.m"
        ```

=== "Python"

    === "S_exercise_179.py"

        ```python
        --8<-- "computational-finance/part-3/monte-carlo-european/S_exercise_179.py"
        ```


!!! note "Two variable names restored"
    In the saved version of this script, two lines had lost their variable name and read
    ` = 100;` and ` = 0.05;`, so the file stopped with a syntax error at line 9. They are
    restored here as `K = 100;` and `r = 0.05;`, the names the call to `F_MonteCarlo` on the
    next line requires. Nothing else is changed.

## Results

| | Monte Carlo, 10,000 draws | Black–Scholes |
|---|---:|---:|
| Call | 10.3871 | 10.4506 |
| Put | 5.5059 | 5.5735 |

One simulated run, random seed 0. With 10,000 draws the standard error of the call price is
about 0.15, so the gap from the closed form is within one standard error.

## Takeaways

- Monte Carlo converges slowly: the error falls as $1/\sqrt{n}$, so one more correct digit
  costs a hundred times more simulations.
- Its strength is flexibility, not speed: the same code prices any payoff that depends on the
  final price, and with full paths it handles path-dependent ones, as on
  [the next page](../asian-option/index.md).
- Pricing uses the risk-free rate as drift, not the expected return of the stock: that is what
  makes the discounted expectation a price.
