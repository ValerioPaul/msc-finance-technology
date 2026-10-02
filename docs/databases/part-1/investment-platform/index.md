# Investment platform: clients, accounts and orders

<p class="ex-meta">SQL exercises · Part I</p>

## Problem

A database of an investment platform: **clients** hold one or more **accounts**, and every
**order** buys a quantity of an **asset** (stock, bond, crypto…) on an account. Write four
queries: clients with large orders, crypto bought by high-risk clients, the number of orders
of each client, and the clients with the most orders.

## Schema and test data

=== "schema.sql"

    ```sql
    --8<-- "databases/part-1/investment-platform/schema.sql"
    ```

=== "test_data.sql"

    ```sql
    --8<-- "databases/part-1/investment-platform/test_data.sql"
    ```

The exercise names the tables but does not define them: the schema contains the columns the
queries use. The test data are mine, written to try the queries, not part of the exercise.

## Queries

### Query 1 · Clients with an order above 40 units

Return ID, name and email of the clients with at least one order of more than 40 units,
ordered by ID.

```sql
--8<-- "databases/part-1/investment-platform/q1.sql"
```

--8<-- "databases/part-1/investment-platform/results/q1.txt"

`DISTINCT` matters: a client with two large orders would otherwise appear twice.

### Query 2 · Crypto assets bought by high-risk clients

Return ticker, name and category of the assets in category `'Crypto'` bought by clients with
risk profile `'alto'`, with the quantity ordered, ordered by ticker.

```sql
--8<-- "databases/part-1/investment-platform/q2.sql"
```

--8<-- "databases/part-1/investment-platform/results/q2.txt"

!!! note "Two details to fix"
    The text writes the category as `'Crypto'`, the query as `'crypto'`. In SQLite and
    PostgreSQL string comparison is case-sensitive, so the query finds nothing; MySQL, with
    its default collation, would ignore the difference. With `'Crypto'` the query returns
    BTC (50) and ETH (45). The text also asks to order by ticker: `ORDER BY c4.ticker` is
    missing.

### Query 3 · Number of orders of each client

For every client, return ID, name, email and the total number of orders, showing 0 for clients
who never ordered; order by ID.

```sql
--8<-- "databases/part-1/investment-platform/q3.sql"
```

--8<-- "databases/part-1/investment-platform/results/q3.txt"

Both joins must be `LEFT JOIN`, and the count must be on `c3.id_ordine`: `COUNT(*)` would
give 1 to a client without orders, because the outer join still produces one row for them.

### Query 4 · Clients with the most orders

Return ID, name and email of the client (or clients, in case of a tie) with the largest number
of orders, ordered by ID.

```sql
--8<-- "databases/part-1/investment-platform/q4.sql"
```

--8<-- "databases/part-1/investment-platform/results/q4.txt"

The view counts the orders once; the outer query compares each client with the maximum of
that count, so ties are kept.

## Takeaways

- Counting with an outer join: count a column of the optional table, not `*`.
- "The maximum, ties included" is a comparison with `(SELECT MAX(...))`, not `ORDER BY ...
  LIMIT 1`.
- String literals must match the data exactly where comparison is case-sensitive.
