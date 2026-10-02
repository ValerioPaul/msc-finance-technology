-- Test data (not part of the exercise): two composers named Rossi, a composer
-- with no pieces, a piece never played, and a tie for the most pieces played.
INSERT INTO Compositori VALUES (1, 'Rossi', 'Gioachino'), (2, 'Rossi', 'Luigi'),
                               (3, 'Bianchi', 'Anna'), (4, 'Verdi', 'Giuseppe');
INSERT INTO Pezzi VALUES (10, 'Overture A', 1, 8), (11, 'Aria B', 1, 4),
                         (12, 'Sonata C', 2, 12), (13, 'Studio D', 3, 6),
                         (14, 'Notturno E', 3, 7), (15, 'Preludio F', 2, 3);
INSERT INTO Concerti VALUES (100, 'Spring', 'Season opening'), (101, 'Summer', 'Open air');
INSERT INTO Programmazione VALUES (10, 100, 1), (11, 100, 2), (13, 100, 3),
                                  (10, 101, 1), (14, 101, 2), (12, 101, 3);
