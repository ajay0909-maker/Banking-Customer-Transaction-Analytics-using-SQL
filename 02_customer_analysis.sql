-- 1. Customers by segment
SELECT customer_segment, COUNT(*) AS customers
FROM customers GROUP BY customer_segment ORDER BY customers DESC;

-- 2. Customers with multiple accounts
SELECT customer_id, COUNT(*) AS account_count
FROM accounts GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY account_count DESC;

-- 3. Customers with no account
SELECT c.customer_id,c.customer_name
FROM customers c
LEFT JOIN accounts a ON c.customer_id=a.customer_id
WHERE a.account_id IS NULL;

-- 4. Customer total transaction value
SELECT c.customer_id,c.customer_name,
       ROUND(SUM(t.transaction_amount),2) AS transaction_value
FROM customers c
JOIN accounts a ON c.customer_id=a.customer_id
JOIN transactions t ON a.account_id=t.account_id
WHERE t.transaction_status='Completed'
GROUP BY c.customer_id,c.customer_name
ORDER BY transaction_value DESC
LIMIT 20;

-- 5. Customer transaction ranking
WITH customer_txn AS (
 SELECT c.customer_id,c.customer_name,
        SUM(t.transaction_amount) AS transaction_value
 FROM customers c
 JOIN accounts a ON c.customer_id=a.customer_id
 JOIN transactions t ON a.account_id=t.account_id
 WHERE t.transaction_status='Completed'
 GROUP BY c.customer_id,c.customer_name
)
SELECT *, DENSE_RANK() OVER(ORDER BY transaction_value DESC) AS customer_rank
FROM customer_txn;
