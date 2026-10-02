SELECT C1.nome AS nome_citta, C2.nome AS nome_paese

FROM citta AS C1
JOIN paese AS C2
ON C1.paeseid = C2.id

ORDER BY C1.nome
