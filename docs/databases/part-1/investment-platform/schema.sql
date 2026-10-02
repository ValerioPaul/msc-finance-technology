-- The exercise does not give the schema: these tables contain exactly the
-- columns that the queries use.
CREATE TABLE clienti (
    id_cliente      INTEGER PRIMARY KEY,
    nome            TEXT,
    email           TEXT,
    profilo_rischio TEXT
);
CREATE TABLE conti (
    id_conto   INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL REFERENCES clienti(id_cliente)
);
CREATE TABLE assets (
    id_asset   INTEGER PRIMARY KEY,
    ticker     TEXT,
    nome_asset TEXT,
    categoria  TEXT
);
CREATE TABLE ordini (
    id_ordine INTEGER PRIMARY KEY,
    id_conto  INTEGER NOT NULL REFERENCES conti(id_conto),
    id_asset  INTEGER NOT NULL REFERENCES assets(id_asset),
    quantita  INTEGER
);
