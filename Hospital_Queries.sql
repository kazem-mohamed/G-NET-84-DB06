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
