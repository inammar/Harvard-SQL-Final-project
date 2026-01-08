-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it
-- Represent patients who have cancer
CREATE TABLE "patients" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "age" INTEGER NOT NULL,
    "gender" TEXT NOT NULL
);

-- Represent doctors who have patients
CREATE TABLE "doctors" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "specialty" TEXT NOT NULL
);

-- Create table for diagnoses that patients have
CREATE TABLE "diagnoses" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "patient_id" INTEGER NOT NULL,
    "cancer_type" TEXT NOT NULL,
    "stage" TEXT CHECK(stage IN ('I', 'II', 'III', 'IV')),
    "diagnosis_date" DATE NOT NULL,
    FOREIGN KEY ("patient_id") REFERENCES "patients" ("id")
);

-- Represent treatments prescribed by a doctor
CREATE TABLE "treatments" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "diagnosis_id" INTEGER NOT NULL,
    "doctor_id" INTEGER NOT NULL,
    "treatment_type" TEXT NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
    FOREIGN KEY ("diagnosis_id") REFERENCES "diagnoses" ("id"),
    FOREIGN KEY ("doctor_id") REFERENCES "doctors" ("id")
);

-- Represent medications prescribed by a doctor
CREATE TABLE "medications" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "treatment_id" INTEGER NOT NULL,
    "drug_name" TEXT NOT NULL,
    "dosage" TEXT NOT NULL,
    FOREIGN KEY ("treatment_id") REFERENCES "treatments" ("id")
);

-- Represent visits of the patients
CREATE TABLE "visits" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "patient_id" INTEGER NOT NULL,
    "doctor_id" INTEGER NOT NULL,
    "visit_date" DATE NOT NULL,
    "reason" TEXT NOT NULL,
    FOREIGN KEY ("patient_id") REFERENCES "patients" ("id"),
    FOREIGN KEY ("doctor_id") REFERENCES "doctors" ("id")
);

-- Create indexes to speed common searches
CREATE INDEX "patient_name_search" ON "patients" ("first_name", "last_name");
CREATE INDEX "doctor_name_search" ON "doctors" ("first_name", "last_name");
CREATE INDEX "cancer_type_search" ON "diagnoses" ("cancer_type");
CREATE INDEX "drug_name_search" ON "medications" ("drug_name");
CREATE INDEX "visit_date_search" ON "visits" ("visit_date");

