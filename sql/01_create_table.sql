CREATE TABLE revenue( 
    id VARCHAR(50) PRIMARY KEY,
    date DATE, 
    revenue_type VARCHAR(50),
    sending_account VARCHAR(150),
    transaction_id VARCHAR(50),
    description VARCHAR(300),
    amount DECIMAL(10, 2)
);
CREATE TABLE expenses( 
   id VARCHAR(50) PRIMARY KEY,
   date DATE,
   expense_type1 VARCHAR(50),
   expense_type VARCHAR(50),
   receiving_account VARCHAR(150),
   transaction_id VARCHAR(50),
   description VARCHAR(300),
   amount DECIMAL(10, 2)
);

SELECT * FROM revenue;
SELECT * FROM expenses;

CREATE TABLE attendance(
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    attendance_date DATE,
    status VARCHAR(20)
);

ALTER TABLE attendance 
RENAME COLUMN id TO student_id;

SELECT constraint_name FROM information_schema.table_constraints
WHERE table_name = 'attendance'
AND constraint_type = 'PRIMARY KEY';

ALTER TABLE attendance
DROP CONSTRAINT attendance_pkey;

ALTER TABLE attendance
ADD COLUMN id INT PRIMARY KEY;

SELECT * FROM attendance;

DROP TABLE attendance;
SELECT * FROM attendance;

CREATE TABLE attendance(
    attendance_id INT PRIMARY KEY,
    student_id VARCHAR(50),
    attendance_date DATE,
    status VARCHAR(20)
);

DROP TABLE revenue;
DROP TABLE expenses;

CREATE TABLE revenue( 
    id VARCHAR(50) PRIMARY KEY,
    date DATE, 
    revenue_type VARCHAR(50),
    amount DECIMAL(10, 2)
);

CREATE TABLE expenses( 
   id VARCHAR(50) PRIMARY KEY,
   date DATE,
   expense_type1 VARCHAR(50),
   expense_type VARCHAR(50),
   amount DECIMAL(10, 2)
);

ALTER TABLE revenue
    ADD COLUMN year INT,
    ADD COLUMN month INT,
    ADD COLUMN month_name VARCHAR(20),
    ADD CoLUMN day INT;

UPDATE revenue
SET year = EXTRACT(YEAR FROM date),
    month = EXTRACT(MONTH FROM date),
    month_name = TRIM(TO_CHAR(date, 'Month')),
    day = EXTRACT(DAY FROM date);

SELECT * FROM revenue;

ALTER TABLE expenses
    ADD COLUMN year INT,
    ADD COLUMN month INT,
    ADD COLUMN month_name VARCHAR(20),
    ADD CoLUMN day INT;

UPDATE expenses
SET year = EXTRACT(YEAR FROM date),
    month = EXTRACT(MONTH FROM date),
    month_name = TRIM(TO_CHAR(date, 'Month')),
    day = EXTRACT(DAY FROM date);

SELECT * FROM expenses;

ALTER TABLE attendance
    ADD COLUMN year INT,
    ADD COLUMN month INT,
    ADD COLUMN month_name VARCHAR(20),
    ADD CoLUMN day INT; 

UPDATE attendance
SET year = EXTRACT(YEAR FROM attendance_date),
    month = EXTRACT(MONTH FROM attendance_date),
    month_name = TRIM(TO_CHAR(attendance_date, 'Month')),
    day = EXTRACT(DAY FROM attendance_date);

SELECT * FROM attendance;