-- Initial SQLite setup
.open fittrackpro.sqlite
.mode box

-- VALID TEST: Insert a valid member
INSERT INTO members (first_name, last_name, email, phone_number, date_of_birth, join_date, emergency_contact_name, emergency_contact_phone)
VALUES ('John', 'Doe', 'john.doe@email.com', '555-1234', '1990-05-10', '2025-01-10', 'Jane Doe', '555-5678');
-- EXPECTED OUTPUT: Insert successful.

-- INVALID TEST: Insert a member with a future date of birth
INSERT INTO members (first_name, last_name, email, phone_number, date_of_birth, join_date, emergency_contact_name, emergency_contact_phone)
VALUES ('Future', 'Born', 'future.born@email.com', '555-9999', '2030-01-01', '2025-01-10', 'Backup Contact', '555-7777');
-- EXPECTED OUTPUT: Error due to CHECK(date_of_birth <= CURRENT_DATE).

-- BOUNDARY TEST: Insert a member exactly 18 years old today
INSERT INTO members (first_name, last_name, email, phone_number, date_of_birth, join_date, emergency_contact_name, emergency_contact_phone)
VALUES ('Adult', 'Now', 'adult.now@email.com', '555-5555', DATE('now', '-18 years'), '2025-01-01', 'Parent', '555-6666');
-- EXPECTED OUTPUT: Insert successful.

-- WRONG DATA TEST: Insert a member with an incorrectly formatted email
INSERT INTO members (first_name, last_name, email, phone_number, date_of_birth, join_date, emergency_contact_name, emergency_contact_phone)
VALUES ('Invalid', 'Email', 'wrong-email.com', '555-4321', '1990-06-20', '2025-02-01', 'Backup Contact', '555-1111');
-- EXPECTED OUTPUT: Error due to CHECK(email LIKE '%_@__%.__%').

-- ABSENT DATA TEST: Insert a member with NULL phone number
INSERT INTO members (first_name, last_name, email, date_of_birth, join_date, emergency_contact_name, emergency_contact_phone)
VALUES ('NoPhone', 'User', 'nophone@email.com', '1990-01-01', '2025-01-01', 'Friend', '555-8888');
-- EXPECTED OUTPUT: Error due to NOT NULL constraint on phone_number.