# Pricing an Asian option by Monte Carlo

<p class="ex-meta">Course exercise 180 · Part III</p>

## Problem

Price a six-month Asian call and put, whose payoff depends on the **average** price of the
underlying over the life of the option rather than on its final price. There is no simple
closed form: simulate one million paths of 100 steps each.

## Method

Under the risk-neutral measure the underlying follows a geometric Brownian motion with drift
$r$. For each simulated path the arithmetic average of the $m$ monitored prices is

$$
\bar{S} = \frac{1}{m}\sum_{k=1}^{m} S_{t_k}, \qquad
C = e^{-rT}\,\mathbb{E}\big[\max(\bar{S} - K,\ 0)\big], \qquad
P = e^{-rT}\,\mathbb{E}\big[\max(K - \bar{S},\ 0)\big]
$$

and the expectations are replaced by averages over the paths. Data: $S_0 = 36.64$, $K = 37$,
$r = 1.75\%$, $\sigma = 20\%$, $T = 0.5$, $m = 100$.

## Code

=== "MATLAB"

    === "S_exercise_180.m"

        ```matlab
        --8<-- "computational-finance/part-3/asian-option/S_exercise_180.m"
        ```

=== "Python"

    === "S_exercise_180.py"

        ```python
        --8<-- "computational-finance/part-3/asian-option/S_exercise_180.py"
        ```

## Results

| | Asian (Monte Carlo) | European with the same data (Black–Scholes) |
|---|---:|---:|
| Call | 1.1044 | 2.0478 |
| Put | 1.3012 | 2.0854 |

One simulated run, random seed 0.

## Takeaways

- The Asian options cost roughly half of the European ones: an average moves less than a
  single final price, so the payoff is less volatile and the option is worth less.
- Monte Carlo handles path-dependent payoffs with no extra effort: the paths are already
  simulated, only the payoff formula changes.
- The monitoring convention is part of the contract: this version averages the 100 prices
  after time zero; an earlier version of the same exercise averaged over a grid that included
  $S_0$ itself, which gives a slightly different price.
- One million paths of 100 steps means three $10^6 \times 100$ matrices in memory, several
  gigabytes: the price of vectorising everything.
