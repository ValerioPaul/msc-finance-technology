SELECT madre AS genitore, figlio
FROM maternita

UNION

SELECT padre AS genitore, figlio
FROM paternita

ORDER BY figlio, genitore
