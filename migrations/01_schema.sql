-- 01_schema.sql
-- Parent-first schema creation to avoid FK dependency errors (23503).
CREATE TABLE IF NOT EXISTS branches (
    branch_id INTEGER PRIMARY KEY,
    branch_name VARCHAR(120) NOT NULL,
    branch_address VARCHAR(255) NOT NULL,
    branch_num VARCHAR(20) NOT NULL UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by TEXT NOT NULL DEFAULT CURRENT_USER
);

CREATE TABLE IF NOT EXISTS customers (
    customer_id INTEGER PRIMARY KEY,
    first_name VARCHAR(80) NOT NULL,
    last_name VARCHAR(80) NOT NULL,
    date_of_birth DATE NOT NULL,
    address VARCHAR(255) NOT NULL,
    phone_number VARCHAR(16) NOT NULL UNIQUE,
    city VARCHAR(80) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by TEXT NOT NULL DEFAULT CURRENT_USER,
    CONSTRAINT chk_customers_email_format CHECK (
        email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
    ),
    CONSTRAINT chk_customers_phone_uk_format CHECK (phone_number ~ '^\+44[0-9]{9,10}$')
);

CREATE TABLE IF NOT EXISTS employees (
    employee_id INTEGER PRIMARY KEY,
    first_name VARCHAR(80) NOT NULL,
    last_name VARCHAR(80) NOT NULL,
    position VARCHAR(80) NOT NULL,
    branch_id INTEGER NOT NULL,
    hire_date DATE NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by TEXT NOT NULL DEFAULT CURRENT_USER,
    CONSTRAINT fk_employees_branch FOREIGN KEY (branch_id) REFERENCES branches(branch_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS accounts (
    account_no INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    branch_id INTEGER NOT NULL,
    account_type VARCHAR(20) NOT NULL,
    balance NUMERIC(15, 2) NOT NULL DEFAULT 0.00,
    date_open DATE NOT NULL DEFAULT CURRENT_DATE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by TEXT NOT NULL DEFAULT CURRENT_USER,
    CONSTRAINT fk_accounts_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_accounts_branch FOREIGN KEY (branch_id) REFERENCES branches(branch_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_accounts_type CHECK (account_type IN ('Savings', 'Current')),
    CONSTRAINT chk_accounts_balance_non_negative CHECK (balance >= 0)
);

CREATE TABLE IF NOT EXISTS transactions (
    transaction_id INTEGER PRIMARY KEY,
    account_no INTEGER NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    amount NUMERIC(15, 2) NOT NULL,
    transaction_date TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by TEXT NOT NULL DEFAULT CURRENT_USER,
    CONSTRAINT fk_transactions_account FOREIGN KEY (account_no) REFERENCES accounts(account_no) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_transactions_type CHECK (
        transaction_type IN ('Deposit', 'Withdrawal', 'Transfer', 'Payment')
    ),
    CONSTRAINT chk_transactions_amount_positive CHECK (amount > 0)
);

CREATE TABLE IF NOT EXISTS loans (
    loan_id INTEGER PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    account_no INTEGER NOT NULL,
    loan_amount NUMERIC(15, 2) NOT NULL,
    loan_type VARCHAR(30) NOT NULL,
    issue_date DATE NOT NULL,
    int_rate NUMERIC(5, 2) NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by TEXT NOT NULL DEFAULT CURRENT_USER,
    CONSTRAINT fk_loans_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_loans_account FOREIGN KEY (account_no) REFERENCES accounts(account_no) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT chk_loans_amount_positive CHECK (loan_amount > 0),
    CONSTRAINT chk_loans_interest_range CHECK (
        int_rate > 0
        AND int_rate <= 100
    )
);