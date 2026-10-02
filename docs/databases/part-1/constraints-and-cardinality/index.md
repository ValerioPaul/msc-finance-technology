# Integrity constraints and cardinality of relational expressions

<p class="ex-meta">Exam questions · Part I</p>

## Problem

Two kinds of short exam questions, solved without a computer:

1. **CHECK constraints.** Given four instances of the same relation and three `CHECK`
   constraints, say for each constraint which instances satisfy it (exam of 4 July 2025).
2. **Cardinality.** Given three relations with their keys, foreign keys and sizes, give the
   minimum and maximum number of tuples in the result of joins and projections, in symbols and
   in numbers (six exercises, including the exams of 19 June and 2 September 2025).

## Method

**CHECK constraints.** A relation satisfies a constraint when the condition is true for
**every** tuple: one tuple that makes it false is enough to violate it.

**Cardinality.** Everything depends on whether the attributes involved form a key and on
the foreign keys between relations:

| Expression | Condition | Min | Max |
|---|---|---|---|
| $R \bowtie S$ on a foreign key of $R$ towards the **whole** key of $S$ | every tuple of $R$ finds exactly one tuple of $S$ | $\lvert R\rvert$ | $\lvert R\rvert$ |
| $R \bowtie S$ on attributes equal to the key of $S$, with no foreign key | a tuple of $R$ finds at most one tuple of $S$ | $0$ | $\lvert R\rvert$ |
| $R \bowtie S$ on attributes that are not a key of either relation | any tuple can match any other | $0$ | $\lvert R\rvert \cdot \lvert S\rvert$ |
| $\pi_X(R)$ with $X$ containing a key | no duplicates can disappear | $\lvert R\rvert$ | $\lvert R\rvert$ |
| $\pi_X(R)$ with $X$ not containing a key | duplicates can collapse | $1$ | $\lvert R\rvert$ |

## The CHECK question

Four instances of `PAGHE(ID, StipLordo, Ritenute, StipNetto, OK)`, all with the same three
salaries. The net salary equals gross minus deductions in rows 1 and 2, not in row 3; the
column `OK` differs:

| Instance | OK, row 1 | OK, row 2 | OK, row 3 |
|---|---|---|---|
| A | true | true | true |
| B | true | true | false |
| C | true | false | false |
| D | false | false | false |

The three constraints:

- **C1** · `NOT(StipNetto = StipLordo - Ritenute) OR OK = 'true'`
- **C2** · `(StipNetto = StipLordo - Ritenute AND OK = 'true') OR (StipNetto <> StipLordo - Ritenute AND OK = 'false')`
- **C3** · `NOT(OK = 'true') OR StipNetto = StipLordo - Ritenute`

| Constraint | A | B | C | D |
|---|---|---|---|---|
| C1: if the formula holds, OK is true | yes | yes | no | no |
| C2: OK is true exactly when the formula holds | no | yes | no | no |
| C3: if OK is true, the formula holds | no | yes | yes | yes |

All twelve answers are correct: only instance B marks every row consistently with the
formula, which is why it is the only one that satisfies the second constraint.

## The cardinality questions

The six exercises share the same structure: $R_1(\underline{A}, B)$ with a foreign key from $B$
to the key $D$ of $R_2$; $R_2(\underline{D}, E, F, G)$ with a foreign key from $F, G$ to the key
$H, P$ of $R_3$; $R_3(\underline{H}, \underline{P}, Q)$. Exercise 5 adds an attribute $C$ to
$R_1$; exercise 6 changes the keys, as described there.

??? example "Exercise 1 — $N_1 = 1000$, $N_2 = 400$, $N_3 = 500$"

    | Expression | Min | Max | Values |
    |---|---|---|---|
    | $(R_1 \bowtie_{B=D} R_2) \bowtie_{F=H \wedge G=P} R_3$ | $N_1$ | $N_1$ | 1000 – 1000 |
    | $R_2 \bowtie_{F=H \wedge G=P} R_3$ | $N_2$ | $N_2$ | 400 – 400 |
    | $R_1 \bowtie_{B=P} R_3$ | $0$ | $N_1 N_3$ | 0 – 500,000 |
    | $\pi_{EF}(R_2)$ | $1$ | $N_2$ | 1 – 400 |

??? example "Exercise 2 — $L_1 = 1000$, $L_2 = 400$, $L_3 = 500$"

    | Expression | Min | Max | Values |
    |---|---|---|---|
    | $R_1 \bowtie_{B=D} R_2$ | $L_1$ | $L_1$ | 1000 – 1000 |
    | $(R_1 \bowtie_{B=D} R_2) \bowtie_{F=H \wedge G=P} R_3$ | $L_1$ | $L_1$ | 1000 – 1000 |
    | $\pi_{HP}(R_3)$ | $L_3$ | $L_3$ | 500 – 500 |
    | $R_3 \bowtie_{Q=A} R_1$ | $0$ | $L_3$ | 0 – 500 |

