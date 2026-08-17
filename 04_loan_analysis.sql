-- 1. Loan portfolio by type
SELECT loan_type,
       COUNT(*) AS loans,
       ROUND(SUM(loan_amount),2) AS total_loan_amount,
       ROUND(AVG(interest_rate),2) AS avg_interest_rate
FROM loans
GROUP BY loan_type ORDER BY total_loan_amount DESC;

-- 2. Overdue loan exposure
SELECT ROUND(SUM(loan_amount),2) AS overdue_exposure,
       COUNT(*) AS overdue_loans
FROM loans WHERE loan_status='Overdue';

-- 3. Top branches by loan amount
SELECT b.branch_name,b.city,
       ROUND(SUM(l.loan_amount),2) AS loan_value
FROM branches b
JOIN loans l ON b.branch_id=l.branch_id
GROUP BY b.branch_id,b.branch_name,b.city
ORDER BY loan_value DESC LIMIT 10;

-- 4. Loan customer ranking
WITH customer_loans AS (
 SELECT c.customer_id,c.customer_name,
        SUM(l.loan_amount) AS loan_value
 FROM customers c JOIN loans l ON c.customer_id=l.customer_id
 GROUP BY c.customer_id,c.customer_name
)
SELECT *,RANK() OVER(ORDER BY loan_value DESC) AS loan_rank
FROM customer_loans;

-- 5. Average loan amount by segment
SELECT c.customer_segment,
       ROUND(AVG(l.loan_amount),2) AS avg_loan_amount,
       COUNT(l.loan_id) AS loan_count
FROM customers c JOIN loans l ON c.customer_id=l.customer_id
GROUP BY c.customer_segment
ORDER BY avg_loan_amount DESC;
