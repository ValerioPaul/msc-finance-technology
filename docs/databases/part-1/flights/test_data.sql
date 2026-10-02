-- Test data (not part of the exercise): two users tied on points, an airport with
-- a single flight on 2023-07-06, and a flight that leaves on both dates.
INSERT INTO aeroporto VALUES ('FCO', 'Fiumicino', 'Roma', 'EU', 'IT', 1),
                             ('LIN', 'Linate', 'Milano', 'EU', 'IT', 0),
                             ('CDG', 'Charles de Gaulle', 'Parigi', 'EU', 'FR', 1),
                             ('JFK', 'John F. Kennedy', 'New York', 'NA', 'US', 1);
INSERT INTO volo VALUES ('AZ100', 'FCO', 'LIN', '08:00', '09:10'),
                        ('AZ101', 'LIN', 'FCO', '10:00', '11:10'),
                        ('AF200', 'CDG', 'FCO', '07:30', '09:30'),
                        ('AZ600', 'FCO', 'JFK', '11:00', '15:00');
INSERT INTO volo_reale (id_volo_reale, data_partenza_programmata, numero_volo) VALUES
    (1, '2023-07-04', 'AZ100'), (2, '2023-07-04', 'AZ600'), (3, '2023-07-04', 'AF200'),
    (4, '2023-07-06', 'AZ100'), (5, '2023-07-06', 'AZ600'), (6, '2023-07-06', 'AZ101');
INSERT INTO frequent_flyer VALUES (1, 'C-001', 2, 1200), (2, 'C-002', 3, 5400),
                                  (3, 'C-003', 3, 5400), (4, 'C-004', 1, 300);
INSERT INTO utente_registrato VALUES (1, 'a@x.it', 'Luca', 'Neri', 1), (2, 'b@x.it', 'Marta', 'Gialli', 2),
                                     (3, 'c@x.it', 'Aldo', 'Blu', 3), (4, 'd@x.it', 'Sofia', 'Rosa', 4);
