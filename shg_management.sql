USE shg_management;

CREATE TABLE SHGs (
    SHG_ID INT PRIMARY KEY AUTO_INCREMENT,
    SHG_Name VARCHAR(100) NOT NULL UNIQUE,
    Location VARCHAR(100) NOT NULL,
    Total_Savings DECIMAL(12,2) DEFAULT 0
);

CREATE TABLE Members (
    Member_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Age INT CHECK (Age >= 18),
    Gender ENUM('Male', 'Female', 'Other') NOT NULL,
    Contact VARCHAR(15) UNIQUE NOT NULL,
    SHG_ID INT,
    Savings_Amount DECIMAL(10,2) DEFAULT 0,
    FOREIGN KEY (SHG_ID) REFERENCES SHGs(SHG_ID) ON DELETE SET NULL
);

ALTER TABLE SHGs ADD COLUMN Leader_ID INT;
ALTER TABLE SHGs ADD CONSTRAINT FK_Leader FOREIGN KEY (Leader_ID) REFERENCES Members(Member_ID) ON DELETE SET NULL;


-- Step 4: Create the Loans table
CREATE TABLE Loans (
    Loan_ID INT PRIMARY KEY AUTO_INCREMENT,
    Member_ID INT NOT NULL,
    SHG_ID INT NOT NULL,
    Loan_Amount DECIMAL(12,2) NOT NULL,
    Issue_Date DATE NOT NULL,
    Repayment_Schedule ENUM('Monthly', 'Bi-Monthly', 'Quarterly') NOT NULL,
    Outstanding_Amount DECIMAL(12,2) DEFAULT 0,
    FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID) ON DELETE CASCADE,
    FOREIGN KEY (SHG_ID) REFERENCES SHGs(SHG_ID) ON DELETE CASCADE
);

-- Step 5: Create the Contributions table
CREATE TABLE Contributions (
    Contribution_ID INT PRIMARY KEY AUTO_INCREMENT,
    Member_ID INT NOT NULL,
    SHG_ID INT NOT NULL,
    Contribution_Date DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL CHECK (Amount > 0),
    FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID) ON DELETE CASCADE,
    FOREIGN KEY (SHG_ID) REFERENCES SHGs(SHG_ID) ON DELETE CASCADE
);

-- Step 6: Create the Meetings table
CREATE TABLE Meetings (
    Meeting_ID INT PRIMARY KEY AUTO_INCREMENT,
    SHG_ID INT NOT NULL,
    Date DATE NOT NULL,
    Attendance INT NOT NULL CHECK (Attendance >= 0),
    Minutes TEXT,
    FOREIGN KEY (SHG_ID) REFERENCES SHGs(SHG_ID) ON DELETE CASCADE
);

-- Step 7: Create the Government_Schemes table
CREATE TABLE Government_Schemes (
    Scheme_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Description TEXT NOT NULL,
    Eligibility TEXT NOT NULL,
    Application_Status ENUM('Open', 'Closed') NOT NULL DEFAULT 'Open'
);

INSERT INTO SHGs (SHG_ID, SHG_Name, Location, Total_Savings, Leader_ID) VALUES
(101, 'Women Warriors', 'Delhi', 50000, NULL),
(102, 'Rising Stars', 'Mumbai', 65000, NULL),
(103, 'Udaan Group', 'Kolkata', 55000, NULL),
(104, 'Growth Makers', 'Bangalore', 70000, NULL),
(105, 'Future Builders', 'Hyderabad', 60000, NULL);

INSERT INTO Members (Member_ID, Name, Age, Gender, Contact, SHG_ID, Savings_Amount) VALUES
(1, 'Aisha Khan', 30, 'Female', '9876543210', 101, 5000),
(2, 'Rajesh Verma', 35, 'Male', '9876543211', 102, 7000),
(3, 'Sunita Devi', 28, 'Female', '9876543212', 103, 6000),
(4, 'Manoj Patel', 40, 'Male', '9876543213', 104, 8000),
(5, 'Priya Singh', 26, 'Female', '9876543214', 105, 5500);

UPDATE SHGs SET Leader_ID = 1 WHERE SHG_ID = 101;
UPDATE SHGs SET Leader_ID = 2 WHERE SHG_ID = 102;
UPDATE SHGs SET Leader_ID = 3 WHERE SHG_ID = 103;
UPDATE SHGs SET Leader_ID = 4 WHERE SHG_ID = 104;
UPDATE SHGs SET Leader_ID = 5 WHERE SHG_ID = 105;

