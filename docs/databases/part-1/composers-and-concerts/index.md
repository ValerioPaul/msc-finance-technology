# Composers, pieces and concerts

<p class="ex-meta">SQL exercises · Part I</p>

## Problem

A database of **composers**, the **pieces** they wrote and the **concerts** in which pieces
are played (`Programmazione` says which piece is played in which concert, and in which
position). Write four queries on it.

## Schema and test data

=== "schema.sql"

    ```sql
    --8<-- "databases/part-1/composers-and-concerts/schema.sql"
    ```

=== "test_data.sql"

    ```sql
    --8<-- "databases/part-1/composers-and-concerts/test_data.sql"
    ```

The schema is the one given in the exercise; the test data are mine.

## Queries

### Query 1 · Long pieces by composers named Rossi

Find the pieces longer than 5 whose author is a composer with surname `'Rossi'`. Show the
composer's code and the code, title and length of the piece; order by composer and piece.

```sql
--8<-- "databases/part-1/composers-and-concerts/q1.sql"
```

--8<-- "databases/part-1/composers-and-concerts/results/q1.txt"

### Query 2 · Pieces never played

Find code and title of the pieces that are not in any concert, ordered by code.

```sql
--8<-- "databases/part-1/composers-and-concerts/q2.sql"
```

--8<-- "databases/part-1/composers-and-concerts/results/q2.txt"

The anti-join pattern: an outer join, then keep the rows where the optional side is missing.

### Query 3 · Distinct pieces played, per composer

For each composer, the number of different pieces played in at least one concert. Ignore
composers with no piece played; show code, surname, name and number of pieces.

```sql
--8<-- "databases/part-1/composers-and-concerts/q3.sql"
```

--8<-- "databases/part-1/composers-and-concerts/results/q3.txt"

`COUNT(DISTINCT C3.pezzo)` counts a piece once even when it is played in several concerts
(Overture A is in both). The inner joins drop the composers with nothing played, as required.

### Query 4 · Composers with the most pieces played

Find the composer (or composers) with the largest number of different pieces played, as
computed in Query 3. Show code, name, surname and number of pieces; order by code.

```sql
--8<-- "databases/part-1/composers-and-concerts/q4.sql"
```

--8<-- "databases/part-1/composers-and-concerts/results/q4.txt"

## Takeaways

- "Not in any…" is an outer join filtered on `IS NULL` (or a `NOT IN` / `NOT EXISTS`).
- `COUNT(DISTINCT …)` when the joins can repeat the thing being counted.
- Reusing a query as a view keeps the "maximum" query short and readable.
