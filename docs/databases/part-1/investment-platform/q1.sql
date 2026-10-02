SELECT DISTINCT c1.id_cliente, c1.nome, c1.email
FROM clienti AS c1
JOIN conti AS c2
ON c1.id_cliente = c2.id_cliente
JOIN ordini AS c3
ON c2.id_conto = c3.id_conto

WHERE c3.quantita > 40
ORDER BY c1.id_cliente
