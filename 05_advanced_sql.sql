-- 1. Top 3 customers in every state
WITH customer_state AS (
 SELECT c.state,c.customer_id,c.customer_name,
        SUM(t.transaction_amount) AS transaction_value
 FROM customers c
 JOIN accounts a ON c.customer_id=a.customer_id
 JOIN transactions t ON a.account_id=t.account_id
 WHERE t.transaction_status='Completed'
 GROUP BY c.state,c.customer_id,c.customer_name
),
ranked AS (
 SELECT *,ROW_NUMBER() OVER(PARTITION BY state ORDER BY transaction_value DESC) AS rn
 FROM customer_state
)
SELECT * FROM ranked WHERE rn <= 3;

-- 2. Customers whose transaction value is above average
WITH customer_totals AS (
 SELECT c.customer_id,c.customer_name,
        SUM(t.transaction_amount) AS total_value
 FROM customers c JOIN accounts a ON c.customer_id=a.customer_id
 JOIN transactions t ON a.account_id=t.account_id
 WHERE t.transaction_status='Completed'
 GROUP BY c.customer_id,c.customer_name
)
SELECT *
FROM customer_totals
WHERE total_value > (SELECT AVG(total_value) FROM customer_totals)
ORDER BY total_value DESC;

-- 3. Dormant accounts: no completed transaction in the last 90 days of the dataset
SELECT a.account_id,a.customer_id,a.current_balance
FROM accounts a
LEFT JOIN transactions t
  ON a.account_id=t.account_id
  AND t.transaction_status='Completed'
  AND t.transaction_date >= '2025-10-03'
WHERE a.account_status='Active'
GROUP BY a.account_id,a.customer_id,a.current_balance
HAVING COUNT(t.transaction_id)=0;

-- 4. Branch transaction performance
SELECT b.branch_id,b.branch_name,b.city,
       COUNT(t.transaction_id) AS transaction_count,
       ROUND(SUM(t.transaction_amount),2) AS transaction_value
FROM branches b
JOIN accounts a ON b.branch_id=a.branch_id
JOIN transactions t ON a.account_id=t.account_id
WHERE t.transaction_status='Completed'
GROUP BY b.branch_id,b.branch_name,b.city
ORDER BY transaction_value DESC;

-- 5. Customer risk flag based on overdue loan
SELECT c.customer_id,c.customer_name,
       CASE WHEN SUM(l.loan_status='Overdue') > 0
            THEN 'High Risk' ELSE 'Normal' END AS risk_flag
FROM customers c
LEFT JOIN loans l ON c.customer_id=l.customer_id
GROUP BY c.customer_id,c.customer_name;
