-- seed.sql
-- Staging-to-production import with cleansing + parent-first merge order.
\set ON_ERROR_STOP on
BEGIN;

CREATE TEMP TABLE stg_branches (
    branch_id TEXT,
    branch_name TEXT,
    branch_address TEXT,
    branch_num TEXT
) ON COMMIT DROP;

CREATE TEMP TABLE stg_customers (
    customer_id TEXT,
    first_name TEXT,
    last_name TEXT,
    date_of_birth TEXT,
    address TEXT,
    phone_number TEXT,
    city TEXT,
    email TEXT
) ON COMMIT DROP;

CREATE TEMP TABLE stg_employees (
    employee_id TEXT,
    first_name TEXT,
    last_name TEXT,
    position TEXT,
    branch_id TEXT,
    hire_date TEXT
) ON COMMIT DROP;

CREATE TEMP TABLE stg_accounts (
    account_no TEXT,
    customer_id TEXT,
    branch_id TEXT,
    account_type TEXT,
    balance TEXT,
    date_open TEXT
) ON COMMIT DROP;

CREATE TEMP TABLE stg_transactions (
    transaction_id TEXT,
    account_no TEXT,
    transaction_type TEXT,
    amount TEXT,
    transaction_date TEXT
) ON COMMIT DROP;

CREATE TEMP TABLE stg_loans (
    loan_id TEXT,
    customer_id TEXT,
    account_no TEXT,
    loan_amount TEXT,
    loan_type TEXT,
    issue_date TEXT,
    int_rate TEXT
) ON COMMIT DROP;

\copy stg_branches    FROM 'data/branches.csv'     WITH (FORMAT csv, HEADER true)
\copy stg_customers   FROM 'data/customers.csv'    WITH (FORMAT csv, HEADER true)
\copy stg_employees   FROM 'data/employees.csv'    WITH (FORMAT csv, HEADER true)
\copy stg_accounts    FROM 'data/accounts.csv'     WITH (FORMAT csv, HEADER true)
\copy stg_transactions FROM 'data/transactions.csv' WITH (FORMAT csv, HEADER true)
\copy stg_loans       FROM 'data/loans.csv'        WITH (FORMAT csv, HEADER true)

INSERT INTO branches (branch_id, branch_name, branch_address, branch_num)
SELECT
    branch_id::INTEGER,
    TRIM(branch_name),
    TRIM(branch_address),
    TRIM(branch_num)
FROM stg_branches
ON CONFLICT (branch_id) DO UPDATE SET
    branch_name    = EXCLUDED.branch_name,
    branch_address = EXCLUDED.branch_address,
    branch_num     = EXCLUDED.branch_num;

WITH cleaned_customers AS (
    SELECT
        customer_id::INTEGER AS customer_id,
        INITCAP(TRIM(first_name)) AS first_name,
        INITCAP(TRIM(last_name))  AS last_name,
        date_of_birth::DATE       AS date_of_birth,
        TRIM(address)             AS address,
        INITCAP(TRIM(city))       AS city,
        CASE
            WHEN LOWER(TRIM(email)) ~ '^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$'
                THEN LOWER(TRIM(email))
            ELSE LOWER(
                REGEXP_REPLACE(TRIM(first_name), '\s+', '', 'g') || '.' ||
                REGEXP_REPLACE(TRIM(last_name),  '\s+', '', 'g') || '.' ||
                customer_id || '@metrobank.co.uk'
            )
        END AS normalized_email,
        CASE
            WHEN NULLIF(TRIM(phone_number), '') IS NULL
                THEN '+44' || '700' || LPAD(customer_id, 7, '0')
            ELSE CASE
                WHEN REGEXP_REPLACE(phone_number, '\D', '', 'g') ~ '^0\d{10}$'
                    THEN '+44' || SUBSTRING(REGEXP_REPLACE(phone_number, '\D', '', 'g') FROM 2)
                WHEN REGEXP_REPLACE(phone_number, '\D', '', 'g') ~ '^44\d{10}$'
                    THEN '+' || REGEXP_REPLACE(phone_number, '\D', '', 'g')
                WHEN REGEXP_REPLACE(phone_number, '\D', '', 'g') ~ '^7\d{9}$'
                    THEN '+44' || REGEXP_REPLACE(phone_number, '\D', '', 'g')
                ELSE '+44' || '700' || LPAD(customer_id, 7, '0')
            END
        END AS normalized_phone
    FROM stg_customers
)
INSERT INTO customers (
    customer_id, first_name, last_name, date_of_birth,
    address, phone_number, city, email
)
SELECT
    customer_id, first_name, last_name, date_of_birth,
    address, normalized_phone, city, normalized_email
