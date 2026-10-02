SELECT C1.codice AS codiceCompositore, C2.codice AS codicePezzo, C2.titolo, C2.durata
FROM Compositori AS C1
JOIN Pezzi AS C2
ON C1.codice = C2.autore

WHERE C2.durata > 5  AND C1.cognome = 'Rossi'
ORDER BY C1.codice, C2.codice
