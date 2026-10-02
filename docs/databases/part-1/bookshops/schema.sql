CREATE TABLE Libri (
   codice INT PRIMARY KEY,
   titolo TEXT NOT NULL,
   id_genere INT NOT NULL,
   prezzo_di_copertina DECIMAL(10, 2),
   FOREIGN KEY (id_genere) REFERENCES Generi(id)
);
CREATE TABLE Generi (
   id INT PRIMARY KEY,
   nome TEXT NOT NULL,
   descrizione TEXT
);

CREATE TABLE Librerie (
   id INT PRIMARY KEY,
   indirizzo TEXT NOT NULL,
   città TEXT NOT NULL
);

CREATE TABLE Disponibilita (
   libreria INT NOT NULL,
   libro INT NOT NULL,
   quantità INT NOT NULL,
   PRIMARY KEY (libreria, libro),
   FOREIGN KEY (libreria) REFERENCES Librerie(id),
   FOREIGN KEY (libro) REFERENCES Libri(codice)
);