FROM cleaned_customers
ON CONFLICT (customer_id) DO UPDATE SET
    first_name    = EXCLUDED.first_name,
    last_name     = EXCLUDED.last_name,
    date_of_birth = EXCLUDED.date_of_birth,
    address       = EXCLUDED.address,
    phone_number  = EXCLUDED.phone_number,
    city          = EXCLUDED.city,
    email         = EXCLUDED.email;

INSERT INTO employees (employee_id, first_name, last_name, position, branch_id, hire_date)
SELECT
    employee_id::INTEGER,
    INITCAP(TRIM(first_name)),
    INITCAP(TRIM(last_name)),
    INITCAP(TRIM(position)),
    branch_id::INTEGER,
    hire_date::DATE
FROM stg_employees
ON CONFLICT (employee_id) DO UPDATE SET
    first_name = EXCLUDED.first_name,
    last_name  = EXCLUDED.last_name,
    position   = EXCLUDED.position,
    branch_id  = EXCLUDED.branch_id,
    hire_date  = EXCLUDED.hire_date;

INSERT INTO accounts (account_no, customer_id, branch_id, account_type, balance, date_open)
SELECT
    account_no::INTEGER,
    customer_id::INTEGER,
    branch_id::INTEGER,
    CASE WHEN LOWER(TRIM(account_type)) = 'savings' THEN 'Savings' ELSE 'Current' END,
    GREATEST(balance::NUMERIC(15,2), 0),
    date_open::DATE
FROM stg_accounts
ON CONFLICT (account_no) DO UPDATE SET
    customer_id  = EXCLUDED.customer_id,
    branch_id    = EXCLUDED.branch_id,
    account_type = EXCLUDED.account_type,
    balance      = EXCLUDED.balance,
    date_open    = EXCLUDED.date_open;

INSERT INTO transactions (transaction_id, account_no, transaction_type, amount, transaction_date)
SELECT
    transaction_id::INTEGER,
    account_no::INTEGER,
    CASE
        WHEN LOWER(TRIM(transaction_type)) = 'deposit'    THEN 'Deposit'
        WHEN LOWER(TRIM(transaction_type)) = 'withdrawal' THEN 'Withdrawal'
        WHEN LOWER(TRIM(transaction_type)) = 'transfer'   THEN 'Transfer'
        ELSE 'Payment'
    END,
    amount::NUMERIC(15,2),
    transaction_date::TIMESTAMPTZ
FROM stg_transactions
ON CONFLICT (transaction_id) DO UPDATE SET
    account_no       = EXCLUDED.account_no,
    transaction_type = EXCLUDED.transaction_type,
    amount           = EXCLUDED.amount,
    transaction_date = EXCLUDED.transaction_date;

INSERT INTO loans (loan_id, customer_id, account_no, loan_amount, loan_type, issue_date, int_rate)
SELECT
    loan_id::INTEGER,
    customer_id::INTEGER,
    account_no::INTEGER,
    loan_amount::NUMERIC(15,2),
    INITCAP(TRIM(loan_type)),
    issue_date::DATE,
    int_rate::NUMERIC(5,2)
FROM stg_loans
ON CONFLICT (loan_id) DO UPDATE SET
    customer_id = EXCLUDED.customer_id,
    account_no  = EXCLUDED.account_no,
    loan_amount = EXCLUDED.loan_amount,
    loan_type   = EXCLUDED.loan_type,
    issue_date  = EXCLUDED.issue_date,
    int_rate    = EXCLUDED.int_rate;

COMMIT;