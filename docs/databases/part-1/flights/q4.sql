CREATE VIEW numero_voli_view AS
SELECT C1.aeroporto_partenza, COUNT(C2.numero_volo) AS numero_voli

FROM volo AS C1
JOIN volo_reale AS C2
ON C1.numero_volo = C2.numero_volo

WHERE data_partenza_programmata = '2023-07-06'
GROUP BY C1.aeroporto_partenza;

SELECT aeroporto_partenza, numero_voli
FROM numero_voli_view
WHERE numero_voli > 1
