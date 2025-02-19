-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- VALID TEST: Insert a valid staff member
INSERT INTO staff (first_name, last_name, email, phone_number, position, hire_date, location_id)
VALUES ('Michael', 'Scott', 'michael.scott@fittrackpro.com', '555-7890', 'Manager', '2024-11-20', 1);
-- EXPECTED OUTPUT: Insert successful.

-- INVALID TEST: Insert a staff member with an invalid position
INSERT INTO staff (first_name, last_name, email, phone_number, position, hire_date, location_id)
VALUES ('Jim', 'Halpert', 'jim.halpert@fittrackpro.com', '555-1234', 'CEO', '2024-11-20', 1);
-- EXPECTED OUTPUT: Error due to CHECK(position IN ('Trainer', 'Manager', 'Receptionist', 'Maintenance')).

-- BOUNDARY TEST: Insert a staff member hired exactly today
INSERT INTO staff (first_name, last_name, email, phone_number, position, hire_date, location_id)
VALUES ('Pam', 'Beesly', 'pam.beesly@fittrackpro.com', '555-5678', 'Receptionist', DATE('now'), 2);
-- EXPECTED OUTPUT: Insert successful.

-- WRONG DATA TEST: Insert a staff member with an incorrectly formatted email
INSERT INTO staff (first_name, last_name, email, phone_number, position, hire_date, location_id)
VALUES ('Stanley', 'Hudson', 'stanley.hudson.com', '555-2468', 'Trainer', '2024-11-20', 1);
-- EXPECTED OUTPUT: Error due to CHECK(email LIKE '%_@__%.__%').

-- ABSENT DATA TEST: Insert a staff member with NULL location_id
INSERT INTO staff (first_name, last_name, email, phone_number, position, hire_date)
VALUES ('Kevin', 'Malone', 'kevin.malone@fittrackpro.com', '555-3579', 'Maintenance', '2024-11-20');
-- EXPECTED OUTPUT: Error due to NOT NULL constraint on location_id.