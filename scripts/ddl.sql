-- Data Definition Language (DDL)
-- CREATE, ALTER, DROP & TRUNCATE

-- Create tables

-- 1. Create Branches Table
CREATE TABLE branches (
    branch_id INT PRIMARY KEY,
    branch_name VARCHAR(255) NOT NULL,
    branch_address VARCHAR(255),
    branch_num VARCHAR(20) UNIQUE
);

-- 2. Create Customers Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    date_of_birth DATE,
    address TEXT,
    phone_number VARCHAR(20),
    city VARCHAR(255)
);

-- 3. Create Employees Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    position VARCHAR(255),
    branch_id INT,
    hire_date DATE,
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

-- 4. Create Accounts Table
CREATE TABLE accounts (
    account_no INT PRIMARY KEY,
    customer_id INT NOT NULL,
    branch_id INT NOT NULL,
    account_type VARCHAR(255) NOT NULL,
    balance DECIMAL(15, 2) DEFAULT 0.00,
    date_open DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES branches(branch_id)
);

-- 5. Create Transactions Table
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    account_no INT NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_no) REFERENCES accounts(account_no)
);

-- 6. Create Loans Table
CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    account_no INT,
    loan_amount DECIMAL(25, 2) NOT NULL,
    loan_type VARCHAR(30),
    issue_date DATE,
    int_rate DECIMAL(5, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (account_no) REFERENCES accounts(account_no)
);

-- ALTER tables, 

-- Question 1
ALTER TABLE customers ADD email varchar(255);

-- Question 2
-- ALTER loans table, change int_rate type to float
ALTER TABLE loans ALTER COLUMN int_rate TYPE FLOAT;

-- Question 3
-- ALTER customers phone number
ALTER TABLE customers ADD UNIQUE (phone_number);

-- TRUNCATE tables
-- Foreign keys references must be drop before truncate can work

ALTER TABLE transactions DROP CONSTRAINT transactions_account_no_fkey;
ALTER TABLE loans DROP CONSTRAINT loans_account_no_fkey;
TRUNCATE TABLE accounts;
TRUNCATE TABLE transactions;
TRUNCATE TABLE loans;

-- Establish the relationship or connection again

ALTER TABLE transactions ADD CONSTRAINT transactions_account_no_fkey 
FOREIGN KEY (account_no) REFERENCES accounts(account_no);

ALTER TABLE loans ADD CONSTRAINT loans_account_no_fkey 
FOREIGN KEY (account_no) REFERENCES accounts(account_no);

/*
 THIS IS THE FASTEST APPROACH TO TRUNCATE TABLE:
 
 TRUNCATE TABLE transactions CASCADE;
 TRUNCATE TABLE loans CASCADE;

 */

-- DROP Tables
DROP TABLE IF EXISTS 
transactions, 
loans, 
accounts, 
employees, 
customers, 
branches 
CASCADE;