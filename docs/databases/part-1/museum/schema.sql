CREATE TABLE Artisti (
codice text NOT NULL PRIMARY KEY,
cognome text,
nome text);

CREATE TABLE Quadri (
codice integer NOT NULL PRIMARY KEY,
artista text NOT NULL REFERENCES Artisti,
descrizione text NOT NULL,
stanza text REFERENCES Stanze,
anno integer
);

CREATE TABLE Stanze (
nome text NOT NULL PRIMARY KEY,
piano integer NOT NULL
);
