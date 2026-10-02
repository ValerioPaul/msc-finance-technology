-- Test data (not part of the exercise): a country with no large department and
-- two countries with cities of the same name.
INSERT INTO paese VALUES (1, 'Italia'), (2, 'Francia'), (3, 'Spagna');
INSERT INTO citta VALUES (1, 1, 'Roma', 2800000), (2, 1, 'Milano', 1400000),
                         (1, 2, 'Parigi', 2100000), (2, 2, 'Lione', 520000),
                         (1, 3, 'Valencia', 790000);
INSERT INTO dipartimento VALUES
    (10, 'Ricerca',   25, 1, 1, NULL),
    (11, 'Vendite',    8, 2, 1, NULL),
    (12, 'Finanza',   40, 2, 1, NULL),
    (13, 'Logistica', 15, 1, 2, NULL),
    (14, 'Marketing',  5, 1, 3, NULL);
