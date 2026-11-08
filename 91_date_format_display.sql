SELECT * FROM APPOINTMENT;
SELECT
    appointment_id,
    patient_id,
    clinician_id,
    clinic_id,
    DATE_FORMAT(appointment_date, '%Y-%m-%d') AS appointment_date,
    appointment_time,
    notes
FROM APPOINTMENT
ORDER BY appointment_id;
