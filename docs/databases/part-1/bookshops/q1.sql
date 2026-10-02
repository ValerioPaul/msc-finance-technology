SELECT C1.id, C1.indirizzo, C1.città

FROM Librerie AS C1
JOIN Disponibilita AS C2
ON C1.id = C2.libreria
JOIN Libri AS C3
ON C2.libro = C3.codice

WHERE C3.prezzo_di_copertina < 20
