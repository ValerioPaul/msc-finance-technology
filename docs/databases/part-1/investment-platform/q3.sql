SELECT c1.id_cliente, c1.nome, c1.email, COUNT(c3.id_ordine) AS numero_totale_ordini
FROM clienti AS c1
LEFT JOIN conti AS c2
ON c1.id_cliente = c2.id_cliente
LEFT JOIN ordini AS c3
ON c2.id_conto = c3.id_conto
GROUP BY c1.id_cliente, c1.nome, c1.email
ORDER BY c1.id_cliente
