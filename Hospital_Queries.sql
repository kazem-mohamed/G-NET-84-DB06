-- ============================================================
-- Database Assignment 06 - SQL Questions
-- Database: Hospital (restore it from Hospital.bak before running)
-- ============================================================

USE Hospital;
GO

-- ------------------------------------------------------------
-- Question 1 - Count Patients per Ward
-- Display the number of patients assigned to each ward.
-- ------------------------------------------------------------
SELECT WardId,
       COUNT(*) AS PatientCount
FROM Patients
WHERE WardId IS NOT NULL
GROUP BY WardId;
GO

-- ------------------------------------------------------------
-- Question 2 - Calculate the Average Consultant Salary
-- Display the average salary of all consultants.
-- ------------------------------------------------------------
SELECT AVG(Salary) AS AverageSalary
FROM Consultants;
GO

-- ------------------------------------------------------------
-- Question 3 - Display Salary Statistics for Consultants
-- Display the minimum, maximum, average, and total consultant salaries.
-- ------------------------------------------------------------
SELECT MIN(Salary) AS MinimumSalary,
       MAX(Salary) AS MaximumSalary,
       AVG(Salary) AS AverageSalary,
       SUM(Salary) AS TotalSalary
FROM Consultants;
GO

-- ------------------------------------------------------------
-- Question 4 - Count Patients by Ward
-- Display the ward ID and number of patients in each ward, sorted from highest to lowest.
-- ------------------------------------------------------------
SELECT WardId,
       COUNT(*) AS PatientCount
FROM Patients
WHERE WardId IS NOT NULL
GROUP BY WardId
ORDER BY PatientCount DESC;
GO

-- ------------------------------------------------------------
-- Question 5 - Medication Quantity per Patient
-- Display the total medication quantity administered to each patient.
-- ------------------------------------------------------------
SELECT PatientId,
       SUM(Quantity) AS TotalQuantity
FROM DrugAdministrations
GROUP BY PatientId;
GO

-- ------------------------------------------------------------
-- Question 6 - Medication Administrations per Patient
-- Display each patient ID together with the number of medication administrations they received.
-- ------------------------------------------------------------
SELECT PatientId,
       COUNT(*) AS AdministrationCount
FROM DrugAdministrations
GROUP BY PatientId;
GO

-- ------------------------------------------------------------
-- Question 7 - Patients per Ward with Ward Names
-- Display every ward together with the number of patients assigned to it, including wards with
-- no patients.
-- COUNT(p.Id) skips the NULL row the LEFT JOIN adds for an empty ward, so it counts 0, not 1.
-- ------------------------------------------------------------
SELECT w.Id        AS WardId,
       w.Name      AS WardName,
       COUNT(p.Id) AS PatientCount
FROM Wards AS w
LEFT JOIN Patients AS p ON p.WardId = w.Id
GROUP BY w.Id, w.Name;
GO

-- ------------------------------------------------------------
-- Question 8 - Average Nurse Salary per Ward
-- Display each ward together with the average salary of nurses serving in that ward.
-- ------------------------------------------------------------
SELECT w.Id          AS WardId,
       w.Name        AS WardName,
       AVG(n.Salary) AS AverageNurseSalary
FROM Wards AS w
INNER JOIN Nurses AS n ON n.ServesInWardId = w.Id
GROUP BY w.Id, w.Name;
GO

-- ------------------------------------------------------------
-- Question 9 - Wards with More Than 3 Patients
-- Display wards that have more than 3 patients.
-- ------------------------------------------------------------
SELECT w.Id        AS WardId,
       w.Name      AS WardName,
       COUNT(p.Id) AS PatientCount
FROM Wards AS w
INNER JOIN Patients AS p ON p.WardId = w.Id
GROUP BY w.Id, w.Name
HAVING COUNT(p.Id) > 3;
GO

-- ------------------------------------------------------------
-- Question 10 - Patients with More Than 5 Medication Administrations
-- Display patients who received medication more than 5 times.
-- ------------------------------------------------------------
SELECT p.Id     AS PatientId,
       p.Name   AS PatientName,
       COUNT(*) AS AdministrationCount
FROM Patients AS p
INNER JOIN DrugAdministrations AS da ON da.PatientId = p.Id
GROUP BY p.Id, p.Name
HAVING COUNT(*) > 5;
GO

-- ------------------------------------------------------------
-- Question 11 - Consultants Above Average Salary
-- Display consultants whose salary is greater than the average consultant salary.
-- ------------------------------------------------------------
SELECT Id,
       Name,
       Salary
FROM Consultants
WHERE Salary > (SELECT AVG(Salary) FROM Consultants);
GO

-- ------------------------------------------------------------
-- Question 12 - Nurses Above Average Salary
-- Display nurses whose salary is greater than the average nurse salary.
-- ------------------------------------------------------------
SELECT Number,
       Name,
       Salary
FROM Nurses
WHERE Salary > (SELECT AVG(Salary) FROM Nurses);
GO

