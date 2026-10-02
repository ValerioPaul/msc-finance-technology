-- The schema of the exercise, without the table impiegato: the queries do not use
-- it, and as written it declares a foreign key on a column (capo) it does not have.
CREATE TABLE paese (
  id int PRIMARY KEY,
  nome text);

CREATE TABLE citta (
  cittaId int,
  paeseId int not null references paese(id),
  nome text,
  popolazione int,
  PRIMARY key (cittaId, paeseId)
);

CREATE TABLE dipartimento (
  id int primary key,
  nome text,
  numeroDiDipendenti int,
  citta int not NULL,
  paese int not NULL,
  manager int,
  foreign key (citta, paese) references citta(cittaId, paeseId),
  FOREIGN key (manager, id) REFERENCES impiegato(id, lavoraPresso),
  UNIQUE(manager)
);
