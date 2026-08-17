# Banking Customer & Transaction Analytics using SQL

## 📊 Project Overview
A portfolio-ready SQL analytics project analyzing a simulated banking dataset containing **5,000 customers, 7,000 accounts, 25,000 transactions and 1,800 loans**.

The project focuses on customer behavior, transaction performance, account balances, loan portfolios, branch performance and customer risk indicators.

## 🎯 Business Questions
- What is the total customer and account base?
- What is the total transaction value?
- Which transaction channels are most used?
- Which customers have the highest transaction value?
- Which customers have multiple accounts?
- What are monthly transaction trends and MoM growth?
- Which transaction types contribute the most value?
- What is the failed transaction rate?
- Which loan types have the highest exposure?
- How much loan exposure is overdue?
- Which branches have the highest loan and transaction volumes?
- Which customers have unusually high transaction activity?
- Which active accounts appear dormant?
- Which customers should be flagged for overdue-loan risk?

## 🛠️ SQL Skills Demonstrated
- SELECT, WHERE, ORDER BY
- GROUP BY, HAVING
- INNER JOIN and LEFT JOIN
- CASE WHEN
- CTEs
- Subqueries
- Aggregate functions
- RANK, DENSE_RANK, ROW_NUMBER
- LAG
- Running totals
- Month-over-month growth
- Customer segmentation
- Risk flagging

## 📁 Project Structure
```text
Banking_Customer_Transaction_SQL_Portfolio/
├── README.md
├── database/
│   ├── schema.sql
│   ├── customers.csv
│   ├── accounts.csv
│   ├── transactions.csv
│   ├── loans.csv
│   └── branches.csv
├── queries/
│   ├── 01_basic_analysis.sql
│   ├── 02_customer_analysis.sql
│   ├── 03_transaction_analysis.sql
│   ├── 04_loan_analysis.sql
│   └── 05_advanced_sql.sql
└── insights/
    └── business_insights.md
```

## 🚀 How to Run in MySQL
1. Run `database/schema.sql`.
2. Import the five CSV files into their corresponding tables.
3. Execute the SQL files in the `queries` folder.
4. Review the results and record business insights.

## 💼 Resume Description
> Analyzed a simulated banking dataset using SQL to evaluate customer behavior, transaction trends, account activity, loan exposure, branch performance and customer risk. Applied joins, CTEs, subqueries and advanced window functions including RANK, DENSE_RANK, ROW_NUMBER and LAG to generate business insights.

## Dataset Note
The data is synthetic and created for portfolio/learning purposes.
