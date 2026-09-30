# Loan amortization: French and Italian schedules

<p class="ex-meta">Course exercises 50–52 · Part I</p>

## Problem

A loan of 140,000 is repaid in 20 half-yearly payments at an annual rate of 5.7%. Build the
full amortization schedule for the two standard methods: French (constant installment) and
Italian (constant principal). Exercises 50 and 51 build each schedule separately; exercise 52
brings both into one function, which is the version shown here.

## Method

Payments are half-yearly, so the annual rate is first converted:
$i_{sa} = (1 + 0.057)^{1/2} - 1 = 2.8105\%$.

**French:** the installment $R$ is constant, $R = S \,/\, a_{\overline{n}|}$ with
$a_{\overline{n}|} = v\,\frac{1 - v^n}{1 - v}$. Each period the interest is $I_k = i\,D_{k-1}$,
the principal repaid is $C_k = R - I_k$, and the residual debt is $D_k = D_{k-1} - C_k$.

**Italian:** the principal is constant, $C = S / n$. The interest $I_k = i\,D_{k-1}$ falls as
the debt falls, so the installment $R_k = C + I_k$ falls too.

## Code

=== "S_exercise_52.m"

    ```matlab
    --8<-- "computational-finance/part-1/loan-amortization/S_exercise_52.m"
    ```

## Results

| | French | Italian |
|---|---:|---:|
| First installment | 9,246.11 | 10,934.71 |
| Last installment | 9,246.11 | 7,196.74 |
| Principal per period | 5,311.40 → 8,993.35 | 7,000.00 |
| Total interest paid | 44,922.18 | 41,314.43 |

??? example "Full schedules (period, installment, principal, interest, residual debt)"

    **French**

    ```text
     0          0.00        0.00        0.00   140000.00
     1       9246.11     5311.40     3934.71   134688.60
     2       9246.11     5460.68     3785.43   129227.92
     3       9246.11     5614.15     3631.96   123613.77
     4       9246.11     5771.94     3474.17   117841.83
     5       9246.11     5934.16     3311.95   111907.67
     6       9246.11     6100.94     3145.17   105806.74
     7       9246.11     6272.41     2973.70    99534.33
     8       9246.11     6448.69     2797.42    93085.64
     9       9246.11     6629.93     2616.18    86455.71
    10       9246.11     6816.27     2429.84    79639.44
    11       9246.11     7007.84     2238.27    72631.60
    12       9246.11     7204.79     2041.32    65426.81
    13       9246.11     7407.29     1838.82    58019.52
    14       9246.11     7615.47     1630.64    50404.06
    15       9246.11     7829.50     1416.61    42574.56
    16       9246.11     8049.55     1196.56    34525.01
    17       9246.11     8275.78      970.33    26249.22
    18       9246.11     8508.37      737.74    17740.85
    19       9246.11     8747.50      498.61     8993.35
    20       9246.11     8993.35      252.76        0.00
    ```

    **Italian**

    ```text
     0          0.00        0.00        0.00   140000.00
     1      10934.71     7000.00     3934.71   133000.00
     2      10737.97     7000.00     3737.97   126000.00
     3      10541.24     7000.00     3541.24   119000.00
     4      10344.50     7000.00     3344.50   112000.00
     5      10147.77     7000.00     3147.77   105000.00
     6       9951.03     7000.00     2951.03    98000.00
     7       9754.30     7000.00     2754.30    91000.00
     8       9557.56     7000.00     2557.56    84000.00
     9       9360.82     7000.00     2360.82    77000.00
    10       9164.09     7000.00     2164.09    70000.00
    11       8967.35     7000.00     1967.35    63000.00
    12       8770.62     7000.00     1770.62    56000.00
    13       8573.88     7000.00     1573.88    49000.00
    14       8377.15     7000.00     1377.15    42000.00
    15       8180.41     7000.00     1180.41    35000.00
    16       7983.68     7000.00      983.68    28000.00
    17       7786.94     7000.00      786.94    21000.00
    18       7590.21     7000.00      590.21    14000.00
    19       7393.47     7000.00      393.47     7000.00
    20       7196.74     7000.00      196.74        0.00
    ```

## Takeaways

- The rate must match the payment frequency: using 5.7% on half-yearly periods would roughly
  double the interest.
- Both schedules repay the same debt at the same rate. The Italian one costs less interest
  because it repays principal faster at the start, but its first installments are higher.
- In both, the residual debt reaching exactly zero at period 20 is the check that the
  schedule is right.
