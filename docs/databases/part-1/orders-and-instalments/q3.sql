SELECT C1.ordine, SUM(C1.importo) AS importoTotale

FROM rateemesse AS C1
JOIN ordini AS C2
ON C1.ordine = C2.codice

GROUP BY C1.ordine
