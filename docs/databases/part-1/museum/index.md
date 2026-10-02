# A museum: artists, paintings and rooms

<p class="ex-meta">SQL exercises · Part I</p>

## Problem

A museum database: **artists**, their **paintings**, and the **rooms** where paintings are
exhibited, each room on a floor. A painting may have no room (for example, when it is in
storage). Write four queries.

## Schema and test data

=== "schema.sql"

    ```sql
    --8<-- "databases/part-1/museum/schema.sql"
    ```

=== "test_data.sql"

    ```sql
    --8<-- "databases/part-1/museum/test_data.sql"
    ```

The schema is the one given in the exercise; the test data are mine.

## Queries

### Query 1 · Paintings on the first floor

All the paintings on floor 1, with code and description of the painting and surname and name
of the artist.

```sql
--8<-- "databases/part-1/museum/q1.sql"
```

--8<-- "databases/part-1/museum/results/q1.txt"

### Query 2 · Rooms on the first floor and how many paintings they show

For each room on floor 1: name, floor and number of paintings exhibited (0 if none).

```sql
--8<-- "databases/part-1/museum/q2.sql"
```

--8<-- "databases/part-1/museum/results/q2.txt"

The empty Sala D appears with 0 thanks to the `LEFT JOIN` and to counting `C2.stanza`
rather than rows.

### Query 3 · Works of each artist in each first-floor room

For each room on floor 1 that shows at least one painting: name and floor of the room, name
and surname of each artist with works there, and how many works of that artist it shows.
Solved in two ways.

=== "With an outer join"

    ```sql
    --8<-- "databases/part-1/museum/q3a.sql"
    ```

=== "With inner joins"

    ```sql
    --8<-- "databases/part-1/museum/q3b.sql"
    ```

--8<-- "databases/part-1/museum/results/q3a.txt"

Both versions give the same result: since rooms without paintings must be excluded anyway,
the inner join of the second version does directly what the first obtains with
`LEFT JOIN` plus `IS NOT NULL`.

### Query 4 · Artists with at least two paintings in the same room

The (name, surname, room) triples where the room contains at least two paintings of that
artist.

```sql
--8<-- "databases/part-1/museum/q4.sql"
```

--8<-- "databases/part-1/museum/results/q4.txt"

## Takeaways

- `WHERE` filters rows before grouping, `HAVING` filters groups after: a condition on a
  count can only go in `HAVING`.
- An outer join followed by a filter on the optional side is just an inner join written the
  long way.
- The `#` comments of the original (MySQL syntax) are written here as `--`, the standard
  SQL comment, so that the queries run on any database.
