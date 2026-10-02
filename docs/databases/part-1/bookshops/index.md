# Bookshops, books and availability

<p class="ex-meta">SQL exercises · Part I</p>

## Problem

A database of **books** (each of a **genre**), **bookshops**, and the **availability** of
each book in each bookshop, with the quantity in stock. Write four queries.

## Schema and test data

=== "schema.sql"

    ```sql
    --8<-- "databases/part-1/bookshops/schema.sql"
    ```

=== "test_data.sql"

    ```sql
    --8<-- "databases/part-1/bookshops/test_data.sql"
    ```

The schema is the one given in the exercise; the test data are mine.

## Queries

### Query 1 · Bookshops with a book under 20

ID, address and city of the bookshops that have at least one book with a cover price below 20,
ordered by bookshop ID.

```sql
--8<-- "databases/part-1/bookshops/q1.sql"
```

--8<-- "databases/part-1/bookshops/results/q1.txt"

!!! note "Duplicates and order"
    A bookshop appears once for every cheap book it stocks: each of the three appears twice
    in the test data. `SELECT DISTINCT` fixes it, and the requested `ORDER BY C1.id` is
    missing.

### Query 2 · Books above 12 available in Milan

Code, title, cover price and genre name of the books with a cover price above 12 available in
the bookshops of Milan, ordered by book code.

```sql
--8<-- "databases/part-1/bookshops/q2.sql"
```

--8<-- "databases/part-1/bookshops/results/q2.txt"

`DISTINCT` is used correctly here: a book stocked by two Milan bookshops would otherwise
appear twice. The requested `ORDER BY C1.codice` is missing.

### Query 3 · Books available in each bookshop

For each bookshop: ID, address, city and the number of books it has, showing 0 for a bookshop
with none; ordered by ID.

```sql
--8<-- "databases/part-1/bookshops/q3.sql"
```

--8<-- "databases/part-1/bookshops/results/q3.txt"

### Query 4 · The bookshop with the most books

ID, address and city of the bookshop (or bookshops) with the most books, ordered by ID.

```sql
--8<-- "databases/part-1/bookshops/q4.sql"
```

--8<-- "databases/part-1/bookshops/results/q4.txt"

!!! note "Titles or copies?"
    `COUNT(C2.quantità)` counts the **titles** a bookshop stocks (one row of
    `Disponibilita` per title). If "number of books" means the **copies** in stock, the
    count must be `SUM(C2.quantità)` (with `COALESCE(..., 0)` for the empty bookshop in
    Query 3). The two readings give different answers on the test data: by titles, the
    bookshops 1 and 3 tie with 3 each; by copies, bookshop 3 wins with 26 against 11 and 6.

## Takeaways

- A join from the "one" side to the "many" side repeats rows: `DISTINCT` when only the "one"
  side is wanted.
- `COUNT` counts rows, `SUM` adds values: the question decides which one.
