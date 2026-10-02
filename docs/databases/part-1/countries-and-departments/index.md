# Countries, cities and departments

<p class="ex-meta">SQL exercises · Part I</p>

## Problem

A database of **countries**, their **cities** (identified by a code within the country) and
company **departments** located in a city. Write two queries.

## Schema and test data

=== "schema.sql"

    ```sql
    --8<-- "databases/part-1/countries-and-departments/schema.sql"
    ```

=== "test_data.sql"

    ```sql
    --8<-- "databases/part-1/countries-and-departments/test_data.sql"
    ```

The exercise also defines a table of employees, `impiegato`, left out here: neither query
uses it, and as written it declares a foreign key on a column, `capo`, that the table does not
have, so a database would reject it. The test data are mine.

## Queries

### Query 1 · Each city with its country

For each city, its name and the name of its country, ordered by city name.

```sql
--8<-- "databases/part-1/countries-and-departments/q1.sql"
```

--8<-- "databases/part-1/countries-and-departments/results/q1.txt"

### Query 2 · Large departments per country

For each country, the number of its departments with more than 10 employees, ordered by
country name.

```sql
--8<-- "databases/part-1/countries-and-departments/q2.sql"
```

--8<-- "databases/part-1/countries-and-departments/results/q2.txt"

!!! note "One reading of the text"
    "For each country" could also mean listing the countries with no such department, with 0:
    Spagna, in the test data, does not appear. That would need the country table as the
    starting point and a `LEFT JOIN` with the condition moved into the join. The query is a
    correct answer to the other, equally plausible reading.

## Takeaways

- With a composite key (`cittaId`, `paeseId`), a city is identified only by both columns: the
  foreign key from `dipartimento` uses both.
- Whether a "for each" includes the zeros is a question to settle before writing the query.
