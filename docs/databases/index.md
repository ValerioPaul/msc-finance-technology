# Databases

<p class="ex-meta">Roma Tre University · Department of Engineering · SQL</p>

How relational databases are queried and designed: writing SQL and reasoning about relational
expressions, drawing conceptual schemas and translating them into tables, and normalizing a
relation into Boyce–Codd normal form. The three parts follow the three partial exams of the
course.

Each page gives the **problem** (the exam text, rewritten briefly in English), the **method**,
my **solution** and the **takeaways**. Where the solution has mistakes or gaps, a review note
says so; the original answers are left as they were.

The SQL is runnable: each schema comes with test data, and every query was executed on SQLite.
The result tables on the pages are the output of exactly those files. The E-R diagrams are
the ones I drew with draw.io during the course.

## Parts

| Part | Topics | |
|---|---|---|
| [Part I · SQL and relational algebra](part-1/index.md) | CHECK constraints, cardinality of joins, queries with joins, grouping, views and subqueries | 9 pages |
| [Part II · Conceptual and logical design](part-2/index.md) | reading and drawing E-R schemas, reverse engineering, redundancy analysis, translation to tables | 6 pages |
| [Part III · Normalization](part-3/index.md) | keys, functional dependencies, BCNF decomposition, a full practice exam | 3 pages |
