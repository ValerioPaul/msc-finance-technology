-- Test data (not part of the exercise): an empty room on floor 1, a painting in
-- storage (no room), and an artist with two paintings in the same room.
INSERT INTO Artisti VALUES ('CAR', 'Caravaggio', 'Michelangelo'), ('RAF', 'Sanzio', 'Raffaello'),
                           ('TIZ', 'Vecellio', 'Tiziano');
INSERT INTO Stanze VALUES ('Sala A', 1), ('Sala B', 1), ('Sala C', 2), ('Sala D', 1);   -- Sala D: empty
INSERT INTO Quadri VALUES
    (1, 'CAR', 'Canestra di frutta', 'Sala A', 1599),
    (2, 'CAR', 'Bacchino malato',    'Sala A', 1594),
    (3, 'RAF', 'Madonna del prato',  'Sala A', 1506),
    (4, 'RAF', 'La velata',          'Sala B', 1516),
    (5, 'TIZ', 'Venere di Urbino',   'Sala C', 1538),
    (6, 'TIZ', 'Flora',              NULL,     1515);    -- in storage
