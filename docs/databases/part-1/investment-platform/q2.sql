SELECT c4.ticker, c4.nome_asset, c4.categoria, c3.quantita
FROM clienti AS c1
JOIN conti AS c2
ON c1.id_cliente = c2.id_cliente
JOIN ordini AS c3
ON c2.id_conto = c3.id_conto
JOIN assets AS c4
ON c3.id_asset = c4.id_asset
WHERE c4.categoria = 'crypto' AND c1.profilo_rischio = 'alto'
