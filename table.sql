-- Assuming a table structure for 'Transactions' as follows:
-- CREATE TABLE Transactions (
--   Transaction_ID INT,
--   Date DATE,
--   Account_Type VARCHAR(50),
--   Amount DECIMAL(10, 2),
--   Compliance_Flag INT
-- );

-- 1. Add a Calculated_Compliance column (this step actually needs an update statement or a temporary table in SQL)
ALTER TABLE Transactions ADD Calculated_Compliance INT;

-- Update Calculated_Compliance based on the conditions specified
UPDATE Transactions
SET Calculated_Compliance = CASE 
    WHEN Amount >= 500 AND Account_Type = 'Checking' THEN 1
    ELSE 0
END;

-- 2. Identify mismatches between Compliance_Flag and Calculated_Compliance
SELECT Transaction_ID, Date, Account_Type, Amount, Compliance_Flag, Calculated_Compliance,
    CASE
        WHEN Compliance_Flag != Calculated_Compliance THEN 1
        ELSE 0
    END AS Compliance_Mismatch
FROM Transactions;

-- 3. Summarize the mismatches
SELECT Compliance_Mismatch, COUNT(*) AS Mismatch_Count
FROM (
    SELECT Compliance_Flag, Calculated_Compliance,
        CASE
            WHEN Compliance_Flag != Calculated_Compliance THEN 1
            ELSE 0
        END AS Compliance_Mismatch
    FROM Transactions
) AS MismatchSummary
GROUP BY Compliance_Mismatch;

-- 4. Aggregated data similar to the PivotTable in Excel
SELECT Account_Type, Compliance_Flag, AVG(Amount) AS Average_Amount, SUM(Amount) AS Total_Amount, COUNT(*) AS Transaction_Count
FROM Transactions
GROUP BY Account_Type, Compliance_Flag;
