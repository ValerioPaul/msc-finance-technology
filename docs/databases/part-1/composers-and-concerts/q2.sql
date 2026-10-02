SELECT C1.codice, C1.titolo
FROM Pezzi AS C1
LEFT JOIN Programmazione AS C2
ON C1.codice = C2.pezzo

WHERE C2.pezzo IS NULL
ORDER BY C1.codice
