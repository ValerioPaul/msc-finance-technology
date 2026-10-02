SELECT C1.CF, C1.cognome, C1.nome
FROM persone AS C1
LEFT JOIN ordini AS C2
ON C1.CF = C2.cliente

GROUP BY C1.CF, C1.cognome, C1.nome
HAVING (COUNT(C2.codice) > 0)
