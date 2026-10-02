SELECT C2.nome AS nome_paese, COUNT(C1.id) AS numero_di_dipartimenti

FROM dipartimento AS C1
JOIN paese AS C2 ON C1.paese = C2.id
WHERE C1.numeroDiDipendenti > 10

GROUP BY C2.nome

ORDER BY C2.nome;
