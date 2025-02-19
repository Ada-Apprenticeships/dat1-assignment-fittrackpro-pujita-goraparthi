-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- VALID TEST: Insert a valid class
INSERT INTO classes (name, description, capacity, duration, location_id)
VALUES ('Pilates Basics', 'Introductory pilates class focusing on core strength', 20, 60, 1);
-- EXPECTED OUTPUT: Insert successful.

-- INVALID TEST: Insert a class with zero capacity
INSERT INTO classes (name, description, capacity, duration, location_id)
VALUES ('Invalid Capacity Class', 'A class that should not allow zero capacity', 0, 45, 2);
-- EXPECTED OUTPUT: Error due to CHECK(capacity > 0).

-- BOUNDARY TEST: Insert a class with the minimum allowed capacity (1)
INSERT INTO classes (name, description, capacity, duration, location_id)
VALUES ('Tiny Class', 'A class with the smallest possible capacity', 1, 30, 2);
-- EXPECTED OUTPUT: Insert successful.

-- WRONG DATA TEST: Insert a class with a negative duration
INSERT INTO classes (name, description, capacity, duration, location_id)
VALUES ('Negative Duration Class', 'This class has an incorrect negative duration', 15, -45, 1);
-- EXPECTED OUTPUT: Error due to CHECK(duration > 0).

-- ABSENT DATA TEST: Insert a class without a location_id
INSERT INTO classes (name, description, capacity, duration)
VALUES ('No Location Class', 'This class is missing a location ID', 20, 60);
-- EXPECTED OUTPUT: Error due to NOT NULL constraint on location_id.