SELECT C1.id, C1.indirizzo, C1.città, COUNT(C2.quantità) AS numero_libri

FROM Librerie AS C1
LEFT JOIN Disponibilita AS C2
ON C1.id = C2.libreria

GROUP BY C1.id, C1.indirizzo, C1.città
ORDER BY C1.id
