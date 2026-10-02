# Customers, orders and instalments

<p class="ex-meta">SQL exercises · Part I</p>

## Problem

Three relations given **with their data**: **persons**, their **orders**, and the
**instalments** issued for each order (amount, due date, payment date, which is null when the
instalment is still unpaid). Every order belongs to a person and every instalment to an order.
Write six queries.

## Schema and test data

=== "schema.sql"

    ```sql
    --8<-- "databases/part-1/orders-and-instalments/schema.sql"
    ```

=== "test_data.sql"

    ```sql
    --8<-- "databases/part-1/orders-and-instalments/test_data.sql"
    ```

Here the test data are the ones shown in the exercise.

## Queries

### Query 1 · Persons with no orders

Tax code, name and surname of the persons who have no order, ordered by tax code.

```sql
--8<-- "databases/part-1/orders-and-instalments/q1.sql"
```

--8<-- "databases/part-1/orders-and-instalments/results/q1.txt"

### Query 2 · Number of orders per person

For each person, the number of orders, showing 0 for those who have none. Two attributes:
tax code and number of orders, ordered by tax code.

```sql
--8<-- "databases/part-1/orders-and-instalments/q2.sql"
```

--8<-- "databases/part-1/orders-and-instalments/results/q2.txt"

### Query 3 · Total of the instalments of each order

For each order with instalments, the total amount of its instalments. Two attributes, order
and total, with increasing values of order.

```sql
--8<-- "databases/part-1/orders-and-instalments/q3.sql"
```

--8<-- "databases/part-1/orders-and-instalments/results/q3.txt"

### Query 4 · Total, paid and debt of each order

For each order with instalments: the total issued, the total paid, and the debt (the
difference). Assume every such order has at least one paid instalment. Four attributes,
ordered by order.

```sql
--8<-- "databases/part-1/orders-and-instalments/q4.sql"
```

--8<-- "databases/part-1/orders-and-instalments/results/q4.txt"

### Query 5 · The order with the largest debt

Code, customer, description and debt of the order with the largest debt computed in Query 4.

```sql
--8<-- "databases/part-1/orders-and-instalments/q5.sql"
```

--8<-- "databases/part-1/orders-and-instalments/results/q5.txt"

### Query 6 · Persons with at least one order

Tax code, name and surname of the persons with at least one order, ordered by tax code.

```sql
--8<-- "databases/part-1/orders-and-instalments/q6.sql"
```

--8<-- "databases/part-1/orders-and-instalments/results/q6.txt"

!!! note "Review notes"
    All six queries return the right rows. Three of them miss the ordering the text asks for:
    Query 3 and Query 4 (`ORDER BY C1.ordine`) and Query 6 (`ORDER BY C1.CF`). On SQLite
    the result comes out sorted anyway, as a side effect of how `GROUP BY` is computed, but
    SQL does not guarantee any order without `ORDER BY`.

    Two simplifications are possible: the `LEFT JOIN ordini` in the view of paid amounts
    adds nothing (only columns of `rateemesse` are used), and Query 6 is simply an inner join
    with `DISTINCT`, without `GROUP BY` and `HAVING`.

## Takeaways

- A null payment date marks an unpaid instalment: `WHERE datapagamento IS NOT NULL` before
  summing gives the amount paid.
- Building the debt in steps (total, paid, difference) with views keeps each query small and
  checkable on its own.
- Without `ORDER BY` there is no guaranteed order, whatever the result looks like.
