
-- CROWNFIELD EYE HOSPITAL
-- FILE: 02_data_population.sql
-- Run AFTER 01_table_creation.sql
-- Original sample records and clearly identified synthetic test records.

USE crownfield_eye_hospital;

-- 1. PATIENT
INSERT INTO PATIENT
(patient_id, first_name, last_name, postcode) VALUES
('OP001','Amina','Yusuf','NE1 4AB'),
('OP002','Daniel','Reed','N16 7QP'),
('OP003','Sofia','Bennett','E8 2LD'),
('OP004','Michael','Okoro','SE6 3RT'),
('SYN001','Amara','Cole','TEST-001'),
('SYN002','Noah','Patel','TEST-002'),
('SYN003','Isla','Morgan','TEST-003'),
('SYN004','Ethan','Ali','TEST-004'),
('SYN005','Maya','Clarke','TEST-005'),
('SYN006','Leo','Wilson','TEST-006'),
('SYN007','Freya','Khan','TEST-007'),
('SYN008','Theo','Brown','TEST-008'),
('SYN009','Ava','Hughes','TEST-009'),
('SYN010','Adam','Shah','TEST-010'),
('SYN011','Zara','Lewis','TEST-011'),
('TST_DELETE','Test','Delete','TEST-DEL');

-- 2. SPECIALTY
INSERT INTO SPECIALTY (specialty_id, specialty_name) VALUES
(1,'Glaucoma'),
(2,'Retina'),
(3,'Cornea'),
(4,'Synthetic Specialty - Cataract'),
(5,'Synthetic Specialty - Paediatric Ophthalmology'),
(6,'Synthetic Specialty - Neuro-ophthalmology'),
(7,'Synthetic Specialty - Uveitis'),
(8,'Synthetic Specialty - Oculoplastics'),
(9,'Synthetic Specialty - Ocular Oncology'),
(10,'Synthetic Specialty - Low Vision'),
(11,'Synthetic Specialty - Refractive Surgery'),
(12,'Synthetic Specialty - Emergency Eye Care'),
(13,'Synthetic Specialty - Medical Retina');

-- 3. CLINICIAN
INSERT INTO CLINICIAN
(clinician_id, clinician_name, specialty_id) VALUES
(1,'Dr Maya Shah',1),
(2,'Dr Leo Grant',2),
(3,'Dr Priya Nair',3),
(4,'Synthetic Clinician 01',4),
(5,'Synthetic Clinician 02',5),
(6,'Synthetic Clinician 03',6),
(7,'Synthetic Clinician 04',7),
(8,'Synthetic Clinician 05',8),
(9,'Synthetic Clinician 06',9),
(10,'Synthetic Clinician 07',10),
(11,'Synthetic Clinician 08',11),
(12,'Synthetic Clinician 09',12),
(13,'Synthetic Clinician 10',13);

-- 4. CLINIC
INSERT INTO CLINIC
(clinic_id, clinic_name) VALUES
(1,'City Road'),
(2,'Bedford'),
(3,'Croydon'),
(4,'Synthetic Clinic 01 - North Wing'),
(5,'Synthetic Clinic 02 - South Wing'),
(6,'Synthetic Clinic 03 - East Outpatients'),
(7,'Synthetic Clinic 04 - West Eye Centre'),
(8,'Synthetic Clinic 05 - Paediatric Suite'),
(9,'Synthetic Clinic 06 - Retina Suite'),
(10,'Synthetic Clinic 07 - Cornea Suite'),
(11,'Synthetic Clinic 08 - Imaging Clinic'),
(12,'Synthetic Clinic 09 - Day Treatment Unit'),
(13,'Synthetic Clinic 10 - Review Clinic');

