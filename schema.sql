-- Banking Customer & Transaction Analytics
CREATE DATABASE banking_analytics;
USE banking_analytics;

CREATE TABLE customers (
 customer_id VARCHAR(10) PRIMARY KEY,
 customer_name VARCHAR(100),
 age INT,
 gender VARCHAR(20),
 city VARCHAR(100),
 state VARCHAR(100),
 occupation VARCHAR(50),
 customer_segment VARCHAR(50),
 join_date DATE
);

CREATE TABLE branches (
 branch_id VARCHAR(10) PRIMARY KEY,
 branch_name VARCHAR(100),
 city VARCHAR(100),
 state VARCHAR(100)
);

CREATE TABLE accounts (
 account_id VARCHAR(10) PRIMARY KEY,
 customer_id VARCHAR(10),
 branch_id VARCHAR(10),
 account_type VARCHAR(50),
 opened_date DATE,
 current_balance DECIMAL(15,2),
 account_status VARCHAR(30),
 FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
 FOREIGN KEY(branch_id) REFERENCES branches(branch_id)
);

CREATE TABLE transactions (
 transaction_id VARCHAR(12) PRIMARY KEY,
 account_id VARCHAR(10),
 transaction_date DATETIME,
 transaction_type VARCHAR(50),
 transaction_amount DECIMAL(15,2),
 channel VARCHAR(50),
 transaction_status VARCHAR(30),
 FOREIGN KEY(account_id) REFERENCES accounts(account_id)
);

CREATE TABLE loans (
 loan_id VARCHAR(10) PRIMARY KEY,
 customer_id VARCHAR(10),
 branch_id VARCHAR(10),
 loan_type VARCHAR(50),
 loan_amount DECIMAL(15,2),
 interest_rate DECIMAL(5,2),
 term_months INT,
 start_date DATE,
 loan_status VARCHAR(30),
 FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
 FOREIGN KEY(branch_id) REFERENCES branches(branch_id)
);
