## Harvard-SQL-Final-project

### Design Document

#### Scope

The database for CS50 SQL includes all entities necessary to facilitate the process of tracking cancer patients and their treatment. As such, included in the database's scope is:

* Patients, including basic identifying information,
* Doctors, including basic identifying information,
* Patient diagnosis, which includes cancer type, stage and date, when the cancer was diagnosed,
* Treatments, which include basic information about treatment,
* Medications, which include information about prescribed medications,
* Visits, including information about patients visits to the doctor.

Out of scope are elements like current patient condition and side effects of the medications.

#### Functional Requirements

This database will support:

* CRUD operations for patients and doctors;
* Tracking all visits of the patients and their diagnosis;
* Adding treatments and medications necessary to the patient.

Note that in this iteration, the system will not support patient condition and side effects of the medications.

#### Representation

Entities are captured in SQLite tables with the following schema.

#### Entities

The database includes the following entities:

##### Patients

The `patients` table includes:


* `id`, which specifies the unique ID for the patient as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `first_name`, which specifies the patient's first name as `TEXT`, given `TEXT` is appropriate for name fields.
* `last_name`, which specifies the patient's last name. `TEXT` is used for the same reason as `first_name`.
* `age`, which specifies the patient's age as an `INTEGER`.
* `gender`, which specifies the patient's gender as `TEXT`.

All columns are required and hence have the `NOT NULL` constraint applied where a `PRIMARY KEY` constraint is not.

##### Doctors

The `doctors` table includes:

* `id`, which specifies the unique ID for the instructor as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `first_name`, which specifies the instructor's first name as `TEXT`.
* `last_name`, which specifies the instructor's last name as `TEXT`.
* `specialty`, which specifies the doctor's specialty as `TEXT`.

All columns (except`id`) in the `doctors` table are required and hence should have the `NOT NULL` constraint applied. No other constraints are necessary.

##### Diagnoses

The `diagnoses` table includes:

* `id`, which specifies the unique ID for the instructor as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `patient_id`, which is the ID of the patient who has diagnosis as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `patients` table to ensure data integrity.
* `cancer_type`, which is the type of the cancer set as `TEXT`.
* `stage`, which is the stage of the cancer set as `TEXT`.
* `diagnosis_date`, which is the date when the cancer was diagnosed and set as `DATE`.

All columns are required and hence have the `NOT NULL` constraint applied where a `PRIMARY KEY` constraint is not.

##### Treatments

The `treatments` table includes:

* `id`, which specifies the unique ID for the treatment as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `diagnoses_id`, which is the ID of the patient as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `patients table` to ensure data integrity.
* `doctor_id`, which is the ID of the doctor as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied.
* `treatment_type`, which is the type of the treatment set as `TEXT`.
* `start_date`, which is the start date of the treatment set as `DATE`,
* `end_date`, which is the end date of the treatment set as `DATE`.

All columns are required and hence have the `NOT NULL` constraint applied where a `PRIMARY KEY` constraint is not.

##### Medications

The `medications` table includes:

* `id`, which specifies the unique ID for the medication as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `treatment_id`, which specifies the ID of the treatment as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the `treatments` table, which ensures that each medication can be referenced back to the treatment.
* `drug_name`, which is the drug name set as `TEXT`.
* `dosage`, which contains the dosage as `TEXT`.

All columns are required and hence have the `NOT NULL` constraint applied where a `PRIMARY KEY` or `FOREIGN KEY` constraint is not.

##### Visits

The visits table includes:

* `id`, which specifies the unique ID for the visit as an `INTEGER`. This column thus has the `PRIMARY KEY` constraint applied.
* `patient_id`, which is the ID of the patient as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied referencing the `id` column in the `patients` table to ensure data integrity.
* `doctor_id`, which is the ID of the doctor as an `INTEGER`. This column thus has the `FOREIGN KEY` constraint applied, referencing the `id` column in the doctors table to ensure data integrity.
* `visit_date`, which specifies the visit’s date as `DATE`.
* `reason`, which specifies the reason of the visit as `TEXT`.

All columns are required and hence have the `NOT NULL` constraint applied where a `PRIMARY KEY` or `FOREIGN KEY` constraint is not.




