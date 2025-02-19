-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- VALID TEST: Insert a valid location
INSERT INTO locations (name, address, phone_number, email, opening_hours)
VALUES ('New Gym', '789 Park Ave, Metropolis', '555-9999', 'newgym@fittrackpro.com', '6:00-22:00');
-- EXPECTED OUTPUT: Insert successful.

-- INVALID TEST: Insert a duplicate email
INSERT INTO locations (name, address, phone_number, email, opening_hours)
VALUES ('Duplicate Gym', '456 Osak Rd, Townsburg', '555-5678', 'downtown@fittrackpro.com', '5:00-23:00');
-- EXPECTED OUTPUT: Error due to UNIQUE constraint on email.

-- BOUNDARY TEST: Insert a gym with the shortest valid phone number (7 digits)
INSERT INTO locations (name, address, phone_number, email, opening_hours)
VALUES ('Short Phone Gym', '123 Small St, Town', '555-1234', 'shortphone@fittrackpro.com', '6:00-22:00');
-- EXPECTED OUTPUT: Insert successful.

-- WRONG DATA TEST: Insert an invalid email format
INSERT INTO locations (name, address, phone_number, email, opening_hours)
VALUES ('Invalid Email Gym', '100 Invalid St, Nowhere', '555-1111', 'wrong-email.com', '6:00-22:00');
-- EXPECTED OUTPUT: Error due to CHECK(email LIKE '%_@__%.__%').

-- ABSENT DATA TEST: Insert a location with missing email
INSERT INTO locations (name, address, phone_number, opening_hours)
VALUES ('Missing Email Gym', '200 NoEmail Rd, Nowhere', '555-2222', '6:00-22:00');
-- EXPECTED OUTPUT: Error due to NOT NULL constraint on email.
