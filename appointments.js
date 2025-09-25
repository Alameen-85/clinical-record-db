const express = require("express");

module.exports = function (db) {
    const router = express.Router();

    // Create appointment
    router.post("/", (req, res) => {
        const { patient_id, appointment_date, doctor_name, reason } = req.body;
        db.query(
            "INSERT INTO Appointments (patient_id, appointment_date, doctor_name, reason) VALUES (?, ?, ?, ?)",
            [patient_id, appointment_date, doctor_name, reason],
            (err, result) => {
                if (err) return res.status(500).json(err);
                res.json({ message: "Appointment created", appointmentId: result.insertId });
            }
        );
    });

    // Read all appointments
    router.get("/", (req, res) => {
        db.query("SELECT * FROM Appointments", (err, rows) => {
            if (err) return res.status(500).json(err);
            res.json(rows);
        });
    });

    // Update appointment
    router.put("/:id", (req, res) => {
        const { id } = req.params;
        const { doctor_name } = req.body;
        db.query(
            "UPDATE Appointments SET doctor_name = ? WHERE appointment_id = ?",
            [doctor_name, id],
            (err) => {
                if (err) return res.status(500).json(err);
                res.json({ message: "Appointment updated" });
            }
        );
    });

    // Delete appointment
    router.delete("/:id", (req, res) => {
        const { id } = req.params;
        db.query("DELETE FROM Appointments WHERE appointment_id = ?", [id], (err) => {
            if (err) return res.status(500).json(err);
            res.json({ message: "Appointment deleted" });
        });
    });

    return router;
};