-- 5. DIAGNOSIS
INSERT INTO DIAGNOSIS
(diagnosis_id, diagnosis_name) VALUES
(1,'Ocular hypertension'),
(2,'Diabetic macular oedema'),
(3,'Glaucoma suspect'),
(4,'Keratoconus'),
(5,'Synthetic Diagnosis 01 - Dry eye disease'),
(6,'Synthetic Diagnosis 02 - Cataract'),
(7,'Synthetic Diagnosis 03 - Uveitis'),
(8,'Synthetic Diagnosis 04 - Age-related macular degeneration'),
(9,'Synthetic Diagnosis 05 - Diabetic retinopathy'),
(10,'Synthetic Diagnosis 06 - Retinal detachment'),
(11,'Synthetic Diagnosis 07 - Keratitis'),
(12,'Synthetic Diagnosis 08 - Blepharitis'),
(13,'Synthetic Diagnosis 09 - Optic neuritis'),
(14,'Synthetic Diagnosis 10 - Conjunctivitis');

-- 6. MEDICINE
INSERT INTO MEDICINE
(medicine_id, medicine_name) VALUES
(1,'Latanoprost'),
(2,'Timolol'),
(3,'Aflibercept'),
(4,'Sodium chloride drops'),
(5,'Synthetic Test Medicine 01'),
(6,'Synthetic Test Medicine 02'),
(7,'Synthetic Test Medicine 03'),
(8,'Synthetic Test Medicine 04'),
(9,'Synthetic Test Medicine 05'),
(10,'Synthetic Test Medicine 06'),
(11,'Synthetic Test Medicine 07'),
(12,'Synthetic Test Medicine 08'),
(13,'Synthetic Test Medicine 09'),
(14,'Synthetic Test Medicine 10');

-- 7. APPOINTMENT
INSERT INTO APPOINTMENT
(appointment_id, patient_id, clinician_id, clinic_id,
 appointment_date, appointment_time, notes) VALUES
(1,'OP001',1,1,'2026-10-05','09:00:00','Review IOP'),
(2,'OP002',2,1,'2026-10-05','09:30:00','OCT before review'),
(3,'OP001',1,2,'2026-11-16','10:15:00','Visual field test'),
(4,'OP003',1,1,'2026-10-06','11:00:00','Monitor'),
(5,'OP004',3,3,'2026-10-07','14:00:00','Corneal topography'),
(6,'SYN001',4,4,'2026-11-01','09:00:00','SYNTHETIC TEST RECORD'),
(7,'SYN002',5,5,'2026-11-02','09:30:00','SYNTHETIC TEST RECORD'),
(8,'SYN003',6,6,'2026-11-03','10:00:00','SYNTHETIC TEST RECORD'),
(9,'SYN004',7,7,'2026-11-04','10:30:00','SYNTHETIC TEST RECORD'),
(10,'SYN005',8,8,'2026-11-05','11:00:00','SYNTHETIC TEST RECORD'),
(11,'SYN006',9,9,'2026-11-06','11:30:00','SYNTHETIC TEST RECORD'),
(12,'SYN007',10,10,'2026-11-07','12:00:00','SYNTHETIC TEST RECORD'),
(13,'SYN008',11,11,'2026-11-08','13:00:00','SYNTHETIC TEST RECORD'),
(14,'SYN009',12,12,'2026-11-09','13:30:00','SYNTHETIC TEST RECORD'),
(15,'SYN010',13,13,'2026-11-10','14:00:00','SYNTHETIC TEST RECORD');

-- 8. APPOINTMENT_DIAGNOSIS
INSERT INTO APPOINTMENT_DIAGNOSIS
(appointment_id, diagnosis_id) VALUES
(1,1),(2,2),(3,1),(4,3),(5,4),
(6,5),(7,6),(8,7),(9,8),(10,9),
(11,10),(12,11),(13,12),(14,13),(15,14);

-- 9. PRESCRIPTION
-- Appointment 4 has no medicine in the original dataset.
INSERT INTO PRESCRIPTION
(prescription_id, appointment_id) VALUES
(1,1),(2,2),(3,3),(4,5),
(5,6),(6,7),(7,8),(8,9),(9,10),
(10,11),(11,12),(12,13),(13,14),(14,15);

