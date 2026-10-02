SELECT C1.nome, C1.piano, COUNT(C2.stanza) AS numero_totoale_quadri

FROM Stanze AS C1
LEFT JOIN Quadri AS C2
ON C1.nome = C2.stanza

WHERE C1.piano = 1

GROUP BY C1.nome, C1.piano
