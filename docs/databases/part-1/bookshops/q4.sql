CREATE VIEW quantita_libri_view AS

SELECT C1.id AS id_libreria, C1.indirizzo, C1.città, COUNT(C2.quantità) AS quantita_libri

FROM Librerie AS C1
JOIN Disponibilita AS C2
ON C1.id = C2.libreria

GROUP BY id_libreria, C1.indirizzo, C1.città;

SELECT id_libreria, indirizzo, città
FROM quantita_libri_view
WHERE quantita_libri = (SELECT MAX(quantita_libri) FROM quantita_libri_view)
