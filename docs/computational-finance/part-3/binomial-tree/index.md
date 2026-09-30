# Pricing European options with a binomial tree

<p class="ex-meta">Course exercise 165 · Part III</p>

## Problem

Price a one-year European call and put, at the money ($S_0 = K = 100$), with a 5% annual rate
and 20% volatility, on a recombining binomial tree with 50 steps. Check the result with
put-call parity.

## Method

The Cox–Ross–Rubinstein tree moves the price up by $u$ or down by $d$ at each step of length
$\Delta t = T/N$:

$$
u = e^{\sigma\sqrt{\Delta t}}, \qquad d = \frac{1}{u}, \qquad
q = \frac{e^{r\Delta t} - d}{u - d}, \qquad r = \ln(1 + i)
$$

where $q$ is the risk-neutral probability of an up move. At maturity the option is worth its
payoff at each of the $N + 1$ nodes; then the value is rolled back one step at a time as the
discounted risk-neutral expectation:

$$
V_{j,k} = e^{-r\Delta t}\,\big(q\,V_{j+1,k+1} + (1 - q)\,V_{j+1,k}\big)
$$

The value at the root is the price. Put-call parity, $P = C - S_0 + K e^{-rT}$, gives an
independent check of the put.

## Code

=== "S_exercise_165.m"

    ```matlab
    --8<-- "computational-finance/part-3/binomial-tree/S_exercise_165.m"
    ```

## Results

| | Binomial tree, 50 steps | Black–Scholes | Put-call parity |
|---|---:|---:|---:|
| Call | 10.3464 | 10.3863 | |
| Put | 5.5845 | 5.6244 | 5.5845 |

Black–Scholes is computed with the same continuously compounded rate, $r = \ln 1.05$.

## Takeaways

- The tree is a discrete approximation of Black–Scholes: with 50 steps it is 4 cents off, and
  the error shrinks roughly as $1/N$.
- Put-call parity holds exactly on the tree, whatever the number of steps, because both
  prices come from the same risk-neutral probabilities.
- The rate convention matters: the annual 5% becomes a continuous $\ln 1.05 = 4.88\%$ before
  it enters the tree.
- The backward procedure is what makes trees useful beyond European options: an American
  option only needs a comparison with the exercise value at each node.
