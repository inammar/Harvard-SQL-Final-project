-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- Add new patients
INSERT INTO "patients" ("first_name", "last_name", "age", "gender") VALUES
('Alice', 'Johnson', 54, 'Female'),
('Robert', 'Smith', 62, 'Male'),
('Linda', 'Martinez', 45, 'Female'),
('James', 'Brown', 70, 'Male'),
('Maria', 'Garcia', 50, 'Female'),
('David', 'Wilson', 38, 'Male'),
('Patricia', 'Miller', 67, 'Female'),
('Michael', 'Davis', 59, 'Male'),
('Barbara', 'Lopez', 47, 'Female'),
('William', 'Anderson', 64, 'Male');


-- Add new doctors and their specialty
INSERT INTO "doctors" ("first_name", "last_name", "specialty") VALUES
('Sarah', 'Lee', 'Oncologist'),
('John', 'Taylor', 'Surgeon'),
('Emma', 'Clark', 'Radiologist'),
('Daniel', 'White', 'Hematologist');


-- Add new diagnoses for the patients
INSERT INTO "diagnoses" ("patient_id", "cancer_type", "stage", "diagnosis_date") VALUES
(1, 'Breast Cancer', 'II', '2020-03-15'),
(2, 'Lung Cancer', 'III', '2019-11-02'),
(3, 'Colon Cancer', 'I', '2021-01-20'),
(4, 'Prostate Cancer', 'II', '2018-07-30'),
(5, 'Breast Cancer', 'III', '2019-05-10'),
(6, 'Leukemia', 'II', '2022-02-18'),
(7, 'Ovarian Cancer', 'I', '2020-10-05'),
(8, 'Liver Cancer', 'III', '2021-06-12'),
(9, 'Breast Cancer', 'I', '2022-01-07'),
(10, 'Lung Cancer', 'II', '2020-08-22');


-- Add new treatments (NOW INCLUDES doctor_id)
INSERT INTO "treatments" ("diagnosis_id", "doctor_id", "treatment_type", "start_date", "end_date") VALUES
(1, 2, 'Surgery', '2020-04-01', '2020-04-15'),
(1, 1, 'Chemotherapy', '2020-05-01', '2020-10-01'),
(2, 1, 'Chemotherapy', '2019-12-01', '2020-05-01'),
(3, 2, 'Surgery', '2021-02-01', '2021-02-10'),
(4, 3, 'Radiation', '2018-09-01', '2018-12-01'),
(5, 2, 'Surgery', '2019-06-01', '2019-06-15'),
(6, 4, 'Chemotherapy', '2022-03-01', '2022-08-01'),
(7, 2, 'Surgery', '2020-11-01', '2020-11-20'),
(8, 3, 'Radiation', '2021-07-01', '2021-10-01'),
(9, 2, 'Surgery', '2022-02-01', '2022-02-15'),
(10, 1, 'Chemotherapy', '2020-09-01', '2021-02-01');


-- Add new medications
INSERT INTO "medications" ("treatment_id", "drug_name", "dosage") VALUES
(2, 'Tamoxifen', '20mg daily'),
(3, 'Cisplatin', '50mg weekly'),
(3, 'Etoposide', '100mg weekly'),
(5, 'Bicalutamide', '50mg daily'),
(2, 'Doxorubicin', '40mg weekly'),
(7, 'Imatinib', '400mg daily'),
(9, 'Sorafenib', '200mg twice daily'),
(11, 'Carboplatin', '450mg monthly');


-- Add new visits
INSERT INTO "visits" ("patient_id", "doctor_id", "visit_date", "reason") VALUES
(1, 2, '2020-03-10', 'Initial consultation'),
(1, 1, '2020-05-05', 'Chemotherapy follow-up'),
(2, 1, '2019-12-10', 'Chemotherapy check'),
(3, 2, '2021-01-25', 'Surgery prep'),
(4, 3, '2018-08-15', 'Radiation consult'),
(5, 2, '2019-05-20', 'Surgery planning'),
(6, 4, '2022-02-25', 'Leukemia treatment plan'),
(7, 2, '2020-10-20', 'Surgery prep'),
(8, 3, '2021-06-20', 'Radiation prep'),
(9, 2, '2022-01-25', 'Breast surgery consult'),
(10, 1, '2020-08-28', 'Chemotherapy plan');


-- Find all visits for the given patient's first and last name
SELECT *
FROM "visits"
WHERE "patient_id" IN (
    SELECT "id"
    FROM "patients"
    WHERE "first_name" = 'Patricia'
    AND "last_name" = 'Miller'
);

-- Find all medications where given treatment was prescribed
SELECT *
FROM "medications"
WHERE "drug_name" = 'Doxorubicin';

-- Find all visits for a given doctor's specialty
SELECT *
FROM "visits"
WHERE "doctor_id" = (
    SELECT "id"
    FROM "doctors"
    WHERE "specialty" = 'Hematologist'
);


--Update visits table and change visit date from 2021-12-10 to 2021-12-11
UPDATE "visits"
SET "visit_date" = '2021-12-11'
WHERE "visit_date" = '2021-12-10';


--List every patient's first name, last name and their visit date
SELECT
    "patients"."first_name",
    "patients"."last_name",
    "visits"."visit_date"
FROM
    "patients"
JOIN
    "visits" ON "patients"."id" = "visits"."patient_id";


--Filter all patients in alphabetical order acc.to their names
SELECT
    "first_name",
    "last_name",
    "age",
    "gender"
FROM
    "patients"
ORDER BY
    "first_name" ASC;

--Count number of visits per doctor
SELECT
    "first_name",
    COUNT(*) AS "visit_count"
FROM "doctors"
JOIN "visits" ON "doctors"."id" = "visits"."doctor_id"
GROUP BY "first_name"
ORDER BY "visit_count" DESC;

--Number of visits of every patient
SELECT
    "first_name",
    COUNT(*) AS "visit_count"
FROM "visits"
JOIN "patients" ON "visits"."patient_id" = "patients"."id"
GROUP BY "first_name"
ORDER BY "visit_count" DESC;
