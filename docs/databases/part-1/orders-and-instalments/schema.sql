-- The exercise shows the three relations with their data (see test_data.sql).
CREATE TABLE persone (
    CF      TEXT PRIMARY KEY,
    cognome TEXT,
    nome    TEXT
);
CREATE TABLE ordini (
    codice      INTEGER PRIMARY KEY,
    cliente     TEXT REFERENCES persone(CF),
    descrizione TEXT
);
CREATE TABLE rateemesse (
    numero        INTEGER PRIMARY KEY,
    ordine        INTEGER REFERENCES ordini(codice),
    data          TEXT,
    importo       INTEGER,
    datapagamento TEXT
);
