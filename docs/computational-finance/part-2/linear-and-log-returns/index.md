# Linear and logarithmic returns

<p class="ex-meta">Course exercise 117 · Part II</p>

## Problem

From a series of ten prices, compute linear and logarithmic returns, once with vectorised
operations and once with a loop.

## Method

$$
R^{lin}_t = \frac{P_t - P_{t-1}}{P_{t-1}}, \qquad
R^{log}_t = \ln P_t - \ln P_{t-1} = \ln\!\left(1 + R^{lin}_t\right)
$$

## Code

=== "S_exercise_117.m"

    ```matlab
    --8<-- "computational-finance/part-2/linear-and-log-returns/S_exercise_117.m"
    ```

## Results

| Price | 10.3 | 10.7 | 12.0 | 14.2 | 14.9 | 19.0 | 10.4 | 16.0 | 8.5 |
|---|---|---|---|---|---|---|---|---|---|
| Linear | 3.00% | 3.88% | 12.15% | 18.33% | 4.93% | 27.52% | −45.26% | 53.85% | −46.88% |
| Log | 2.96% | 3.81% | 11.47% | 16.83% | 4.81% | 24.31% | −60.26% | 43.08% | −63.25% |

The loop and the vectorised version give identical results.

## Takeaways

- For small moves the two returns are almost equal; for large ones they diverge, and the log
  return is always the smaller of the two.
- Log returns add up over time ($\sum R^{log}_t = \ln P_T / P_0$); linear returns add up across
  assets in a portfolio. Each has its use.
- `diff(P) ./ P(1:end-1)` replaces the whole loop, and there is one return fewer than prices.
