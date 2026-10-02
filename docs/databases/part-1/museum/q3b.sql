-- it could also be solved as follows, more directly (without left join and where)

SELECT C1.nome AS nome_stanza , C1.piano AS piano_stanza, C3.nome AS nome_artista, C3.cognome AS cognome_artista, COUNT(C2.stanza) AS numero_opere_esposte

FROM Stanze AS C1
JOIN Quadri AS C2
ON C1.nome = C2.stanza
JOIN Artisti AS C3
ON C2.artista = C3.codice

WHERE C1.piano = 1

GROUP BY C1.nome, C1.piano, C3.nome, C3.cognome
