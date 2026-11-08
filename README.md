Crownfield Eye Hospital — Database Development

Module: CPU4103 — Introduction to Database

Student: Hina Javed

Database platform: MySQL 8.0 / MySQL Workbench

Project type: Individual SQL submission based on a collaborative database design
Project overview
This repository contains the schema, sample data, individual SQL features, security controls, and tests for a fictional ophthalmology database prototype for Crownfield Eye Hospital. It replaces fragmented records with related tables for patients, clinicians, clinics, appointments, diagnoses, prescriptions, medicines, and follow-up plans.

This is coursework using fictional and synthetic data, not a production hospital system or a source of clinical advice.
Individual contribution
My contribution included conceptual, logical and physical database diagrams, normalisation from unnormalised form (UNF) to third normal form (3NF), and individual SQL implementation and validation. My individual SQL work demonstrates aggregation, joins, a correlated subquery, a parameterised stored procedure, follow-up validation triggers, role-based permissions, patient-specific view access, encryption, and transaction control.

The eleven core tables are:

PATIENT, SPECIALTY, CLINICIAN, CLINIC, APPOINTMENT, DIAGNOSIS, APPOINTMENT_DIAGNOSIS, PRESCRIPTION, MEDICINE, PRESCRIPTION_ITEM, and FOLLOW_UP_PLAN.

PATIENT_DB_ACCOUNT and ENCRYPTED_NOTE_DEMO are additional tables used in the access-control and encryption demonstrations.
Requirements
- MySQL 8.0 with InnoDB support and MySQL Workbench (or an equivalent SQL client).
- An account permitted to create databases, tables, triggers, stored procedures, views, roles and test users. Some operations require elevated privileges.
- A separate, disposable coursework database environment. Do not execute these scripts against real patient data or a production database.
SQL files and execution order
The filenames below correspond exactly to the original uploaded files. In MySQL Workbench, open each file and execute its appropriate statements.
Order	File	Purpose and execution notes
1	table creation.sql	Create the crownfield_eye_hospital database, eleven core tables, keys, relationships and constraints. Destructive on rerun: drops core tables. Run in a fresh coursework environment.
2	data_population.sql	Populate the eleven core tables with five source appointment examples and additional labelled synthetic records.
3	6-testing.sql	Test controlled UPDATE, DELETE and a patient orphan check. The temporary patient is deleted during this test, so do not expect repeat execution to have the same before-state.
4	B_Orphan_Reference_Integrity_Test.sql	Additional check that appointments reference existing patients, clinicians and clinics; expected result is zero orphan rows.
5	3-individual queries.sql	Run four queries independently: GROUP BY/HAVING, four-table INNER JOIN, LEFT JOIN, and a correlated subquery.
6	QUERY5 PROCEDURE_CREATION.sql	Create the parameterised sp_patient_appointments stored procedure.
7	Run CALL sp_patient_appointments('OP001');	Test the procedure for patient OP001; this call can be executed directly in Workbench.
8	4-Procedures_AND _triggers.sql	Create INSERT/UPDATE triggers enforcing valid follow-up dates, then test them. Run the test sections separately: the invalid-date INSERT and UPDATE are intentionally expected to fail; complete the verification and cleanup steps afterwards.
9	5-Security.sql	Create four roles, apply grants, create PATIENT_DB_ACCOUNT, create the filtered v_patient_appointments view and provision example patient users. See the credential warning below before publishing.
10	06_testing(1).sql	Security tests: run the mapping query as administrator, and run patient-view and access-denial queries using the appropriate patient account. Do not run the entire file as a single administrator session.
11	07_data_protection.sql	Demonstrate AES-256-CBC encryption with HKDF, a random key, IV and salt, then decrypt a synthetic note. Run key generation, encryption and decryption in the same MySQL session.
12	08_transactions.sql	Demonstrate an uncommitted change being undone by ROLLBACK and a saved change using COMMIT; take the evidence screenshots before the final synthetic-data cleanup.