??? example "Exercise 3 — exam of 2 September 2025: $M_1 = 100$, $M_2 = 600$, $M_3 = 300$"

    | Expression | Min | Max | Values |
    |---|---|---|---|
    | $R_3 \bowtie_{Q=A} R_1$ | $0$ | $M_3$ | 0 – 300 |
    | $\pi_{HP}(R_3)$ | $M_3$ | $M_3$ | 300 – 300 |
    | $R_1 \bowtie_{B=D} R_2$ | $M_1$ | $M_1$ | 100 – 100 |
    | $(R_1 \bowtie_{B=D} R_2) \bowtie_{F=H} R_3$ | $M_1$ | $M_1$ ⚠ | 100 – 100 ⚠ |

??? example "Exercise 4 — exam of 19 June 2025: $L_1 = 100$, $L_2 = 600$, $L_3 = 300$"

    | Expression | Min | Max | Values |
    |---|---|---|---|
    | $R_1 \bowtie_{B=D} R_2$ | $L_1$ | $L_1$ | 100 – 100 |
    | $(R_1 \bowtie_{B=D} R_2) \bowtie_{F=H} R_3$ | $L_1$ | $L_1$ ⚠ | 100 – 100 ⚠ |
    | $\pi_{HP}(R_3)$ | $L_3$ | $L_3$ | 300 – 300 |
    | $R_3 \bowtie_{Q=A} R_1$ | $0$ | $L_3$ | 0 – 300 |

??? example "Exercise 5 — $R_1(\underline{A}, B, C)$, $N_1 = 100$, $N_2 = 40$, $N_3 = 50$"

    | Expression | Min | Max | Values |
    |---|---|---|---|
    | $\pi_{AC}(R_1)$ | $N_1$ | $N_1$ | 100 – 100 |
    | $\pi_{BC}(R_1)$ | $1$ | $N_1$ | 1 – 100 |
    | $R_3 \bowtie_{Q=A} R_1$ | $0$ | $N_3$ | 0 – 50 |
    | $R_2 \bowtie_{F=H \wedge G=P} R_3$ | $N_2$ | $N_2$ | 40 – 40 |
    | $(R_1 \bowtie_{B=D} R_2) \bowtie_{F=H} R_3$ | $N_1$ | $N_1$ ⚠ | 100 – 100 ⚠ |

??? example "Exercise 6 — keys changed: $C_1 = 1000$, $C_2 = 200$, $C_3 = 500$"

    $R_1(\underline{A}, B, C)$ with a foreign key from $B, C$ to the key $D, E$ of $R_2$;
    $R_2(\underline{D}, \underline{E}, F)$ with a foreign key from $F$ to the key of $R_3$;
    $R_3(\underline{G}, H, I)$.

    | Expression | Min | Max | Values |
    |---|---|---|---|
    | $(R_1 \bowtie_{B=D} R_2) \bowtie_{F=G} R_3$ | $C_1$ | $C_1$ ⚠ | 1000 – 1000 ⚠ |
    | $R_1 \bowtie_{B=D \wedge C=E} R_2$ | $C_1$ | $C_1$ | 1000 – 1000 |
    | $R_1 \bowtie_{C=G} R_3$ | $0$ | $C_1$ | 0 – 1000 |

!!! note "Review note: joins on part of a composite key (⚠)"
    Every answer above follows the rules correctly except one case, which comes back four
    times: a join on **only part** of a composite key.

    In $(R_1 \bowtie_{B=D} R_2) \bowtie_{F=H} R_3$ the key of $R_3$ is $(H, P)$, but the join
    uses only $H$. The foreign key from $(F, G)$ guarantees at least one matching tuple, so
    the minimum is indeed $|R_1|$; but other tuples of $R_3$ can share the same $H$ with a
    different $P$, so one tuple can match many. The maximum is $|R_1| \cdot |R_3|$:

    | Exercise | Answer given | Correct range |
    |---|---|---|
    | 3 | 100 – 100 | 100 – 30,000 |
    | 4 | 100 – 100 | 100 – 30,000 |
    | 5 | 100 – 100 | 100 – 5,000 |
    | 6 | 1000 – 1000 | 1000 – 200,000 |

    In exercise 6 the partial key is in the first join ($B = D$, with key $(D, E)$); the second
    join, on the full key $G$, does not change the range.

## Takeaways

- A join along a foreign key that references the **whole** key never changes the number of
  tuples; drop part of the key from the condition and the upper bound jumps to a product.
- A projection keeps every tuple only if the projected attributes contain a key.
- A CHECK constraint is a universal statement: it is the rows that break it that matter.
