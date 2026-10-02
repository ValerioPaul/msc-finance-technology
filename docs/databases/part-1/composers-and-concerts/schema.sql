CREATE TABLE Compositori ( codice integer NOT NULL PRIMARY KEY,
                           cognome text ,
                           nome text );
CREATE TABLE Pezzi ( codice integer NOT NULL PRIMARY KEY,
                     titolo text,
                     autore integer NOT NULL REFERENCES Compositori,
                     durata integer);
CREATE TABLE Concerti ( codice integer NOT NULL PRIMARY KEY,
                        titolo text ,
                        descrizione text );
CREATE TABLE Programmazione ( pezzo integer NOT NULL REFERENCES Pezzi,
                              concerto integer NOT NULL REFERENCES Concerti,
                              posizione integer,
                              PRIMARY KEY(pezzo, concerto) );