-- 10. PRESCRIPTION_ITEM
-- Original dose/route/frequency/duration were not supplied.
-- Placeholders below are NOT clinical instructions.
INSERT INTO PRESCRIPTION_ITEM
(prescription_item_id, prescription_id, medicine_id,
 dose, route, frequency, duration) VALUES
(1,1,1,'SOURCE DATA NOT PROVIDED','SOURCE DATA NOT PROVIDED','SOURCE DATA NOT PROVIDED','SOURCE DATA NOT PROVIDED'),
(2,1,2,'SOURCE DATA NOT PROVIDED','SOURCE DATA NOT PROVIDED','SOURCE DATA NOT PROVIDED','SOURCE DATA NOT PROVIDED'),
(3,2,3,'SOURCE DATA NOT PROVIDED','SOURCE DATA NOT PROVIDED','SOURCE DATA NOT PROVIDED','SOURCE DATA NOT PROVIDED'),
(4,3,1,'SOURCE DATA NOT PROVIDED','SOURCE DATA NOT PROVIDED','SOURCE DATA NOT PROVIDED','SOURCE DATA NOT PROVIDED'),
(5,4,4,'SOURCE DATA NOT PROVIDED','SOURCE DATA NOT PROVIDED','SOURCE DATA NOT PROVIDED','SOURCE DATA NOT PROVIDED'),
(6,5,5,'SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY'),
(7,6,6,'SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY'),
(8,7,7,'SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY'),
(9,8,8,'SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY'),
(10,9,9,'SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY'),
(11,10,10,'SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY'),
(12,11,11,'SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY'),
(13,12,12,'SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY'),
(14,13,13,'SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY'),
(15,14,14,'SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY','SYNTHETIC TEST ONLY');

-- 11. FOLLOW_UP_PLAN
-- Source intervals converted to due dates.
-- 'Planned' is an assumed status, not a value from Appendix 1.
INSERT INTO FOLLOW_UP_PLAN
(follow_up_id, appointment_id, due_date, priority, status) VALUES
(1,1,'2026-11-16','High','Planned'),
(2,2,'2026-11-02','Urgent','Planned'),
(3,3,'2027-02-08','Routine','Planned'),
(4,4,'2027-04-06','Routine','Planned'),
(5,5,'2026-12-02','Routine','Planned'),
(6,6,'2026-11-29','Routine','Planned'),
(7,7,'2026-11-30','High','Planned'),
(8,8,'2026-12-01','Urgent','Planned'),
(9,9,'2026-12-02','Routine','Planned'),
(10,10,'2026-12-03','High','Planned'),
(11,11,'2026-12-04','Routine','Planned'),
(12,12,'2026-12-05','Urgent','Planned'),
(13,13,'2026-12-06','Routine','Planned'),
(14,14,'2026-12-07','High','Planned'),
(15,15,'2026-12-08','Routine','Planned');

-- VERIFY ROW COUNTS
SELECT 'PATIENT' AS table_name, COUNT(*) AS row_count FROM PATIENT
UNION ALL SELECT 'SPECIALTY', COUNT(*) FROM SPECIALTY
UNION ALL SELECT 'CLINICIAN', COUNT(*) FROM CLINICIAN
UNION ALL SELECT 'CLINIC', COUNT(*) FROM CLINIC
UNION ALL SELECT 'APPOINTMENT', COUNT(*) FROM APPOINTMENT
UNION ALL SELECT 'DIAGNOSIS', COUNT(*) FROM DIAGNOSIS
UNION ALL SELECT 'APPOINTMENT_DIAGNOSIS', COUNT(*) FROM APPOINTMENT_DIAGNOSIS
UNION ALL SELECT 'PRESCRIPTION', COUNT(*) FROM PRESCRIPTION
UNION ALL SELECT 'MEDICINE', COUNT(*) FROM MEDICINE
UNION ALL SELECT 'PRESCRIPTION_ITEM', COUNT(*) FROM PRESCRIPTION_ITEM
UNION ALL SELECT 'FOLLOW_UP_PLAN', COUNT(*) FROM FOLLOW_UP_PLAN;