INSERT INTO Members (Member_ID, Name, Age, Gender, Contact, SHG_ID, Savings_Amount) VALUES
(6, 'Anil Kumar', 38, 'Male', 9876543215, 101, 9000),
(7, 'Kavita Yadav', 32, 'Female', 9876543216, 102, 7500),
(8, 'Ramesh Gupta', 45, 'Male', 9876543217, 103, 6500),
(9, 'Neha Sharma', 29, 'Female', 9876543218, 104, 7000),
(10, 'Vijay Joshi', 33, 'Male', 9876543219, 105, 5000);

INSERT INTO Loans (Loan_ID, Member_ID, SHG_ID, Loan_Amount, Issue_Date, Repayment_Schedule, Outstanding_Amount) VALUES
(1, 1, 101, 20000, '2024-01-15', 'Monthly', 15000),
(2, 2, 102, 15000, '2024-02-10', 'Quarterly', 10000),
(3, 3, 103, 18000, '2024-03-05', 'Monthly', 12000),
(4, 4, 104, 25000, '2024-01-25', 'Monthly', 20000),
(5, 5, 105, 30000, '2024-02-20', 'Bi-Monthly', 22000),
(6, 6, 101, 22000, '2024-03-10', 'Monthly', 18000),
(7, 7, 102, 27000, '2024-01-30', 'Quarterly', 20000),
(8, 8, 103, 19000, '2024-02-15', 'Monthly', 14000),
(9, 9, 104, 16000, '2024-03-05', 'Bi-Monthly', 11000),
(10, 10, 105, 21000, '2024-02-25', 'Monthly', 15000);

UPDATE Loans SET Outstanding_Amount = 0 WHERE Loan_ID = 1;
UPDATE Loans SET Outstanding_Amount = 0 WHERE Loan_ID = 2;
UPDATE Loans SET Outstanding_Amount = 0 WHERE Loan_ID = 5;
UPDATE Loans SET Outstanding_Amount = 0 WHERE Loan_ID = 7;


INSERT INTO Contributions (Contribution_ID, Member_ID, SHG_ID, Contribution_Date, Amount) VALUES
(1, 1, 101, '2024-01-10', 1000),
(2, 2, 102, '2024-02-15', 1500),
(3, 3, 103, '2024-03-20', 1200),
(4, 4, 104, '2024-01-25', 2000),
(5, 5, 105, '2024-02-05', 2500),
(6, 6, 101, '2024-03-10', 1800),
(7, 7, 102, '2024-01-15', 1700),
(8, 8, 103, '2024-02-20', 1300),
(9, 9, 104, '2024-03-05', 1400),
(10, 10, 105, '2024-02-25', 1600);

INSERT INTO Meetings (Meeting_ID, SHG_ID, Date, Attendance, Minutes) VALUES
(1, 101, '2024-01-12', 15, 'Discussed savings plans'),
(2, 102, '2024-02-18', 12, 'Loan repayment discussion'),
(3, 103, '2024-03-22', 10, 'New member enrollment'),
(4, 104, '2024-01-28', 20, 'Business expansion ideas'),
(5, 105, '2024-02-08', 14, 'Financial literacy workshop'),
(6, 101, '2024-03-14', 17, 'Social welfare projects'),
(7, 102, '2024-01-22', 18, 'Future investment plans'),
(8, 103, '2024-02-26', 11, 'Skill development training'),
(9, 104, '2024-03-10', 19, 'Marketing strategies'),
(10, 105, '2024-02-20', 13, 'Government scheme awareness');

INSERT INTO government_schemes (Scheme_ID, Name, Description, Eligibility, Application_Status) VALUES
(1, 'SHG Bank Linkage', 'Low-interest loans for SHGs', 'SHG members with savings', 'Open'),
(2, 'Rural Women Empowerment', 'Training programs for women', 'Women in rural areas', 'Open'),
(3, 'Livelihood Mission', 'Financial aid for small businesses', 'SHGs in villages', 'Closed'),
(4, 'Education Support', 'Scholarships for SHG members\' kids', 'SHG families', 'Open'),
(5, 'Microfinance Support', 'Loan repayment assistance', 'Active SHGs', 'Open');

ALTER TABLE SHGs ADD COLUMN Registration_Date DATE;
UPDATE SHGs 
SET Registration_Date = '2024-01-10' WHERE SHG_ID = 101;

UPDATE SHGs 
SET Registration_Date = '2024-02-15' WHERE SHG_ID = 102;

UPDATE SHGs 
SET Registration_Date = '2024-03-05' WHERE SHG_ID = 103;

