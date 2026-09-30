# Linear, quadratic and nonlinear programming

<p class="ex-meta">Course exercises 112, 113, 115 · Part II</p>

## Problem

Solve three small optimisation problems with MATLAB's Optimization Toolbox, one per solver:
a linear program with `linprog`, a quadratic program with `quadprog`, and a nonlinear problem
with `fmincon` from two different starting points. These are the solvers behind every
efficient frontier in the rest of this part.

## Method

| Solver | Problem form | Exercise |
|---|---|---|
| `linprog` | $\min f^\top x$ s.t. $Ax \le b,\ x \ge 0$ | 112: $\min\, -5x_1 - 4x_2 - 6x_3$ |
| `quadprog` | $\min \tfrac12 x^\top H x + f^\top x$ s.t. $Ax \le b,\ x \ge 0$ | 113: $\min\, x_1^2 + x_2^2 - x_1x_2 - 2x_1 - 6x_2$ |
| `fmincon` | $\min f(x)$ s.t. $Ax \le b$ | 115: $\min\, x_1 x_2 x_3$ |

For `quadprog`, $H$ holds twice the coefficients of the squared terms on the diagonal and the
cross-term coefficient off the diagonal, placed symmetrically.

## Code

=== "S_exercise_112.m"

    ```matlab
    --8<-- "computational-finance/part-2/optimization-toolbox/S_exercise_112.m"
    ```

=== "S_exercise_113.m"

    ```matlab
    --8<-- "computational-finance/part-2/optimization-toolbox/S_exercise_113.m"
    ```

=== "S_exercise_115.m"

    ```matlab
    --8<-- "computational-finance/part-2/optimization-toolbox/S_exercise_115.m"
    ```

## Results

| Exercise | Solution | Objective |
|---|---|---:|
| 112, linear | $x = (0,\ 15,\ 3)$ | −78 |
| 113, quadratic | $x = (0.667,\ 1.333)$ | −8.00 |
| 115, from $x_0 = (2, 4, 8)$ | $x = (-28.38,\ 5.15,\ 3.24)$ | −472.6 |
| 115, from $x_0 = (-8, 0, -3)$ | $x = (-8.33,\ -16.67,\ -33.33)$ | −4,629.6 |

!!! note "Exercise 115 has no minimum at all"
    The code's closing comment reads the two results as two local minima with no global one.
    The stronger statement is that the problem is **unbounded below**. Take
    $x = (a,\ -(50 + 2.5a),\ a)$: both constraints hold for any $a > 0$ (the second one with
    equality), and the objective $-a^2(50 + 2.5a)$ goes to $-\infty$. For $a = 100$ it is
    already $-3{,}000{,}000$, far below both points `fmincon` returns. Each run stops at a
    point where the local optimality conditions hold, which is all a local solver can
    guarantee.

## Takeaways

- The three solvers differ in what they accept: linear objective, quadratic objective, or
  any smooth function. Portfolio problems are built to fit the first two, because those are
  solved to the global optimum.
- A nonlinear solver's answer depends on the starting point, and a "solution" can exist even
  when the problem has no minimum: checking boundedness is part of the modelling.
