SELECT C1.aeroporto_partenza, C3.citta, COUNT(C1.numero_volo) AS num_voli

FROM volo AS C1
JOIN volo_reale AS C2
ON C1.numero_volo = C2.numero_volo
JOIN aeroporto AS C3
ON C1.aeroporto_partenza = C3.codice_aeroporto

WHERE C2.data_partenza_programmata = '2023-07-04'
GROUP BY C1.aeroporto_partenza, C3.citta
