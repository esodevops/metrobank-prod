
-- Count the number of existing customers

SELECT COUNT(*) FROM customers;

-- Count the number of existing accounts

SELECT COUNT(*) FROM accounts;

-- Count number of available transactions

SELECT COUNT(*) FROM transactions;

SELECT COUNT(*) FROM loans;

SELECT COUNT(*) FROM account_balance_audit_log;

-- 1) Customer distribution by city
SELECT
    city,
    COUNT(*) AS customer_count
FROM
    customers
GROUP BY
    city
ORDER BY
    customer_count DESC,
    city;

-- 2) Accounts by type with total and average balances
SELECT
    account_type,
    COUNT(*) AS account_count,
    ROUND(SUM(balance), 2) AS total_balance,
    ROUND(AVG(balance), 2) AS avg_balance
FROM
    accounts
GROUP BY
    account_type
ORDER BY
    total_balance DESC;

-- 3) Top 10 customers by total account balance
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    ROUND(SUM(a.balance), 2) AS total_customer_balance
FROM
    customers c
    JOIN accounts a ON a.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY
    total_customer_balance DESC
LIMIT
    10;

-- 4) Transaction volume and value by type
SELECT
    transaction_type,
    COUNT(*) AS transaction_count,
    ROUND(SUM(amount), 2) AS total_amount,
    ROUND(AVG(amount), 2) AS avg_amount
FROM
    transactions
GROUP BY
    transaction_type
ORDER BY
    total_amount DESC;

-- 5) Daily transaction trend (last 30 days in data)
SELECT
    DATE(transaction_date) AS txn_date,
    COUNT(*) AS txn_count,
    ROUND(SUM(amount), 2) AS txn_total
FROM
    transactions
WHERE
    transaction_date >= (
        SELECT
            MAX(transaction_date) - INTERVAL '30 days'
        FROM
            transactions
    )
GROUP BY
    DATE(transaction_date)
ORDER BY
    txn_date;

-- 6) Branch-level account portfolio summary
SELECT
    b.branch_id,
    b.branch_name,
    COUNT(a.account_no) AS account_count,
    ROUND(SUM(a.balance), 2) AS total_branch_balance
FROM
    branches b
    LEFT JOIN accounts a ON a.branch_id = b.branch_id
GROUP BY
    b.branch_id,
    b.branch_name
ORDER BY
    total_branch_balance DESC NULLS LAST;

-- 7) Loan book summary by loan type
SELECT
    loan_type,
    COUNT(*) AS loan_count,
    ROUND(SUM(loan_amount), 2) AS total_loan_amount,
    ROUND(AVG(int_rate), 2) AS avg_interest_rate
FROM
    loans
GROUP BY
    loan_type
ORDER BY
    total_loan_amount DESC;

-- 8) Customers with loans and their total exposure
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(l.loan_id) AS loan_count,
    ROUND(SUM(l.loan_amount), 2) AS total_loan_exposure
FROM
    customers c
    JOIN loans l ON l.customer_id = c.customer_id
GROUP BY
    c.customer_id,
    c.first_name,
    c.last_name
ORDER BY
    total_loan_exposure DESC;

-- 9) Accounts with highest number of transactions
SELECT
    a.account_no,
    a.customer_id,
    COUNT(t.transaction_id) AS transaction_count,
    ROUND(COALESCE(SUM(t.amount), 0), 2) AS total_transaction_amount
FROM
    accounts a
    LEFT JOIN transactions t ON t.account_no = a.account_no
GROUP BY
    a.account_no,
    a.customer_id
ORDER BY
    transaction_count DESC,
    total_transaction_amount DESC
LIMIT
    10;

-- 10) Recent balance change audit entries
SELECT
    audit_id,
    account_no,
    customer_id,
    old_balance,
    new_balance,
    delta,
    changed_at,
    changed_by
FROM
    account_balance_audit_log
ORDER BY
    changed_at DESC
LIMIT
    20;