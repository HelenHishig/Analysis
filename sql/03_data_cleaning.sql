SELECT COUNT(*) AS revenue_records
FROM revenue;

SELECT COUNT(*) AS expenses_records
FROM expenses;

SELECT 
    id, 
    COUNT(*) AS duplicate_count
FROM expenses
GROUP BY id
HAVING COUNT(*) > 1;

SELECT 
    id,
    COUNT(*) AS duplicate_count
FROM revenue
GROUP BY id
HAVING COUNT(*) > 1;

SELECT student_id, COUNT(*) AS duplicate_count
FROM attendance
GROUP BY student_id
HAVING COUNT(*) > 1;

SELECT * 
FROM revenue
WHERE 
    date IS NULL OR
    amount is NULL OR
    revenue_type IS NULL OR
    sending_account IS NULL OR
    transaction_id IS NULL;

SELECT 
    transaction_id, 
    COUNT(*) AS duplicate_count
FROM revenue
GROUP BY transaction_id
HAVING COUNT(*) > 1;

SELECT * 
FROM revenue
WHERE amount <=0;

SELECT *
FROM expenses
WHERE
    date is NULL OR
    amount is NULL OR
    receiving_account IS NULL OR
    transaction_id IS NULL;

SELECT 
    transaction_id,
    COUNT(*) AS duplicate_count
FROM expenses
GROUP BY transaction_id
HAVING COUNT(*) > 1;

SELECT * FROM expenses
WHERE transaction_id = 'SX4576330';

SELECT * FROM expenses
WHERE amount <= 0;

SELECT * FROM attendance
WHERE 
    student_id IS NULL OR
    name IS NULL OR
    attendance_date IS NULL OR
    status IS NULL;

SELECT * FROM attendance
WHERE 
    status IS NULL;

SELECT * FROM attendance;

SELECT * FROM attendance
WHERE student_id = 'K029';

SELECT student_id,
    COUNT(*) AS attendance_count,
    status
FROM attendance
WHERE student_id = 'K029'
GROUP BY student_id, status;


SELECT 
    DISTINCT status,
    COUNT (*) AS status_count
FROM attendance
GROUP BY status;

SELECT * FROM attendance
WHERE status = 'Absent';

SELECT * FROM attendance
WHERE student_id = 'K001' AND status = 'Absent';

SELECT 
    student_id,
    status,
    COUNT(*) AS attendance_count
FROM attendance
WHERE student_id = 'K001'
GROUP BY student_id, status;

SELECT 
    Sum(amount) AS total_expense,
    expense_type
FROM expenses
GROUP BY expense_type

SELECT EXTRACT (MONTH FROM date) AS month
    FROM revenue;