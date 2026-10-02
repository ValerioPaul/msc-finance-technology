# Flights and airports

<p class="ex-meta">SQL exercises · Part I</p>

## Problem

Three exercises on a database of **airports**, scheduled **flights** (number, departure and
arrival airport), the **actual flights** operated on each date, and the **frequent flyer**
programme of registered users:

1. translate a given relational algebra expression into SQL;
2. find the registered users with the most frequent-flyer points;
3. count the flights leaving each airport on a given date;
4. find the airports with more than one flight on another date.

## Schema and test data

=== "schema.sql"

    ```sql
    --8<-- "databases/part-1/flights/schema.sql"
    ```

=== "test_data.sql"

    ```sql
    --8<-- "databases/part-1/flights/test_data.sql"
    ```

The test data are mine.

## Queries

### Query 1 · From relational algebra to SQL

The expression joins each flight with the airport of departure, renames its city to
`citta_partenza`, joins the result with the airport of arrival, renames that city to
`citta_arrivo`, and projects number, departure city and arrival city; order by flight number.

$$
\pi_{\text{numero\_volo},\, \text{citta\_partenza},\, \text{citta\_arrivo}}
\Big( \rho_{\text{citta\_arrivo} \leftarrow \text{citta}} \big(
\pi_{\ldots}( \rho_{\text{citta\_partenza} \leftarrow \text{citta}}(\text{Volo} \bowtie_{\text{aeroporto\_partenza} = \text{codice\_aeroporto}} \text{Aeroporto}))
\bowtie_{\text{aeroporto\_arrivo} = \text{codice\_aeroporto}} \text{Aeroporto} \big) \Big)
$$

```sql
--8<-- "databases/part-1/flights/q1.sql"
```

--8<-- "databases/part-1/flights/results/q1.txt"

The two steps of the expression become a view and a query; the renamings $\rho$ become the
aliases `AS citta_partenza` and `AS citta_arrivo`. The airport table is used twice, with two
different roles.

### Query 2 · Users with the most points

Name, surname and points of the registered users with the most frequent-flyer points (there
may be more than one), ordered by name, surname and points.

```sql
--8<-- "databases/part-1/flights/q2.sql"
```

--8<-- "databases/part-1/flights/results/q2.txt"

### Query 3 · Flights per airport on 4 July 2023

For each airport, the number of flights with scheduled departure on 2023-07-04: code and city
of the departure airport and number of flights, ordered by airport code.

```sql
--8<-- "databases/part-1/flights/q3.sql"
```

--8<-- "databases/part-1/flights/results/q3.txt"

### Query 4 · Airports with more than one flight on 6 July 2023

Code of the airports with more than one flight scheduled to leave on 2023-07-06, with the
number of flights, ordered by airport code.

```sql
--8<-- "databases/part-1/flights/q4.sql"
```

--8<-- "databases/part-1/flights/results/q4.txt"

!!! note "Review notes"
    All four queries return the right rows. The requested ordering is missing in Query 3 and
    Query 4 (`ORDER BY` on the airport code). In Query 2 the `ORDER BY` is inside the view,
    where it does not order the final result, and it uses `C2.punti`, which is neither
    grouped nor aggregated: SQLite accepts it, standard SQL does not. The ordering belongs to
    the final `SELECT`. Query 4 could also be written without the view, as
    `GROUP BY … HAVING COUNT(*) > 1`.

## Takeaways

- Using the same table twice in a query (departure and arrival airport) requires two aliases.
- Relational algebra and SQL map closely: selection is `WHERE`, projection the `SELECT` list,
  renaming `AS`, join `JOIN … ON`.
- Filtering on a count can be done with a view and `WHERE`, or directly with `HAVING`.
