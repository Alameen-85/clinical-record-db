-- Create the database
CREATE DATABASE clinic_records_db;

-- Use the database
USE clinic_records_db;

-- =============================
-- Patients Table
-- =============================
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    address VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =============================
-- Doctors Table
-- =============================
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialty VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    hire_date DATE NOT NULL
);

-- =============================
-- Appointments Table
-- =============================
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATETIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',

    CONSTRAINT fk_patient FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE,
    CONSTRAINT fk_doctor FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE
);

-- =============================
-- Treatments Table
-- =============================
CREATE TABLE Treatments (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    diagnosis VARCHAR(255) NOT NULL,
    prescription TEXT,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_appointment FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);

-- =============================
-- Bills Table
-- =============================
CREATE TABLE Bills (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL CHECK (amount >= 0),
    payment_status ENUM('Pending', 'Paid', 'Cancelled') DEFAULT 'Pending',
    issued_date DATE NOT NULL DEFAULT (CURRENT_DATE),

    CONSTRAINT fk_bill_appointment FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id) ON DELETE CASCADE
);

-- =============================
-- Sample Data
-- =============================

-- Insert Patients
INSERT INTO Patients (first_name, last_name, date_of_birth, gender, phone, email, address)
VALUES
('John', 'Doe', '1985-06-15', 'Male', '08012345678', 'john.doe@example.com', '123 Main St, Lagos'),
('Mary', 'Smith', '1992-03-22', 'Female', '08098765432', 'mary.smith@example.com', '45 Hospital Rd, Abuja');

-- Insert Doctors
INSERT INTO Doctors (first_name, last_name, specialty, phone, email, hire_date)
VALUES
('Alice', 'Johnson', 'Cardiology', '07011112222', 'alice.johnson@clinic.com', '2020-01-10'),
('Bob', 'Williams', 'Pediatrics', '07033334444', 'bob.williams@clinic.com', '2019-05-15');

-- Insert Appointments
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status)
VALUES
(1, 1, '2025-09-25 10:00:00', 'Scheduled'),
(2, 2, '2025-09-26 14:30:00', 'Scheduled');

-- Insert Treatments
INSERT INTO Treatments (appointment_id, diagnosis, prescription, notes)
VALUES
(1, 'Hypertension', 'Amlodipine 5mg daily', 'Monitor BP weekly'),
(2, 'Flu', 'Paracetamol 500mg, 3x daily', 'Plenty of rest and fluids');

-- Insert Bills
INSERT INTO Bills (appointment_id, amount, payment_status)
VALUES
(1, 15000.00, 'Pending'),
(2, 5000.00, 'Paid');
