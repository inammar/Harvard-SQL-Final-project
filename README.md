## Harvard-SQL-Final-project

<img width="616" height="462" alt="image" src="https://github.com/user-attachments/assets/ce676ffd-a105-48ca-951e-3040d7cf59e5" />

<img width="680" height="408" alt="image" src="https://github.com/user-attachments/assets/974c09c1-7857-449a-bc5b-58b80eb06642" />

<img width="607" height="179" alt="image" src="https://github.com/user-attachments/assets/8c0c2614-0eb8-4540-a444-a6fe9f4a7cc6" />

<img width="600" height="152" alt="image" src="https://github.com/user-attachments/assets/86eaeb32-9967-44ca-95aa-81bcd89501a0" />

<img width="615" height="394" alt="image" src="https://github.com/user-attachments/assets/8b86e6ed-7f5c-4b8a-9591-16e69a0a28cc" />


https://youtu.be/H89cfMeAd54


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

#### Relationships

The entity relationship diagram describes the relationships among the entities in the database.

As detailed by the diagram:

* Doctors-Visits relationships: A doctor can have many visits (one to many). Each visit is associated with one doctor.
* Patients-Visits relationships: A patient can have many visits. Each visit belongs to one patient.
* Patients–Diagnoses relationships: One patient can have multiple diagnoses. Each diagnosis belongs to exactly one patient.
* Patients–Treatments relationships: One patient can have multiple treatments. Each treatment belongs to one patient.
* Treatments–Medications relationships: Each treatment can include multiple medications. Each medication is associated with one treatment.
* Diagnosis-Treatments relationships: One diagnosis can lead to one or multiple treatments. Each treatment belongs to one diagnosis.

#### Optimizations

Based on typical usage patterns and expected queries within the database, the following indexes have been implemented to optimize performance:

Patient and Doctor Identification:

It is a common requirement for users of the system to quickly identify specific `patients` or `doctors` by their full names. To facilitate rapid searches across both the `patients` and `doctors` tables, composite indexes have been created on the `first_name` and `last_name` columns: `patient_name_search` and `doctor_name_search`.

Diagnosis Filtering:

Users frequently need to filter and analyze patient data based on specific cancer types. To speed up the identification of diagnoses matching a particular condition, the `cancer_type_search` index has been applied to the `cancer_type` column in the `diagnoses` table.

Medication Tracking:

Efficiently searching for all instances where a specific drug has been prescribed is crucial. To accelerate queries related to medication management, the `drug_name_search` index has been created on the `drug_name column` in the `medications` table.

Visit Timeline Analysis:

Analyzing visit history or scheduling requires rapid retrieval of records by date. The `visit_date_search` index on the `visit_date` column in the `visits` table ensures quick access to visit records within specified timeframes.

#### Limitations

The current schema only stores the present information for patients and doctors, preventing any historical tracking of age changes or past specialties. It uses a very rigid, one-to-one link between treatments, medications, and diagnoses, which complicates the tracking of complex care plans. Furthermore, every visit and treatment requires a single assigned doctor, preventing the recording or querying of collaborative and team-based medical care. The database does not accommodate interactions with non-physician staff like nurses, therapists or other additional treatment, limiting comprehensive visit logging. Also, the general visit reason field potentially duplicates specific diagnosis information, risking inconsistent records within the database.







