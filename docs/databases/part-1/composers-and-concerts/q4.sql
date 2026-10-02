CREATE VIEW massimo_numero_pezzi AS
SELECT C1.codice, C1.cognome, C1.nome, COUNT(DISTINCT C3.pezzo) AS numeroPezzi
FROM Compositori AS C1
JOIN Pezzi AS C2
ON C1.codice = C2.autore

JOIN Programmazione AS C3
ON C2.codice = C3.pezzo

GROUP BY C1.codice, C1.cognome, C1.nome
ORDER BY C1.codice;

SELECT codice, cognome, nome, numeroPezzi
FROM massimo_numero_pezzi
WHERE numeroPezzi = (SELECT MAX(numeroPezzi) FROM massimo_numero_pezzi)
