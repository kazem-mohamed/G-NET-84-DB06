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
