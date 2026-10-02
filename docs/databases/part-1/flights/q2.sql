CREATE VIEW sum_punti AS
SELECT C1.nome, C1.cognome, SUM(C2.punti) AS punti

FROM utente_registrato AS C1
JOIN frequent_flyer AS C2
ON C1.id_frequent_flyer = C2.id_frequent_flyer

GROUP BY C1.nome, C1.cognome
ORDER BY C1.nome, C1.cognome, C2.punti;

SELECT nome, cognome, punti
FROM sum_punti
WHERE punti = (SELECT MAX(punti) FROM sum_punti)
