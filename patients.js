const express = require("express");

module.exports = function (db) {
    const router = express.Router();

    // Create patient
    router.post("/", (req, res) => {
        const { first_name, last_name, dob, gender, phone } = req.body;
        db.query(
            "INSERT INTO Patients (first_name, last_name, dob, gender, phone) VALUES (?, ?, ?, ?, ?)",
            [first_name, last_name, dob, gender, phone],
            (err, result) => {
                if (err) return res.status(500).json(err);
                res.json({ message: "Patient created", patientId: result.insertId });
            }
        );
    });

    // Read all patients
    router.get("/", (req, res) => {
        db.query("SELECT * FROM Patients", (err, rows) => {
            if (err) return res.status(500).json(err);
            res.json(rows);
        });
    });

    // Update patient
    router.put("/:id", (req, res) => {
        const { id } = req.params;
        const { phone } = req.body;
        db.query(
            "UPDATE Patients SET phone = ? WHERE patient_id = ?",
            [phone, id],
            (err, result) => {
                if (err) return res.status(500).json(err);
                res.json({ message: "Patient updated" });
            }
        );
    });

    // Delete patient
    router.delete("/:id", (req, res) => {
        const { id } = req.params;
        db.query("DELETE FROM Patients WHERE patient_id = ?", [id], (err) => {
            if (err) return res.status(500).json(err);
            res.json({ message: "Patient deleted" });
        });
    });

    return router;
};
