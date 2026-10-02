SELECT C1.nome AS nome_artista, C1.cognome AS cognome_artista, C3.nome AS nome_stanza

FROM Artisti AS C1
JOIN Quadri AS C2
ON C1.codice = C2.artista
JOIN Stanze AS C3
ON C2.stanza = C3.nome

GROUP BY C1.nome, C1.cognome, C3.nome

HAVING COUNT (C2.codice) >= 2 -- having filters AFTER the grouping (where would not work here, because it filters before)
