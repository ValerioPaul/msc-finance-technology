# Redundancy analysis

<p class="ex-meta">Logical design · Part II</p>

## Problem

A conceptual schema contains a **redundant** piece of information: an attribute or a
relationship that could be derived from the rest of the schema (an account balance that is
the sum of its operations, a number of bookings that can be counted). Keeping it makes some
operations faster and others slower. Given the size of each entity and the frequency of the
main operations, decide whether to keep it. Seven exam questions.

## Method

1. For each operation, write the **access table**: which entity or relationship occurrences
   it reads (R) and writes (W), and how many, **with** and **without** the redundancy.
2. Weight the accesses: a write usually counts double a read (the text states the ratio).
3. Multiply the cost of each operation by its frequency and add up:

$$
\text{total cost} = \sum_i f_i \cdot \big(n^R_i + w \cdot n^W_i\big)
$$

4. Keep the redundancy only if its total cost is lower. Memory is usually ignored.

Where a quantity is an average (for example, 20,000 operations over 2,000 accounts means 10
operations per account), the average is the number of accesses needed to recompute the
derived value.

In the tables below, each cell gives the accesses and the cost of one execution of the
operation.

## 1 · Account balance

`ContoCorrente(Numero, Saldo)` is linked to `Operazione(Codice, Importo, Data)` by
`Movimento`, with each operation on exactly one account. `Saldo` is the sum of the amounts of
the account's operations. $L_{CC} = 2{,}000$ accounts, $L_{OP} = 20{,}000$ operations (10 per
account). Operations: write a movement ($f_1 = 10$), read the balance ($f_2 = 1{,}000$).
The text gives no read/write ratio: writes are counted as 2.

| | Op 1 · write a movement | Op 2 · read the balance | Total cost |
|---|---|---|---|
| With redundancy | 1 W movement, 1 R balance, 1 W balance → **5** | 1 R balance → **1** | 5·10 + 1·1,000 = **1,050** |
| Without | 1 W movement → **2** | 10 R movements → **10** | 2·10 + 10·1,000 = 10,020 |

**Keep the redundancy.** The balance is read a hundred times more often than it changes.

## 2 · Number of bookings of an event

`Evento(Codice, NumeroPrenotati, Costo)` and `Persona(CodiceFiscale, Nome)`, many-to-many
through `Prenotazione`. $N_E = 1{,}000$, $N_P = 3{,}000$, $N_Z = 10{,}000$ bookings (10 per event).
Operations: count the bookings of an event ($f_1 = 1{,}000$), book a person on an event
($f_2 = 100$). A write costs **three** reads.

| | Op 1 · count the bookings | Op 2 · book a person | Total cost |
|---|---|---|---|
| With redundancy | 1 R event → **1** | 1 W booking, 1 R event, 1 W event → **7** | 1·1,000 + 7·100 = **1,700** |
| Without | 10 R bookings → **10** | 1 W booking → **3** | 10·1,000 + 3·100 = 10,300 |

**Keep the redundancy.**

## 3 · Revenue of a trip

`Viaggio(Codice, Incasso, Costo)` and `Cliente(CodiceFiscale, Nome)`, many-to-many through
`Partecipazione`. `Incasso` is the cost times the number of participants. $C_V = 10{,}000$,
$C_C = 30{,}000$, $C_P = 200{,}000$ (20 participants per trip). Operations: compute the revenue
of a trip ($f_1 = 500$), add a participant ($f_2 = 50{,}000$). Writes cost the same as reads.

| | Op 1 · compute the revenue | Op 2 · add a participant | Total cost |
|---|---|---|---|
| With redundancy | 1 R trip → **1** | 1 W participation, 1 R trip, 1 W trip → **3** | 1·500 + 3·50,000 = 150,500 |
| Without | 1 R trip (the unit cost), 20 R participations → **21** | 1 W participation → **1** | 21·500 + 1·50,000 = **60,500** |

**Drop the redundancy.** Here participants are added a hundred times more often than the
revenue is read, so the update costs more than it saves.

## 4 · Shortcut relationships between customers, branches and banks

A chain `Cliente –(C-A)– Agenzia –(A-F)– Filiale –(F-B)– Banca`: C-A is many-to-many, each
agency belongs to one branch and each branch to one bank. Should the schema add `C-F`
(customer–branch), `C-B` (customer–bank), or both? A customer deals with $N = 10$ agencies,
all of different branches and banks. Operations: add a customer–agency link ($f_1 = 100$),
find the branches of a customer ($f_2 = 10{,}000$), find the banks of a customer
($f_3 = 10{,}000$). Only entities and many-to-many relationships count; writes cost double.

