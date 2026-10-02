CREATE VIEW primo AS
SELECT C1.numero_volo, C2.citta AS citta_partenza, C1.aeroporto_arrivo
FROM VOLO AS C1
JOIN AEROPORTO AS C2
ON C1.aeroporto_partenza = C2.codice_aeroporto;

SELECT D1.numero_volo, D1.citta_partenza, D2.citta AS citta_arrivo
FROM primo AS D1
JOIN AEROPORTO AS D2
ON D1.aeroporto_arrivo = D2.codice_aeroporto
ORDER BY numero_volo