Supplementary scripts
- Select_from_all tables.sql — inspect the contents of all eleven core tables.
- date format correction.sql — display-format SELECT, not a data-correction UPDATE.
- Q5 -PROCEDURE EXECUTION.sql — contains the stored procedure call and another copy of the trigger creation/testing code. It is an alternative working script, not an additional step after 4-Procedures_AND _triggers.sql; running both full scripts repeats the trigger work.
Do not upload the six duplicate copies that end in (1) where an otherwise identical original exists. An exception is 06_testing(1).sql, which is not a duplicate of 6-testing.sql: it contains patient-view security tests.
Individual SQL features (Part C)
1. Aggregate (GROUP BY and HAVING): identify clinicians with at least two appointments and count their appointments.
2. INNER JOIN: show patient, clinician, clinic and appointment details using four related tables.
3. LEFT JOIN: identify appointments with no associated prescription.
4. Correlated subquery: find patients who have more than one appointment.
5. Stored procedure: sp_patient_appointments(IN p_patient_id VARCHAR(10)), tested using OP001.
6. Triggers: trg_validate_followup_date_insert and trg_validate_followup_date_update prevent a follow-up due date earlier than the appointment date. The triggers set an invalid date to NULL, which is rejected because FOLLOW_UP_PLAN.due_date is NOT NULL; the intentional test errors are expected.
The report includes the questions, explanation and screenshots of the executed results.
Security and data protection (Part D)
Four roles are used: hospital_admin_role, doctor_role, receptionist_role, and patient_role. The patient role has access to v_patient_appointments rather than direct access to the underlying patient and appointment tables. The view filters by the database username through PATIENT_DB_ACCOUNT.

The patient test verifies access to the logged-in patient's appointments, no rows for another patient's identifier, and denial of direct table access.

The data protection demonstration uses ENCRYPTED_NOTE_DEMO and MySQL AES_ENCRYPT() / AES_DECRYPT() with AES-256-CBC, HKDF, a random IV and salt. The encryption key is a temporary session variable, so it is not persistent key management.

Security warning before GitHub upload: 5-Security.sql currently contains fixed example passwords in CREATE USER statements. Do not publish working passwords. Replace them with non-secret placeholders or provide separate local-only user-provisioning instructions; change any passwords that have already been used. Do not upload real patient data or encryption keys.
Test outcomes and interpretation
The coursework tests cover populated table counts, controlled update/delete operations, the absence of orphan appointment references, procedure output for OP001, expected failures for invalid follow-up dates, patient-view permission restrictions, encryption/decryption of a synthetic note, and COMMIT/ROLLBACK behavior. The accompanying report records the observed MySQL Workbench evidence.

Tests are not all designed to run as one uninterrupted batch. Some require different database users; the negative trigger tests are designed to raise errors.
Assumptions and limitations
- The five initial appointments are derived from the fictional assessment scenario; the extra rows are identified as synthetic test records.
- Missing dose, route, frequency and duration are represented by non-clinical text placeholders rather than invented prescribing instructions.
- The source's follow-up intervals are converted into due dates; Planned is an assumed initial status.
- An appointment with the medicine value None is represented without a prescription.
- The core model comprises eleven tables; the login mapping and encrypted-note demo tables extend it for testing.
- This prototype is not clinically validated. Production use would require stronger account provisioning, managed encryption keys, audit logging, broader role testing, and more extensive validation.
Re-running safely
table creation.sql drops and recreates the core tables. After security and encryption scripts have been run, the extra PATIENT_DB_ACCOUNT and ENCRYPTED_NOTE_DEMO tables also reference core tables. Therefore, do not rerun the schema script over an existing populated database without first accounting for these dependent tables. The recommended approach is to recreate a fresh, isolated coursework database and follow the documented order.
Repository evidence
Include the original conceptual, logical, and physical ERD diagrams (including the editable diagram file) in a clearly named ERD/ folder, and ensure the main report and recorded presentation refer to the same schema and SQL.
Attribution
The initial database design was collaborative. The individual SQL features, security experiments, transaction demonstrations and supporting report evidence are presented as my own coursework contribution. Academic sources and MySQL documentation are referenced in the individual assessment report.
