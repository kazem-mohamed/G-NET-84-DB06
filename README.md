# Database Course — Assignment 06

T-SQL solutions for the 46 questions of Database Assignment 06, written against the
`Hospital` database.

## Running the queries

1. Restore `Hospital.bak` in SSMS (**Databases → Restore Database…**). This creates the `Hospital` database.
2. Run [`Hospital_Queries.sql`](Hospital_Queries.sql) from top to bottom.

Run the questions in order, because later ones use objects created earlier: Question 43 uses
`CalculateAnnualSalary` (Question 32), 44 uses `GetConsultantsByMinimumSalary` (35), 45 uses
`GetPatientsWithAge` (37), and 46 uses `CalculatePatientAge` (31).

## Questions by topic

| Questions | Topic |
|-----------|-------|
| 1 – 10  | Aggregate functions, `GROUP BY` and `HAVING` |
| 11 – 20 | Subqueries and derived tables |
| 21 – 30 | Creating tables with `SELECT INTO` |
| 31 – 33 | Scalar functions |
| 34 – 36 | Inline table-valued functions |
| 37 – 39 | Multi-statement table-valued functions |
| 40 – 46 | Combined questions |

## Queries that return no rows

With the data in `Hospital.bak`, these queries are correct but return an empty result:

- **10, 42** — no patient received medication more than 5 times (the most is exactly 5).
- **16** — every patient has received medication at least once.
- **26, 44** — the highest consultant salary is 24,631, below 50,000.
- **28** — the highest nurse salary is 9,000, below 30,000.

[`Solution-Screenshots.pdf`](Solution-Screenshots.pdf) contains the whole script as page images, as a backup.
