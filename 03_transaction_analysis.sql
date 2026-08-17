-- 1. Monthly transaction value
SELECT DATE_FORMAT(transaction_date,'%Y-%m') AS month,
       COUNT(*) AS transactions,
       ROUND(SUM(transaction_amount),2) AS transaction_value
FROM transactions
WHERE transaction_status='Completed'
GROUP BY month ORDER BY month;

-- 2. Transaction type performance
SELECT transaction_type,
       COUNT(*) AS transaction_count,
       ROUND(SUM(transaction_amount),2) AS transaction_value,
       ROUND(AVG(transaction_amount),2) AS avg_transaction
FROM transactions
WHERE transaction_status='Completed'
GROUP BY transaction_type
ORDER BY transaction_value DESC;

-- 3. Failed transaction rate
SELECT ROUND(
  SUM(transaction_status='Failed') / COUNT(*) * 100, 2
) AS failed_rate_pct
FROM transactions;

-- 4. Month-over-month transaction growth
WITH monthly AS (
 SELECT DATE_FORMAT(transaction_date,'%Y-%m') AS month,
        SUM(transaction_amount) AS value
 FROM transactions
 WHERE transaction_status='Completed'
 GROUP BY month
)
SELECT month,value,
       LAG(value) OVER(ORDER BY month) AS previous_month,
       ROUND((value-LAG(value) OVER(ORDER BY month)) /
       NULLIF(LAG(value) OVER(ORDER BY month),0)*100,2) AS mom_growth_pct
FROM monthly ORDER BY month;

-- 5. Running transaction value
WITH monthly AS (
 SELECT DATE_FORMAT(transaction_date,'%Y-%m') AS month,
        SUM(transaction_amount) AS value
 FROM transactions
 WHERE transaction_status='Completed'
 GROUP BY month
)
SELECT month,value,
       SUM(value) OVER(ORDER BY month) AS running_value
FROM monthly;
