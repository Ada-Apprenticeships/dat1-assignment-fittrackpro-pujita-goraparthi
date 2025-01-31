.open fittrackpro.sqlite

-- Enable foreign keys
PRAGMA foreign_keys = ON;

-- locations Table
CREATE TABLE locations (
    location_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    address TEXT NOT NULL,
    phone_number TEXT NOT NULL,
    email TEXT NOT NULL,
    opening_hours TEXT NOT NULL
);

-- members table
CREATE TABLE members (
    member_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email UNIQUE TEXT NOT NULL,
    phone_number TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    join_date DATE NOT NULL,
    emergency_contact_name TEXT NOT NULL,
    emergency_contact_phone TEXT NOT NULL
);

-- staff table
CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email UNIQUE TEXT NOT NULL,
    phone_number TEXT NOT NULL,
    position TEXT CHECK(position IN ('Trainer', 'Manager', 'Receptionist', 'Maintenance')) NOT NULL,
    hire_date DATE NOT NULL,
    location_id INTEGER NOT NULL,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

-- equipment table
CREATE TABLE equipment (
    equipment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    type TEXT CHECK(type IN ('Cardio', 'Strength')) NOT NULL,
    purchase_date DATE NOT NULL,
    last_maintenance_date DATE NOT NULL,
    next_maintenance_date DATE NOT NULL,
    location_id INTEGER NOT NULL,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

-- classes table
CREATE TABLE classes (
    class_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    capacity INTEGER NOT NULL,
    duration INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    FOREIGN KEY (location_id) REFERENCES locations(location_id) ON DELETE CASCADE
);

-- class_schedule table
CREATE TABLE class_schedule (
    schedule_id INTEGER PRIMARY KEY AUTOINCREMENT,
    class_id INTEGER NOT NULL,
    staff_id INTEGER NOT NULL,
    start_time DATETIME NOT NULL,
    end_time DATETIME NOT NULL,
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE
);

-- memberships table
CREATE TABLE members (
    membership_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    type TEXT CHECK(type IN ('Premium', 'Basic')) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status TEXT CHECK(status IN ('Active', 'Inactive')) NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

-- attendance table
CREATE TABLE attendance (
    attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    check_in_time DATETIME NOT NULL,
    check_out_time DATETIME NOT NULL,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES members(location_id) ON DELETE CASCADE
);

-- class_attendance table
CREATE TABLE class_attendance(
    class_attendance_id INTEGER PRIMARY KEY AUTOINCREMENT,
    schedule_id INTEGER NOT NULL,
    member_id INTEGER NOT NULL,
    attendance_status TEXT CHECK(attendance_status IN('Registered', 'Attended', 'Unattended')) NOT NULL,
    FOREIGN KEY (schedule_id) REFERENCES class_schedule(schedule_id) ON DELETE CASCADE,
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE
);

-- payments table
CREATE TABLE payments(
    payment_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    amount REAL NOT NULL,
    payment_date DATETIME NOT NULL,
    payment_method TEXT CHECK(payment_method IN ('Credit Card', 'Bank Transfer', 'PayPal', 'Cash')) NOT NULL,
    payment_type TEXT CHECK(payment_type IN ('Monthly membership fee', 'Day pass')) NOT NULL,
    FOREIGN KEY member_id REFERENCES members(member_id) ON DELETE CASCADE
);

-- personal_training_sessions table
CREATE TABLE personal_training_sessions(
    session_id INTEGER PRIMARY KEY AUTOINCREMENT,
    member_id INTEGER NOT NULL,
    staff_id INTEGER NOT NULL,
    session_date NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    notes TEXT NOT NULL,
    FOREIGN KEY member_id REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY staff_id REFERENCES staff(staff_id) ON DELETE CASCADE
);