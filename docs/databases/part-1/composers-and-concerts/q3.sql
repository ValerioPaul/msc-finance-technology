SELECT C1.codice, C1.cognome, C1.nome, COUNT(DISTINCT C3.pezzo) AS numeroPezzi
FROM Compositori AS C1
JOIN Pezzi AS C2
ON C1.codice = C2.autore

JOIN Programmazione AS C3
ON C2.codice = C3.pezzo

GROUP BY C1.codice, C1.cognome, C1.nome
