-- Test data (not part of the exercise): written to exercise the queries,
-- including a client with no account, an account with no orders and a tie.
INSERT INTO clienti VALUES
    (1, 'Anna',  'anna@example.com',  'alto'),
    (2, 'Bruno', 'bruno@example.com', 'basso'),
    (3, 'Carla', 'carla@example.com', 'alto'),
    (4, 'Dario', 'dario@example.com', 'medio');   -- no account at all
INSERT INTO conti VALUES (10, 1), (11, 1), (12, 2), (13, 3);   -- 13: no orders
INSERT INTO assets VALUES
    (100, 'BTC',  'Bitcoin',   'Crypto'),
    (101, 'ETH',  'Ethereum',  'Crypto'),
    (102, 'AAPL', 'Apple',     'Equity'),
    (103, 'BTP',  'BTP 2030',  'Bond');
INSERT INTO ordini VALUES
    (1000, 10, 100, 50),
    (1001, 11, 102, 10),
    (1002, 10, 101, 45),
    (1003, 12, 102, 60),
    (1004, 12, 103, 5),
    (1005, 12, 100, 20);
