-- FitTrack Pro Database Schema

.open fittrackpro.sqlite
.mode column

-- Enable foreign keys
PRAGMA foreign_keys = ON;

-- Drop tables if they exist
DROP TABLE IF EXISTS equipment_maintenance_log;
DROP TABLE IF EXISTS member_health_metrics;
DROP TABLE IF EXISTS personal_training_sessions;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS class_attendance;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS memberships;
DROP TABLE IF EXISTS class_schedule;
DROP TABLE IF EXISTS classes;
DROP TABLE IF EXISTS equipment;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS members;
DROP TABLE IF EXISTS locations;

-- locations Table
CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    address TEXT NOT NULL,
    phone_number CHAR(15) NOT NULL CHECK(length(phone_number) >= 7),
    email VARCHAR(255) NOT NULL UNIQUE CHECK(email LIKE '%_@__%.__%'),
    opening_hours VARCHAR(50) NOT NULL
);

-- members table
CREATE TABLE members (
    member_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE CHECK(email LIKE '%_@__%.__%'),
    phone_number CHAR(15) NOT NULL CHECK(length(phone_number) >= 7),
    date_of_birth DATE NOT NULL CHECK(date_of_birth <= CURRENT_DATE),
    join_date DATE NOT NULL CHECK(join_date <= CURRENT_DATE),
    emergency_contact_name VARCHAR(100) NOT NULL,
    emergency_contact_phone CHAR(15) NOT NULL CHECK(emergency_contact_phone LIKE '555-____')
);

-- staff table
CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE CHECK(email LIKE '%_@__%.__%'),
    phone_number CHAR(15) NOT NULL CHECK(length(phone_number) >= 7),
    position VARCHAR(50) CHECK(position IN ('Trainer', 'Manager', 'Receptionist', 'Maintenance')) NOT NULL,
    hire_date DATE NOT NULL CHECK(hire_date <= CURRENT_DATE),
    location_id INTEGER NOT NULL,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

-- equipment table
CREATE TABLE equipment (
    equipment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50) CHECK(type IN ('Cardio', 'Strength')) NOT NULL,
    purchase_date DATE NOT NULL CHECK(purchase_date <= CURRENT_DATE),
    last_maintenance_date DATE NOT NULL CHECK(last_maintenance_date <= CURRENT_DATE),
    next_maintenance_date DATE NOT NULL CHECK(next_maintenance_date > last_maintenance_date),
    location_id INTEGER NOT NULL,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

-- classes table
CREATE TABLE classes (
    class_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    capacity INTEGER NOT NULL CHECK(capacity > 0),
    duration INTEGER NOT NULL CHECK(duration > 0),
    location_id INTEGER NOT NULL,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

-- class_schedule table
CREATE TABLE class_schedule (
    schedule_id INTEGER PRIMARY KEY AUTOINCREMENT,
    class_id INTEGER NOT NULL,
    staff_id INTEGER NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL CHECK(end_time > start_time),
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE
);

-- memberships table
CREATE TABLE memberships (
    membership_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    type VARCHAR(50) CHECK(type IN ('Premium', 'Basic')) NOT NULL,
    start_date DATE NOT NULL CHECK(start_date <= CURRENT_DATE),
    end_date DATE NOT NULL CHECK(end_date >= start_date),
    status VARCHAR(50) CHECK(status IN ('Active', 'Inactive')) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

-- attendance table
CREATE TABLE attendance (
    attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    check_in_time DATETIME NOT NULL CHECK(check_in_time <= CURRENT_TIMESTAMP),
    check_out_time DATETIME CHECK(check_out_time IS NULL OR check_out_time > check_in_time),
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES members(location_id) ON DELETE CASCADE
);

-- class_attendance table
CREATE TABLE class_attendance(
    class_attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    schedule_id INTEGER NOT NULL,
    member_id INTEGER NOT NULL,
    attendance_status VARCHAR(50) CHECK(attendance_status IN ('Registered', 'Attended', 'Unattended')) NOT NULL,
    FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

-- payments table
CREATE TABLE payments(
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    amount REAL NOT NULL CHECK(amount > 0),
    payment_date DATETIME NOT NULL CHECK(payment_date <= CURRENT_TIMESTAMP),
    payment_method VARCHAR(50) CHECK(payment_method IN ('Credit Card', 'Bank Transfer', 'PayPal', 'Cash')) NOT NULL,
    payment_type VARCHAR(50) CHECK(payment_type IN ('Monthly membership fee', 'Day pass')) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

-- personal_training_sessions table
CREATE TABLE personal_training_sessions(
    session_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    staff_id INTEGER NOT NULL,
    session_date TEXT NOT NULL CHECK(session_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
    start_time TIME NOT NULL,
    end_time TIME NOT NULL CHECK(end_time > start_time),
    notes TEXT NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE
);

-- member_health_metrics table
CREATE TABLE member_health_metrics(
    metric_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    measurement_date DATE NOT NULL CHECK(measurement_date <= CURRENT_DATE),
    weight REAL NOT NULL CHECK(weight = ROUND(weight,1)),
    body_fat_percentage REAL NOT NULL CHECK(body_fat_percentage = ROUND(body_fat_percentage,1)),
    muscle_mass REAL NOT NULL CHECK(muscle_mass = ROUND(muscle_mass,1)),
    bmi REAL NOT NULL CHECK(bmi = ROUND(bmi,1)),
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

-- equipment_maintenance_log table
CREATE TABLE equipment_maintenance_log(
    log_id INTEGER PRIMARY KEY AUTOINCREMENT,
    equipment_id INTEGER NOT NULL,
    maintenance_date TEXT NOT NULL CHECK(session_date GLOB '[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9]'),
    description TEXT NOT NULL,
    staff_id INTEGER NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE,
    FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id) ON DELETE CASCADE
);