| | Op 1 · add C-A | Op 2 · branches | Op 3 · banks | Total cost |
|---|---|---|---|---|
| No redundancy | 1 W C-A → **2** | 10 R C-A, 10 R agency → **20** | 10 R C-A, 10 R agency, 10 R branch → **30** | 500,200 |
| Only C-F | 1 W C-A, 1 R agency, 1 W C-F → **5** | 10 R C-F → **10** | 10 R C-F, 10 R branch → **20** | 300,500 |
| Only C-B | 1 W C-A, 1 R agency, 1 R branch, 1 W C-B → **6** | 10 R C-A, 10 R agency → **20** | 10 R C-B → **10** | 300,600 |
| Both | 1 W C-A, 1 R agency, 1 W C-F, 1 R branch, 1 W C-B → **8** | 10 R C-F → **10** | 10 R C-B → **10** | **200,800** |

**Add both relationships.** The two searches are a hundred times more frequent than the
insertion, so a shortcut for each of them pays off.

## 5 · Relationship between projects and offices

`Progetto –(P-I)– Impiegato –(I-D)– Dipartimento –(D-S)– Sede`: P-I is many-to-many, each
employee is in one department and each department in one office. Should a relationship `P-S`
(project–office) be added? Each employee works on $k = 5$ projects, each department has
$n = 50$ employees, each office hosts $d = 5$ departments. Operations: find the projects of the
employees of an office ($f_1 = 400$), add a P-I occurrence ($f_2 = 1{,}000$). Only entities and
many-to-many relationships count; writes cost double.

| | Op 1 · projects of an office | Op 2 · add P-I | Total cost |
|---|---|---|---|
| With redundancy | 5 · 50 · 5 → **1,250** | 1 W P-I, 1 R employee, 1 R department, 1 W P-S → **6** | 1,250·400 + 6·1,000 = 506,000 |
| Without | 5 departments · 50 employees · 5 projects → **1,250** | 1 W P-I → **2** | 1,250·400 + 2·1,000 = **502,000** |

**Do not add P-S.**

## 6 · Revenue of a congress (two versions)

`Congresso(Codice, Ricavo, Costo)` and `Persona(CodiceFiscale, Nome)`, many-to-many through
`Iscrizione`. `Ricavo` is the cost times the number of registrations. Writes cost double.

**First version:** $N_C = 1{,}000$, $N_P = 3{,}000$, $N_I = 10{,}000$ (10 per congress); compute
the revenue with $f_1 = 4{,}000$ (corrected by hand from 2,000 on the exam sheet), register a
person with $f_2 = 2{,}000$.

| | Op 1 · compute the revenue | Op 2 · register a person | Total cost |
|---|---|---|---|
| With redundancy | 1 R congress → **1** | 1 W registration, 1 R congress, 1 W congress → **5** | 1·4,000 + 5·2,000 = **14,000** |
| Without | 1 R congress, 10 R registrations → **11** | 1 W registration → **2** | 11·4,000 + 2·2,000 = 48,000 |

**Keep the redundancy.**

**Second version:** $C_C = 1{,}000$, $C_P = 3{,}000$, $C_I = 20{,}000$ (20 per congress); compute
the revenue with $f_1 = 100$, register a person with $f_2 = 20{,}000$.

| | Op 1 · compute the revenue | Op 2 · register a person | Total cost |
|---|---|---|---|
| With redundancy | 1 R congress → **1** | 1 W registration, 1 R congress, 1 W congress → **5** | 1·100 + 5·20,000 = 100,100 |
| Without | 1 R congress, 20 R registrations → **21** | 1 W registration → **2** | 21·100 + 2·20,000 = **42,100** |

**Drop the redundancy.** The same schema gives the opposite answer when the workload
changes: the decision depends on the frequencies, not on the schema.

!!! note "Review notes"
    All seven decisions are correct. Four details in the handwritten tables are worth fixing:

    - **Case 2:** the total without redundancy is written as $10 \cdot 1{,}000 + 3 \cdot 100 = 1{,}030$;
      it is **10,300**. With 1,030 the comparison would point the other way (1,030 < 1,700),
      while the conclusion "keep the redundancy" is the right one.
    - **Case 4:** the total for "only C-F" is written as 30,500; it is **300,500**, which is
      why "both" (200,800) is indeed the cheapest. The heading of that sheet also says that a
      write costs 1, while the tables count it as 2, as the text requires.
    - **Case 5:** with P-S, operation 1 no longer needs the chain: it reads the P-S occurrences
      of the office directly. There are at most 1,250 of them (exactly 1,250 only if no project
      is shared by two employees of the same office), so the table shows the worst case for
      the redundancy. With enough shared projects (at least 10 fewer reads per execution, to
      save the 4,000 that the extra writes cost), P-S would pay off.
    - **Case 6, second version:** the table without redundancy says "write the person" with
      cost 1; the operation writes a **registration**, at cost 2. The total (42,100) does use 2.

    Case 1 counts the new movement as a single write. Counting the `Operazione` and
    `Movimento` occurrences separately, and reading both for the balance, gives 1,070 against
    20,040: the decision does not change.

## Takeaways

- The question is never "is it redundant?" but "which operations does it speed up, which does
  it slow down, and how often do they run?".
- An update of a redundant value costs a read and a write on top of the original write: it
  pays off only when the derived value is read much more often than it changes.
- Compute every total explicitly: a dropped digit can reverse the conclusion.