UPDATE SHGs 
SET Registration_Date = '2024-01-20' WHERE SHG_ID = 104;

UPDATE SHGs 
SET Registration_Date = '2024-02-25' WHERE SHG_ID = 105;


select * from contributions;
SELECT * FROM government_schemes;
SELECT * FROM loans;
select * from meetings;
select * from members;
select * from shgs;

-- Retrieve details of all SHG registered in the system
SELECT * FROM SHGs;

-- retrieve the name, location and reg_date of all SHG
SELECT SHG_Name, Location, Registration_Date FROM SHGs;

-- Find the detail of all memebers in a specific SHG 
SELECT * FROM Members WHERE SHG_ID = 101;
SELECT * FROM Members WHERE SHG_ID = 102;
SELECT * FROM Members WHERE SHG_ID = 103;
SELECT * FROM Members WHERE SHG_ID = 104;
SELECT * FROM Members WHERE SHG_ID = 105;

-- retrieve details of all loans issued to shg members
SELECT 
    Loans.Loan_ID, 
    Members.Name AS Member_Name, 
    SHGs.SHG_Name, 
    Loans.Loan_Amount, 
    Loans.Issue_Date, 
    Loans.Repayment_Schedule, 
    Loans.Outstanding_Amount
FROM Loans
JOIN Members ON Loans.Member_ID = Members.Member_ID
JOIN SHGs ON Loans.SHG_ID = SHGs.SHG_ID;

-- find the shg with the highest number of active members
SELECT SHGs.SHG_ID, SHGs.SHG_Name, SHGs.Location, COUNT(Members.Member_ID) AS Total_Members
FROM SHGs
JOIN Members ON SHGs.SHG_ID = Members.SHG_ID
GROUP BY SHGs.SHG_ID, SHGs.SHG_Name, SHGs.Location
ORDER BY Total_Members DESC
LIMIT 1;

-- retrieve a list of shg that has recieved government schemes
ALTER TABLE SHGs ADD COLUMN Scheme_ID INT;
ALTER TABLE SHGs ADD CONSTRAINT FK_SHG_Scheme FOREIGN KEY (Scheme_ID) REFERENCES Government_Schemes(Scheme_ID) ON DELETE SET NULL;

UPDATE SHGs SET Scheme_ID = 1 WHERE SHG_ID = 101;
UPDATE SHGs SET Scheme_ID = 2 WHERE SHG_ID = 102;
UPDATE SHGs SET Scheme_ID = 3 WHERE SHG_ID = 103;
UPDATE SHGs SET Scheme_ID = 4 WHERE SHG_ID = 104;
UPDATE SHGs SET Scheme_ID = 5 WHERE SHG_ID = 105;

SELECT SHGs.SHG_ID, SHGs.SHG_Name, SHGs.Location, Government_Schemes.Name AS Scheme_Name
FROM SHGs
JOIN Government_Schemes ON SHGs.Scheme_ID = Government_Schemes.Scheme_ID;

-- retrieve the list of members who have not attended any shg meetings in the last 6 months
SELECT DISTINCT Members.Member_ID, Members.Name, Members.SHG_ID, SHGs.SHG_Name
FROM Members
JOIN SHGs ON Members.SHG_ID = SHGs.SHG_ID
WHERE Members.Member_ID NOT IN (
    SELECT DISTINCT Members.Member_ID 
    FROM Members
    JOIN SHGs ON Members.SHG_ID = SHGs.SHG_ID
    JOIN Meetings ON SHGs.SHG_ID = Meetings.SHG_ID
    WHERE Meetings.Date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
);

-- find member who have taken loan but have not made any repayment
ALTER TABLE Contributions 
ADD COLUMN Type ENUM('Savings', 'Loan Repayment') DEFAULT 'Savings';

UPDATE Contributions 
SET Type = 'Loan Repayment' 
WHERE Member_ID IN (1, 2, 3) 
AND Contribution_Date IN ('2024-04-01', '2024-04-05', '2024-04-10');

SELECT DISTINCT Members.Member_ID, Members.Name, Members.SHG_ID, SHGs.SHG_Name, 
       Loans.Loan_ID, Loans.Loan_Amount, Loans.Outstanding_Amount
FROM Members
JOIN Loans ON Members.Member_ID = Loans.Member_ID
JOIN SHGs ON Members.SHG_ID = SHGs.SHG_ID
WHERE Loans.Outstanding_Amount > 0
AND Members.Member_ID NOT IN (
    SELECT DISTINCT Member_ID FROM Contributions 
    WHERE Type = 'Loan Repayment'
);

