-- The three flight exercises use compatible tables, merged here into one schema.
-- Exercises 3 and 4 give these definitions; exercise 1 only names the relevant
-- attributes: VOLO(numero_volo, aeroporto_partenza, aeroporto_arrivo) and
-- AEROPORTO(codice_aeroporto, nome, citta).
CREATE TABLE IF NOT EXISTS aeroporto (
    codice_aeroporto character(3) PRIMARY KEY NOT NULL,
    nome_aeroporto text  NOT NULL,
    citta text  NOT NULL,
    codice_continente text ,
    codice_paese text ,
    internazionale boolean NOT NULL);

CREATE TABLE IF NOT EXISTS volo (
    numero_volo text PRIMARY KEY NOT NULL,
    aeroporto_partenza character(3) REFERENCES aeroporto(codice_aeroporto),
    aeroporto_arrivo character(3) REFERENCES aeroporto(codice_aeroporto),
    orario_partenza_previsto time ,
    orario_arrivo_previsto time);

CREATE TABLE IF NOT EXISTS volo_reale (
    id_volo_reale integer PRIMARY KEY NOT NULL,
    data_partenza_programmata date,
    numero_volo text REFERENCES volo(numero_volo),
    codice_tipo_aeromobile character(3),
    data_partenza_reale date,
    data_arrivo_reale date,
    orario_arrivo_reale time ,
    orario_partenza_reale time ,
    UNIQUE (numero_volo, data_partenza_programmata));

-- exercise 2
CREATE TABLE IF NOT EXISTS frequent_flyer (
    id_frequent_flyer integer PRIMARY KEY  NOT NULL,
    numero_carta text  NOT NULL,
    livello integer NOT NULL,
    punti integer NOT NULL);

CREATE TABLE IF NOT EXISTS utente_registrato (
    id_utente integer PRIMARY KEY NOT NULL,
    email text  NOT NULL,
    nome text  NOT NULL,
    cognome text  NOT NULL,
    id_frequent_flyer integer REFERENCES frequent_flyer (id_frequent_flyer));
