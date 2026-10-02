-- The data shown in the exercise. The third order appears as "03" in the text,
-- most likely 103 with a digit lost; the descriptions are elided there ("...").
INSERT INTO persone VALUES ('RSSMRA', 'Rossi', 'Mario'), ('BNCLGU', 'Bianco', 'Luigi'),
                           ('VRDLCU', 'Verdi', 'Luca'),  ('MROMRA', 'Mori', 'Mario');
INSERT INTO ordini VALUES (101, 'RSSMRA', '...'), (102, 'RSSMRA', '...'), (103, 'BNCLGU', '...');
INSERT INTO rateemesse VALUES
    (20010, 101, '2018-01-15', 250, '2018-02-10'),
    (20011, 101, '2018-04-15', 100, '2018-05-20'),
    (20012, 101, '2018-07-15', 120, NULL),
    (20021, 102, '2018-04-15', 130, '2018-05-02'),
    (20022, 102, '2018-07-15', 120, '2018-08-03');
