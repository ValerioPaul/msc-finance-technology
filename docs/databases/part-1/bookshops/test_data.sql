-- Test data (not part of the exercise): a bookshop with two cheap books, an empty
-- bookshop, and quantities that make "number of titles" and "number of copies" differ.
INSERT INTO Generi VALUES (1, 'Romanzo', NULL), (2, 'Saggio', NULL), (3, 'Giallo', NULL);
INSERT INTO Libri VALUES (1, 'Il nome della rosa', 1, 14.50), (2, 'Sapiens', 2, 22.00),
                         (3, 'La donna della domenica', 3, 11.00), (4, 'Il Gattopardo', 1, 18.00);
INSERT INTO Librerie VALUES (1, 'Via Roma 1', 'Milano'), (2, 'Corso Italia 5', 'Milano'),
                            (3, 'Via Po 10', 'Torino'), (4, 'Piazza Dante 2', 'Napoli');   -- 4: empty
INSERT INTO Disponibilita VALUES
    (1, 1, 3), (1, 3, 2), (1, 2, 1),
    (2, 1, 10), (2, 4, 1),
    (3, 2, 4), (3, 3, 20), (3, 4, 2);
