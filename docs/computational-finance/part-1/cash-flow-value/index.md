# Value of a cash flow stream over time

<p class="ex-meta">Course exercise 46 · Part I</p>

## Problem

Write a function that values a stream of cash flows at any evaluation date, then apply it to a
three-year bond paying 5, 5 and 105, valued at $t = 0, 1, 2, 3$: first with a flat 5% rate,
then with a rate for each payment date.

## Method

The value at time $t$ of flows $F_k$ paid at dates $s_k$ discounts the flows after $t$ and
compounds those before it:

$$
V(t) = \sum_k F_k\,(1 + i_k)^{-(s_k - t)}
$$

The function accepts either one rate (flat curve) or one rate per payment date, and stops
with a message if the curve does not match the schedule.

## Code

=== "S_exercise_46.m"

    ```matlab
    --8<-- "computational-finance/part-1/cash-flow-value/S_exercise_46.m"
    ```

## Results

| Evaluation time | Flat 5% | Rates 3.7%, 4.2%, 5.1% |
|---|---:|---:|
| 0 | 100.0000 | 99.8709 |
| 1 | 105.0000 | 104.8554 |
| 2 | 110.2500 | 110.0899 |
| 3 | 115.7625 | 115.5868 |

## Takeaways

- With a flat 5% rate a 5% coupon bond is worth exactly par today, and its value grows at 5%
  a year: 100, 105, 110.25, 115.76.
- The same function covers present value ($t = 0$) and future value ($t$ after the last
  flow): the sign of the exponent does the work.
- With several rates, each flow keeps the rate of its own payment date whatever the
  evaluation date. That is the simplification the exercise asks for; a fully consistent
  valuation at $t > 0$ would use forward rates.
