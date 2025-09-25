const express = require("express");
const bodyParser = require("body-parser");
const mysql = require("mysql2");

const app = express();
const PORT = 3000;

// Middleware
app.use(bodyParser.json());

// DB connection
const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "your_password", // replace with your MySQL password
    database: "clinic_records"
});

db.connect(err => {
    if (err) {
        console.error("DB connection failed:", err);
        return;
    }
    console.log("MySQL Connected...");
});

// Routes
const patientsRoutes = require("./routes/patients")(db);
const appointmentsRoutes = require("./routes/appointments")(db);

app.use("/patients", patientsRoutes);
app.use("/appointments", appointmentsRoutes);

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
