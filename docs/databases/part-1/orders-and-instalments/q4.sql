CREATE VIEW importo_Totale AS
SELECT C1.ordine, SUM(C1.importo) AS importoTotale
FROM rateemesse AS C1
JOIN ordini AS C2
ON C1.ordine = C2.codice
GROUP BY C1.ordine;

CREATE VIEW importo_Totale_Pagato AS
SELECT C1.ordine, SUM(C1.importo) AS importoTotalePagato
FROM rateemesse AS C1
LEFT JOIN ordini AS C2
ON C1.ordine = C2.codice
WHERE datapagamento IS NOT NULL
GROUP BY C1.ordine;

SELECT importo_Totale.ordine,
importo_Totale.importoTotale,
importo_Totale_Pagato.importoTotalePagato,
importo_Totale.importoTotale - importo_Totale_Pagato.importoTotalePagato AS debito
FROM importo_Totale
JOIN importo_Totale_Pagato
ON importo_Totale.ordine = importo_Totale_Pagato.ordine
