-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- VALID TEST: Insert a valid payment
INSERT INTO payments (member_id, amount, payment_date, payment_method, payment_type)
VALUES (15, 50.00, DATETIME('now', '-1 hour'), 'Credit Card', 'Monthly membership fee');
-- EXPECTED OUTPUT: Insert successful.

-- INVALID TEST: Insert a payment with a negative amount
INSERT INTO payments (member_id, amount, payment_date, payment_method, payment_type)
VALUES (16, -20.00, DATETIME('now', '-1 hour'), 'Cash', 'Day pass');
-- EXPECTED OUTPUT: Error due to CHECK(amount > 0).

-- BOUNDARY TEST: Insert a payment with the smallest valid amount
INSERT INTO payments (member_id, amount, payment_date, payment_method, payment_type)
VALUES (17, 0.01, DATETIME('now', '-1 hour'), 'PayPal', 'Day pass');
-- EXPECTED OUTPUT: Insert successful.

-- WRONG DATA TEST: Insert a payment with an invalid payment method
INSERT INTO payments (member_id, amount, payment_date, payment_method, payment_type)
VALUES (18, 25.00, DATETIME('now', '-1 hour'), 'Crypto', 'Monthly membership fee');
-- EXPECTED OUTPUT: Error due to CHECK(payment_method IN ('Credit Card', 'Bank Transfer', 'PayPal', 'Cash')).

-- ABSENT DATA TEST: Insert a payment with NULL payment_type
INSERT INTO payments (member_id, amount, payment_date, payment_method)
VALUES (19, 30.00, DATETIME('now', '-1 hour'), 'Bank Transfer');
-- EXPECTED OUTPUT: Error due to NOT NULL constraint on payment_type.