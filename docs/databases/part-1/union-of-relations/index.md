# Union of two relations

<p class="ex-meta">SQL exercise · Part I</p>

## Problem

Two relations record the mother and the father of each child. Combine them into a single
relation of (parent, child) pairs, ordered by child and, for the same child, by parent.

## Schema and test data

=== "schema.sql"

    ```sql
    --8<-- "databases/part-1/union-of-relations/schema.sql"
    ```

=== "test_data.sql"

    ```sql
    --8<-- "databases/part-1/union-of-relations/test_data.sql"
    ```

## Query

```sql
--8<-- "databases/part-1/union-of-relations/q1.sql"
```

--8<-- "databases/part-1/union-of-relations/results/q1.txt"

## Takeaways

- `UNION` needs the same number of columns with compatible types; the alias `genitore`
  gives the combined column one name.
- `ORDER BY` applies to the whole union, so it comes once, at the end.
- `UNION` removes duplicate rows; `UNION ALL` would keep them.
