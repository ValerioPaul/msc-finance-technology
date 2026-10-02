# Logical design: from E-R to tables

<p class="ex-meta">Logical design · Part II</p>

## Problem

Translate a conceptual schema into a relational one: one table per entity, and for every
relationship a decision on where its information goes. Four exercises: the same two
entities with three different cardinalities, a company schema with optional attributes,
a theatre database, and a weak entity whose key passes into a foreign key.

## Method

The rule depends on the **maximum** cardinalities:

| Relationship | Translation |
|---|---|
| one-to-many | the key of the "one" side **migrates** into the table on the (1,1) side, as a foreign key |
| one-to-one | as one-to-many, choosing the side; with (0,1) the foreign key may be null |
| many-to-many | a new table whose key is the pair of keys of the two entities, plus the relationship's attributes |
| weak entity | its key is the key of the owner plus its own partial identifier |

A (0,1) attribute or participation becomes a column that may be null (marked `*` below).
In the tables, underlined columns form the key and (FK) marks a foreign key.

## 1 · Polling stations and municipalities, three ways

`Seggio(Numero, Nome)` and `Comune(Nome, Altitudine)`, linked by `S-C`:

- **A** · each station is in one municipality, (1,1); each municipality has one or more,
  (1,N);
- **B** · as A, but the station is identified by its number **and** its municipality
  (external identifier);
- **C** · reversed: each municipality belongs to exactly one station, (1,1); a station can
  have none or many, (0,N).

Show the relational database for each, with a few rows that make the differences visible.

=== "A"

    | <u>Numero</u> | Nome | Comune (FK) |
    |---|---|---|
    | 1 | Seggio Alfa | Roma |
    | 2 | Seggio Beta | Milano |
    | 3 | Seggio Gamma | Firenze |
    | 4 | Seggio Delta | Roma |

    | <u>Nome</u> | Altitudine |
    |---|---|
    | Roma | 150 |
    | Milano | 300 |
    | Firenze | 450 |

    The key of `Comune` migrates into `Seggio`, the (1,1) side; Roma appears twice because a
    municipality has many stations.

=== "B"

    | <u>Numero</u> | <u>Comune</u> (FK) | Nome |
    |---|---|---|
    | 1 | Roma | Seggio Alfa |
    | 1 | Milano | Seggio Beta |
    | 1 | Firenze | Seggio Gamma |
    | 1 | Venezia | Seggio Sigma |

    | <u>Nome</u> | Altitudine |
    |---|---|
    | Roma | 150 |
    | Milano | 300 |
    | Firenze | 450 |
    | Venezia | 600 |

    The foreign key is now **part of the key**: every municipality can have its station
    number 1, and only the pair (number, municipality) is unique.

=== "C"

    | <u>Numero</u> | Nome |
    |---|---|
    | 1 | Seggio Alfa |
    | 2 | Seggio Beta |
    | 3 | Seggio Gamma |
    | 4 | Seggio Sigma |

    | <u>Nome</u> | Altitudine | Seggio (FK) |
    |---|---|---|
    | Roma | 150 | 1 |
    | Milano | 300 | 1 |
    | Firenze | 450 | 3 |
    | Venezia | 600 | 4 |

    The foreign key moves to the other side: `Comune` is now the (1,1) side. Station 1 has
    two municipalities, station 2 none, both allowed by (0,N).

All three translations are correct, and the rows show the point of each one.

## 2 · Employees, departments, offices and projects

The classic company schema: an employee belongs to exactly one department (with an optional
start date) and may direct one; a department is identified by its name and its office, has a
phone number, and has at most one director; projects have a name and a budget, and employees
take part in one or more of them.

- **Impiegato**(<u>Codice</u>, Cognome, Dipartimento, Sede, Data\*)
- **Dipartimento**(<u>Nome</u>, <u>Città</u>, Telefono, Direttore\*)
- **Sede**(<u>Città</u>, Indirizzo)
- **Progetto**(<u>Nome</u>, Budget)
- **Partecipazione**(<u>Impiegato</u>, <u>Progetto</u>)

Correct. `Afferenza` is one-to-many, so the department's key, which is two columns
(`Dipartimento`, `Sede`), migrates into `Impiegato`; its optional attribute `Data` comes along
and may be null. `Direzione` is one-to-one with (0,1) on both sides: the director goes into
`Dipartimento`, nullable. `Partecipazione` is many-to-many and gets its own table.

## 3 · Theatres, plays and tickets

A theatre puts plays on its programme for a period; actors perform in the plays on programme;
each play has an author; each theatre sells tickets by seat type, with a price, and offers
reduction types with a percentage.

- **Attore**(<u>Codice</u>, Cognome)
- **Interpreta**(<u>Attore</u>, <u>Teatro</u>, <u>OperaTeatrale</u>) · references `Attore` and
  `OperaInCartellone` (Teatro, OperaTeatrale)
- **Autore**(<u>Codice</u>, Cognome)
- **OperaTeatrale**(<u>Codice</u>, Titolo, Anno, Autore) · references `Autore`
- **TipoPosto**(<u>Codice</u>, Desc)
- **TipoRiduzione**(<u>Codice</u>, Desc)
- **Teatro**(<u>Codice</u>, Nome, Indirizzo, Telefono)
- **R1**(<u>Teatro</u>, <u>TipoRiduzione</u>, Percentuale) · references `Teatro` and `TipoRiduzione`
- **Biglietto**(<u>TipoPosto</u>, <u>Teatro</u>, Prezzo) · references `TipoPosto` and `Teatro`
- **OperaInCartellone**(<u>Teatro</u>, <u>OperaTeatrale</u>, Periodo) · references `Teatro` and
  `OperaTeatrale`

Correct, including the two weak entities (`OperaInCartellone` and `Biglietto`, both identified
by their two relationships) and `Interpreta`, whose foreign key towards a weak entity is the
pair of columns. In the original the underline of `OperaInCartellone` also extends under
`Periodo`; following the diagram, the period is a plain attribute, and the key is (Teatro,
OperaTeatrale).

## 4 · A key that travels

`Impiegato(Matricola, Cognome)` belongs to one `Dipartimento`, (1,1)–(0,N); a department is
identified by its `Denominazione` **and** the `Sede` it belongs to; `Sede(Nome, Indirizzo)`.

- **Impiegato**(<u>Matricola</u>, Cognome, Dipartimento (FK), Sede (FK))
- **Dipartimento**(<u>Denominazione</u>, <u>Sede</u> (FK))
- **Sede**(<u>Nome</u>, Indirizzo)

| <u>Matricola</u> | Cognome | Dipartimento | Sede |
|---|---|---|---|
| 123 | Bruni | Marketing | R1 |
| 223 | Rossi | Marketing | R1 |
| 323 | Rossi | HR | R3 |
| 423 | Galli | Customer | R4 |

| <u>Denominazione</u> | <u>Sede</u> |
|---|---|
| Marketing | R1 |
| Sales | R1 |
| HR | R3 |
| Customer | R4 |

| <u>Nome</u> | Indirizzo |
|---|---|
| R1 | Via cavoli |
| R2 | Via broccoli |
| R3 | Via carote |
| R4 | Via pomodori |

Correct: because the department's key is two columns, the employee needs **both** to point to
it; (`Dipartimento`, `Sede`) together form one foreign key towards `Dipartimento`.

## Takeaways

- The foreign key goes on the (1,1) side; reversing the cardinalities moves it to the other
  table (A and C).
- An external identifier puts the foreign key **inside** the primary key (B), and whoever
  references that entity must carry the whole composite key (exercise 4).
- Optional participations and attributes become nullable columns.
