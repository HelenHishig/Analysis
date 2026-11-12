SELECT 
    (SELECT COUNT(*) FROM revenue) AS revenue_records,
    (SELECT COUNT(*) FROM expenses) AS expenses_records,
    (SeLECT COUNT(*) FROM attendance) AS attendance_records;

SELECT 
    sum(amount) AS total_revenue,
    revenue_type   
FROM revenue
GROUP BY revenue_type;

SELECT
    SUM(amount) AS total_expenses,
    expense_type
FROM expenses
GROUP BY expense_type;

SELECT
    name,
    COUNT(*) AS present_count
FROM attendance
WHERE status = 'Present'
GROUP BY name
ORDER BY present_count DESC;

--Montly financial performance
WITH monthly_revenue AS (
    SELECT 
        DATE_TRUNC('month', date) AS month,
        SUM(amount) AS total_revenue
    FROM revenue
    WHERE revenue_type = 'Tuition'
    GROUP BY month
),
monthly_expenses AS (
    SELECT 
        DATE_TRUNC('month', date) AS month,
        Sum(amount) AS total_expenses
    FROM expenses
    WHERE expense_type NOT IN ( 'Intercompany loan', 'Social sec, tax', 'Owner')
    GROUP BY month
)
SELECT 
    COALESCE(r.month, e.month) AS month,
    COALESCE(r.total_revenue, 0) AS total_revenue,
    COALESCE(e.total_expenses, 0) AS total_expenses,
    COALESCE(r.total_revenue, 0) - COALESCE(e.total_expenses, 0) AS net_profit
FROM monthly_revenue r
FULL OUTER JOIN monthly_expenses e ON r.month = e.month
ORDER BY month;

--Checking total revenue, expense, profit
WITH total_revenue AS (
    SELECT 
        SUM(amount) AS total_revenue
    FROM revenue
    WHERE revenue_type = 'Tuition'
),
total_expenses AS (
    SELECT 
        SUM(amount) AS total_expenses
    FROM expenses
    WHERE expense_type NOT IN ('Intercompany loan', 'Social sec, tax', 'Owner')
)
SELECT 
    COALESCE(r.total_revenue, 0) AS total_revenue,
    COALESCE(e.total_expenses, 0) AS total_expenses,
    COALESCE(r.total_revenue, 0) - COALESCE(e.total_expenses, 0) AS net_profit
FROM total_revenue r
CROSS JOIN total_expenses e;

--Checking the social sec and tax expenses
SELECT 
    SUM(amount) AS total_social_sec_tax_expenses
FROM expenses
WHERE expense_type = 'Social sec, tax';

-- Expense category analysis
SELECT 
    expense_type,
    SUM(amount) AS total_expense,
    ROUND(
        SUM(amount)*100.0/SUM(SUM(amount)) OVER (), 2
    ) AS percentage_of_total_expense
FROM expenses
WHERE expense_type NOT IN ('Intercompany loan')
GROUP BY expense_type
ORDER BY total_expense DESC;

--Attendance analysis
SELECT 
    status,
    COUNT(*) AS status_count
FROM attendance
GROUP BY status;

--Monthly attendance analysis

CREATE TABLE monthly_attendance AS 
SELECT
    DATE_TRUNC('month', attendance_date)::DATE AS month,
    COUNT(*) AS total_attendance_records,
    COUNT(*) FILTER (
        WHERE LOWER(TRIM(status)) = 'present'
    ) AS present_records,
    COUNT(*) FILTER (
        WHERE LOWER(TRIM(status)) = 'absent'
    ) AS absent_records
FROM public.attendance
GROUP BY 1
ORDER BY month;

SELECT * FROM monthly_attendance;

ALTER TABLE monthly_attendance
    ADD COLUMN year INT,
    ADD COLUMN month1 INT,
    ADD COLUMN month_name VARCHAR(20);

UPDATE monthly_attendance
SET year = EXTRACT(YEAR FROM month),
    month1 = EXTRACT(MONTH FROM month),
    month_name = TRIM(TO_CHAR(month, 'Month'));

ALTER TABLE monthly_attendance
    ADD COLUMN present_percentage DECIMAL(5, 2),
    ADD COLUMN absent_percentage DECIMAL(5, 2);

UPDATE monthly_attendance
SET present_percentage = ROUND((present_records * 100.0 / total_attendance_records), 2),
    absent_percentage = ROUND((absent_records * 100.0 / total_attendance_records), 2);