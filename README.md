# Clinic Records Database

## Overview
This is a relational database designed for managing clinic records. It includes patients, doctors, appointments, treatments, and billing information. The design ensures proper relationships, constraints, and data integrity.

## Database Schema
- **Patients** – Stores patient personal details.
- **Doctors** – Stores doctor details and specialties.
- **Appointments** – Links patients with doctors for a scheduled visit.
- **Treatments** – Records diagnosis, prescriptions, and treatment notes.
- **Bills** – Tracks billing and payment status for appointments.

## Features
- Primary keys, foreign keys, unique, and not null constraints.
- One-to-Many relationships: Doctors → Appointments, Patients → Appointments.
- One-to-One relationships: Appointment → Treatment, Appointment → Bill.
- Sample data included.

## How to Run
1. Install MySQL on your system.
2. Save the file `clinic_records.sql`.
3. Run the following command in terminal:
   ```bash
   mysql -u root -p < clinic_records.sql
