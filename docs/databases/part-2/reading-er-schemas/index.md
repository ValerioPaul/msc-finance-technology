# Reading E-R schemas

<p class="ex-meta">Conceptual design · Part II</p>

## Problem

Small schemas that differ only in cardinalities and identifiers; for each one, answer yes or
no to questions about which data it allows. The point is to read exactly what a schema says,
nothing more.

## Method

- **Maximum cardinality** on the side of an entity: how many occurrences of the other entity
  one occurrence can be linked to. (1,1) means exactly one; (0,N) or (1,N), any number.
- **Identifier**: two occurrences cannot share it. If it is internal (one attribute), two
  occurrences cannot have the same value; if it is external (attribute + relationship), the
  same value can repeat as long as the linked occurrence differs.

## 1 · Divisions and departments

Four schemas with `Divisione(Nome)` and `Reparto(Nome)` linked by `Appartenenza`:

| Schema | Divisione side | Reparto side | Identifiers |
|---|---|---|---|
| 1 | (1,1) | (0,N) | Division: name **+ department** (external); department: name |
| 2 | (0,N) | (1,1) | both by name |
| 3 | (0,N) | (1,1) | division: name; department: name **+ division** (external) |
| 4 | (0,N) | (1,N) | both by name |

| Question | 1 | 2 | 3 | 4 |
|---|---|---|---|---|
| Can two divisions have the same name (in different departments)? | yes | no | no | no |
| Can two departments have the same name (in different divisions)? | no | no | yes | no |
| Can two divisions belong to the same department? | yes | no | no | yes |
| Can two departments belong to the same division? | no | yes | yes | yes |

All sixteen answers are correct. The first cell was in doubt in the original notes: the
answer is yes, because in schema 1 a division is identified by its name **together with** its
department, so the same name can appear in two departments.

## 2 · Departments and offices

`Impiegato(Matricola, Cognome)` belongs to exactly one `Dipartimento(Denominazione)`, which is
linked by `Composizione` to `Sede(Nome, Indirizzo)`:

- **(a)** department (0,N), office (1,1); the office is identified by its name **+ department**;
- **(b)** department (1,1), office (0,N); the department is identified by its name **+ office**.

| Question | (a) | (b) |
|---|---|---|
| Can a department have two offices with the same name? | no | no |
| Can a department have two offices? | yes | no |
| Can an office host two departments? | no | yes |
| Can two offices have the same name? | yes | no |
| Is each employee associated with exactly one address? | no | yes |

The last question follows the chain: in (b) an employee has one department, which has one
office, which has one address; in (a) the department can have any number of offices,
including none.

## Takeaways

- An external identifier allows repeated values of the attribute, as long as the linked
  occurrence differs: that is what it is for.
- Questions about "how many" are answered by maximum cardinalities; questions about
  "same name" by identifiers.
- To answer a question that crosses several relationships, multiply along the path: (1,1)
  everywhere means exactly one.