-- ------------------------------------------------------------
-- Question 13 - Patients in the Largest Ward
-- Display patients who belong to the ward containing the largest number of patients.
-- WITH TIES keeps every ward that shares the largest count, if there is a tie.
-- ------------------------------------------------------------
SELECT Id,
       Name,
       DOB,
       WardId
FROM Patients
WHERE WardId IN (
    SELECT TOP 1 WITH TIES WardId
    FROM Patients
    WHERE WardId IS NOT NULL
    GROUP BY WardId
    ORDER BY COUNT(*) DESC
);
GO

-- ------------------------------------------------------------
-- Question 14 - Consultants with the Maximum Salary
-- Display the consultant or consultants who have the highest salary.
-- ------------------------------------------------------------
SELECT Id,
       Name,
       Salary
FROM Consultants
WHERE Salary = (SELECT MAX(Salary) FROM Consultants);
GO

-- ------------------------------------------------------------
-- Question 15 - Patients Who Received Medication
-- Display patients who have at least one medication administration.
-- ------------------------------------------------------------
SELECT p.Id,
       p.Name
FROM Patients AS p
WHERE EXISTS (SELECT 1 FROM DrugAdministrations AS da WHERE da.PatientId = p.Id);
GO

-- ------------------------------------------------------------
-- Question 16 - Patients Who Never Received Medication
-- Display patients who have never received any medication.
-- ------------------------------------------------------------
SELECT p.Id,
       p.Name
FROM Patients AS p
WHERE NOT EXISTS (SELECT 1 FROM DrugAdministrations AS da WHERE da.PatientId = p.Id);
GO

-- ------------------------------------------------------------
-- Question 17 - Count Medication Administrations per Patient
-- Display every patient together with the number of medication administrations they received.
-- ------------------------------------------------------------
SELECT p.Id                AS PatientId,
       p.Name              AS PatientName,
       COUNT(da.PatientId) AS AdministrationCount
FROM Patients AS p
LEFT JOIN DrugAdministrations AS da ON da.PatientId = p.Id
GROUP BY p.Id, p.Name;
GO

-- ------------------------------------------------------------
-- Question 18 - Total Medication Quantity per Patient
-- Display every patient together with the total medication quantity administered to them.
-- ------------------------------------------------------------
SELECT p.Id                          AS PatientId,
       p.Name                        AS PatientName,
       COALESCE(SUM(da.Quantity), 0) AS TotalQuantity
FROM Patients AS p
LEFT JOIN DrugAdministrations AS da ON da.PatientId = p.Id
GROUP BY p.Id, p.Name;
GO

-- ------------------------------------------------------------
-- Question 19 - Derived Table for Consultant Salaries
-- Create a derived table containing the average consultant salary, then display consultants
-- whose salary is above that average.
-- ------------------------------------------------------------
SELECT c.Id,
       c.Name,
       c.Salary,
       a.AverageSalary
FROM Consultants AS c
CROSS JOIN (SELECT AVG(Salary) AS AverageSalary FROM Consultants) AS a
WHERE c.Salary > a.AverageSalary;
GO

-- ------------------------------------------------------------
-- Question 20 - Patients with Above-Average Medication Quantity
-- Display patients whose total medication quantity is greater than the average total medication
-- quantity across patients who received medication.
-- AVG over INT values returns an INT in SQL Server, so the totals are cast to keep the decimals.
-- ------------------------------------------------------------
WITH PatientTotals AS (
    SELECT PatientId,
           SUM(Quantity) AS TotalQuantity
    FROM DrugAdministrations
    GROUP BY PatientId
)
SELECT p.Id   AS PatientId,
       p.Name AS PatientName,
       pt.TotalQuantity
FROM PatientTotals AS pt
INNER JOIN Patients AS p ON p.Id = pt.PatientId
WHERE pt.TotalQuantity > (SELECT AVG(CAST(TotalQuantity AS DECIMAL(10, 2))) FROM PatientTotals);
GO

-- ------------------------------------------------------------
-- Question 21 - Create a Patient Backup
-- Create a new table containing all patients.
-- ------------------------------------------------------------
DROP TABLE IF EXISTS PatientsBackup;

SELECT *
INTO PatientsBackup
FROM Patients;
GO

-- ------------------------------------------------------------
-- Question 22 - Create a Basic Patient Information Table
-- Create a new table containing only patient ID, name, and date of birth.
-- ------------------------------------------------------------
DROP TABLE IF EXISTS PatientBasicInfo;

SELECT Id,
       Name,
       DOB
INTO PatientBasicInfo
FROM Patients;
GO

-- ------------------------------------------------------------
-- Question 23 - Create a Consultant Salary Report
-- Create a new table containing consultant ID, name, and salary.
-- ------------------------------------------------------------
DROP TABLE IF EXISTS ConsultantSalaryReport;

SELECT Id,
       Name,
       Salary
INTO ConsultantSalaryReport
FROM Consultants;
GO
