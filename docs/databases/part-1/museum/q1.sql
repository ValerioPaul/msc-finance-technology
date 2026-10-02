SELECT C1.codice, C1.descrizione, C3.cognome, C3.nome

FROM Quadri AS C1
JOIN Stanze AS C2
ON C1.stanza = C2.nome
JOIN Artisti AS C3
ON C1.artista = C3.codice

WHERE C2.piano = 1