-- find member who have participated in more than three government schemes
CREATE TABLE Member_Scheme_Participation (
    Participation_ID INT PRIMARY KEY AUTO_INCREMENT,
    Member_ID INT,
    Scheme_ID INT,
    Participation_Date DATE,
    FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID) ON DELETE CASCADE,
    FOREIGN KEY (Scheme_ID) REFERENCES Government_Schemes(Scheme_ID) ON DELETE CASCADE
);
INSERT INTO Member_Scheme_Participation (Member_ID, Scheme_ID, Participation_Date) 
VALUES 
(1, 1, '2024-01-15'),
(1, 2, '2024-02-10'),
(1, 3, '2024-03-05'),
(1, 4, '2024-04-01'),
(2, 1, '2024-01-20'),
(2, 3, '2024-02-15'),
(3, 2, '2024-03-10'),
(3, 3, '2024-03-20'),
(3, 4, '2024-03-30'),
(3, 5, '2024-04-05');
SELECT m.Member_ID, m.Name, COUNT(mp.Scheme_ID) AS Scheme_Count
FROM Members m
JOIN Member_Scheme_Participation mp ON m.Member_ID = mp.Member_ID
GROUP BY m.Member_ID
HAVING COUNT(mp.Scheme_ID) > 3;

-- find the total number of women lead shg that have successfully repaid loans
SELECT s.SHG_ID, s.SHG_Name
FROM SHGs s
JOIN Members m ON s.Leader_ID = m.Member_ID
WHERE m.Gender = 'Female';
SELECT DISTINCT SHG_ID
FROM Loans
WHERE Outstanding_Amount = 0;

SELECT COUNT(DISTINCT s.SHG_ID) AS Women_Led_Successful_SHGs
FROM SHGs s
JOIN Members m ON s.Leader_ID = m.Member_ID
JOIN Loans l ON s.SHG_ID = l.SHG_ID
WHERE m.Gender = 'Female' AND l.Outstanding_Amount = 0;

SELECT DISTINCT SHG_ID
FROM Loans
WHERE Outstanding_Amount = 0;

SELECT SHG_ID, SHG_Name, Location, Total_Savings, Leader_ID
FROM SHGs
WHERE SHG_ID IN (
    SELECT DISTINCT SHG_ID
    FROM Loans
    WHERE Outstanding_Amount = 0
);

-- retrieve details of shgs that have distributed micro loans among their members
SELECT SHG_ID, SHG_Name, Location, Total_Savings, Leader_ID
FROM SHGs
WHERE SHG_ID IN (
    SELECT DISTINCT SHG_ID FROM Loans
);

-- retrive the average loan amount issued per shg in the last two years
SELECT 
    SHG_ID, 
    AVG(Loan_Amount) AS Avg_Loan_Amount
FROM Loans
WHERE Issue_Date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
GROUP BY SHG_ID;

-- retrieve the contact details of all shg leaders
SELECT 
    m.Member_ID, 
    m.Name AS Leader_Name, 
    m.Contact, 
    s.SHG_ID, 
    s.SHG_Name 
FROM SHGs s
JOIN Members m ON s.Leader_ID = m.Member_ID;

-- retrieve first name, and last name member id and gender of all members who apply in government scheme
CREATE TABLE Government_Scheme_Applications (
    Application_ID INT PRIMARY KEY AUTO_INCREMENT,
    Member_ID INT NOT NULL,
    Scheme_ID INT NOT NULL,
    Application_Date DATE NOT NULL, -- Removed DEFAULT CURRENT_DATE
    Status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID) ON DELETE CASCADE,
    FOREIGN KEY (Scheme_ID) REFERENCES Government_Schemes(Scheme_ID) ON DELETE CASCADE
);
INSERT INTO Government_Scheme_Applications (Member_ID, Scheme_ID, Application_Date, Status) VALUES
(1, 1, '2024-02-01', 'Approved'),
(2, 3, '2024-03-15', 'Pending'),
(3, 2, '2024-04-05', 'Approved'),
(4, 4, '2024-01-25', 'Rejected'),
(5, 5, '2024-03-10', 'Approved'),
(6, 1, '2024-03-20', 'Approved'),
(7, 2, '2024-02-28', 'Pending'),
(8, 3, '2024-01-18', 'Rejected'),
(9, 4, '2024-04-01', 'Approved'),
(10, 5, '2024-02-15', 'Approved');
SELECT 
    SUBSTRING_INDEX(m.Name, ' ', 1) AS First_Name, 
    SUBSTRING_INDEX(m.Name, ' ', -1) AS Last_Name, 
    m.Member_ID, 
    m.Gender
