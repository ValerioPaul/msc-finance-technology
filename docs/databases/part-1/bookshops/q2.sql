SELECT DISTINCT C1.codice, C1.titolo, C1.prezzo_di_copertina, C4.nome

FROM Libri AS C1
JOIN Disponibilita AS C2
ON C1.codice = C2.libro
JOIN Librerie AS C3
ON C2.libreria = C3.id
JOIN Generi AS C4
ON C1.id_genere = C4.id

WHERE C1.prezzo_di_copertina > 12 AND C3.città = 'Milano'
