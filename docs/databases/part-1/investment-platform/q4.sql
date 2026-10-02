-- first query
CREATE VIEW conteggio_ordini_clienti AS
SELECT c1.id_cliente, c1.nome, c1.email, COUNT(c3.id_ordine) AS numero_ordini
FROM clienti AS c1
LEFT JOIN conti AS c2
ON c1.id_cliente = c2.id_cliente
LEFT JOIN ordini AS c3
ON c2.id_conto = c3.id_conto
GROUP BY c1.id_cliente, c1.nome, c1.email;

-- second query
SELECT id_cliente, nome, email
FROM conteggio_ordini_clienti
WHERE numero_ordini = (SELECT MAX(numero_ordini) FROM conteggio_ordini_clienti);