FROM Members m
JOIN Government_Scheme_Applications gsa ON m.Member_ID = gsa.Member_ID;

-- retrieve a list of shgs  which are working on order by government scheme and within each government scheme ordered in descending order according to the last name
ALTER TABLE SHGs ADD FOREIGN KEY (Scheme_ID) REFERENCES Government_Schemes(Scheme_ID) ON DELETE SET NULL;
UPDATE SHGs SET Scheme_ID = 1 WHERE SHG_ID IN (101, 103); 
UPDATE SHGs SET Scheme_ID = 2 WHERE SHG_ID IN (102, 105);
UPDATE SHGs SET Scheme_ID = 3 WHERE SHG_ID = 104;

DESC Government_Schemes;


SELECT 
    s.SHG_ID, 
    s.SHG_Name, 
    g.Name, 
    l.Name AS Leader_Name
FROM SHGs s
JOIN Government_Schemes g ON s.Scheme_ID = g.Scheme_ID
JOIN Members l ON s.Leader_ID = l.Member_ID
ORDER BY g.Name ASC, 
         SUBSTRING_INDEX(l.Name, ' ', -1) DESC;
         
-- find the total savings collected by all shgs in the last year
ALTER TABLE Contributions ADD COLUMN Contribution_Type ENUM('Savings', 'Repayment') NOT NULL DEFAULT 'Savings';
SET SQL_SAFE_UPDATES = 0;
UPDATE Contributions SET Contribution_Type = 'Savings';
SET SQL_SAFE_UPDATES = 1;  -- Re-enable safe update mode
SELECT SUM(Amount) AS Total_Savings_Last_Year
FROM Contributions
WHERE Contribution_Type = 'Savings'
AND YEAR(Contribution_Date) = YEAR(CURDATE()) - 1;

SELECT SUM(Amount) AS Total_Savings_Last_Year
FROM Contributions
WHERE Contribution_Type = 'Savings'
AND YEAR(Contribution_Date) = YEAR(CURDATE()) - 1;

SELECT * FROM contributions;
SELECT * FROM government_schemes;
SELECT * FROM loans;
SELECT * FROM meetings;
SELECT * FROM MEMBERS;
SELECT * FROM shgs;

-- 1. GROUP BY and ORDER BY Clause
-- Count of members in each SHG (ordered by most members):
SELECT SHGs.SHG_Name, COUNT(Members.Member_ID) AS Total_Members
FROM SHGs
JOIN Members ON SHGs.SHG_ID = Members.SHG_ID
GROUP BY SHGs.SHG_ID
ORDER BY Total_Members DESC;

-- Total contributions per SHG (ordered by amount):
SELECT SHGs.SHG_Name, SUM(Contributions.Amount) AS Total_Contribution
FROM SHGs
JOIN Contributions ON SHGs.SHG_ID = Contributions.SHG_ID
GROUP BY SHGs.SHG_ID
ORDER BY Total_Contribution DESC;

-- 2. DELETE with and without WHERE Clause
-- Delete contributions made by a specific member (e.g., Member_ID = 10):
DELETE FROM Contributions
WHERE Member_ID = 10;

INSERT INTO Contributions (Contribution_ID, Member_ID, SHG_ID, Contribution_Date, Amount) VALUES
 (10, 10, 105, '2024-02-25', 1600);

DELETE FROM Meetings;
-- ALTER Table (Add/Drop Columns, Add Constraints)
-- Add a new column Remarks to Loans:
ALTER TABLE Loans
ADD COLUMN Remarks VARCHAR(255);

-- Drop the Remarks column from Loans:
ALTER TABLE Loans
DROP COLUMN Remarks;

-- Add a constraint to ensure Savings_Amount in Members is non-negative:
ALTER TABLE Members
ADD CONSTRAINT chk_savings CHECK (Savings_Amount >= 0);

--  Aggregate Functions (MAX, MIN, AVG, COUNT)
-- Find the maximum loan amount issued:
SELECT MAX(Loan_Amount) AS Max_Loan FROM Loans;

-- Find the minimum savings by any member:
SELECT MIN(Savings_Amount) AS Min_Savings FROM Members;

-- Average savings per member:
SELECT AVG(Savings_Amount) AS Avg_Savings FROM Members;

-- Total number of SHGs:
SELECT COUNT(*) AS Total_SHGs FROM SHGs;

-- Total number of members:
SELECT COUNT(*) AS Total_Members FROM Members;


























