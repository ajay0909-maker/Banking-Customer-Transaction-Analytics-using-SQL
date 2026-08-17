-- 1. Customer count
SELECT COUNT(*) AS total_customers FROM customers;

-- 2. Account count by type
SELECT account_type, COUNT(*) AS accounts
FROM accounts GROUP BY account_type ORDER BY accounts DESC;

-- 3. Total current balance
SELECT ROUND(SUM(current_balance),2) AS total_deposits
FROM accounts WHERE account_status='Active';

-- 4. Transaction volume and value
SELECT COUNT(*) AS transactions,
       ROUND(SUM(transaction_amount),2) AS transaction_value
FROM transactions
WHERE transaction_status='Completed';

-- 5. Transaction channels
SELECT channel, COUNT(*) AS transaction_count,
       ROUND(SUM(transaction_amount),2) AS transaction_value
FROM transactions
WHERE transaction_status='Completed'
GROUP BY channel ORDER BY transaction_value DESC;
