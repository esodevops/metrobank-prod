-- ============================================================
-- 02_constraints.sql  -  Audit columns, triggers, indexes, roles
-- ============================================================

-- Audit columns (idempotent)
ALTER TABLE branches
    ADD COLUMN IF NOT EXISTS created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    ADD COLUMN IF NOT EXISTS updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    ADD COLUMN IF NOT EXISTS created_by  TEXT        NOT NULL DEFAULT CURRENT_USER;

ALTER TABLE customers
    ADD COLUMN IF NOT EXISTS created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    ADD COLUMN IF NOT EXISTS updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    ADD COLUMN IF NOT EXISTS created_by  TEXT        NOT NULL DEFAULT CURRENT_USER;

-- Email/phone constraints already defined in 01_schema.sql; nothing extra to add here.

ALTER TABLE employees
    ADD COLUMN IF NOT EXISTS created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    ADD COLUMN IF NOT EXISTS updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    ADD COLUMN IF NOT EXISTS created_by  TEXT        NOT NULL DEFAULT CURRENT_USER;

ALTER TABLE accounts
    ADD COLUMN IF NOT EXISTS created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    ADD COLUMN IF NOT EXISTS updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    ADD COLUMN IF NOT EXISTS created_by  TEXT        NOT NULL DEFAULT CURRENT_USER;

ALTER TABLE transactions
    ADD COLUMN IF NOT EXISTS created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    ADD COLUMN IF NOT EXISTS updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    ADD COLUMN IF NOT EXISTS created_by  TEXT        NOT NULL DEFAULT CURRENT_USER;

ALTER TABLE loans
    ADD COLUMN IF NOT EXISTS created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    ADD COLUMN IF NOT EXISTS updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    ADD COLUMN IF NOT EXISTS created_by  TEXT        NOT NULL DEFAULT CURRENT_USER;

-- updated_at trigger function
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql AS
$func$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$func$;

DROP TRIGGER IF EXISTS trg_branches_set_updated_at      ON branches;
DROP TRIGGER IF EXISTS trg_customers_set_updated_at     ON customers;
DROP TRIGGER IF EXISTS trg_employees_set_updated_at     ON employees;
DROP TRIGGER IF EXISTS trg_accounts_set_updated_at      ON accounts;
DROP TRIGGER IF EXISTS trg_transactions_set_updated_at  ON transactions;
DROP TRIGGER IF EXISTS trg_loans_set_updated_at         ON loans;

CREATE TRIGGER trg_branches_set_updated_at
    BEFORE UPDATE ON branches
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_customers_set_updated_at
    BEFORE UPDATE ON customers
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_employees_set_updated_at
    BEFORE UPDATE ON employees
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_accounts_set_updated_at
    BEFORE UPDATE ON accounts
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_transactions_set_updated_at
    BEFORE UPDATE ON transactions
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TRIGGER trg_loans_set_updated_at
    BEFORE UPDATE ON loans
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- Indexes
CREATE INDEX IF NOT EXISTS idx_accounts_customer_id_btree    ON accounts     USING BTREE (customer_id);
CREATE INDEX IF NOT EXISTS idx_accounts_account_no_btree     ON accounts     USING BTREE (account_no);
CREATE INDEX IF NOT EXISTS idx_transactions_account_no_btree ON transactions USING BTREE (account_no);

-- Audit log table
CREATE TABLE IF NOT EXISTS account_balance_audit_log (
    audit_id    BIGSERIAL       PRIMARY KEY,
    account_no  INTEGER         NOT NULL,
    customer_id INTEGER         NOT NULL,
    old_balance NUMERIC(15,2)   NOT NULL,
    new_balance NUMERIC(15,2)   NOT NULL,
    delta       NUMERIC(15,2)   NOT NULL,
    changed_at  TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    changed_by  TEXT            NOT NULL DEFAULT CURRENT_USER,
    created_at  TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMPTZ     NOT NULL DEFAULT NOW(),
    created_by  TEXT            NOT NULL DEFAULT CURRENT_USER,
    CONSTRAINT fk_balance_audit_account
        FOREIGN KEY (account_no)  REFERENCES accounts(account_no)   ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT fk_balance_audit_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON UPDATE CASCADE ON DELETE RESTRICT
);

DROP TRIGGER IF EXISTS trg_account_balance_audit_set_updated_at ON account_balance_audit_log;
CREATE TRIGGER trg_account_balance_audit_set_updated_at
    BEFORE UPDATE ON account_balance_audit_log
    FOR EACH ROW EXECUTE FUNCTION set_updated_at();

-- Balance change audit trigger function
CREATE OR REPLACE FUNCTION log_customer_balance_change()
RETURNS TRIGGER LANGUAGE plpgsql AS
$func$
BEGIN
    IF NEW.balance IS DISTINCT FROM OLD.balance THEN
        INSERT INTO account_balance_audit_log
            (account_no, customer_id, old_balance, new_balance, delta, changed_by, created_by)
        VALUES
            (NEW.account_no, NEW.customer_id,
             OLD.balance, NEW.balance, NEW.balance - OLD.balance,
             CURRENT_USER, CURRENT_USER);
    END IF;
    RETURN NEW;
END;
$func$;

DROP TRIGGER IF EXISTS trg_log_customer_balance_change ON accounts;
CREATE TRIGGER trg_log_customer_balance_change
    AFTER UPDATE OF balance ON accounts
    FOR EACH ROW EXECUTE FUNCTION log_customer_balance_change();

-- Roles (idempotent)
DO $func$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'app_user') THEN
        CREATE ROLE app_user LOGIN;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'readonly_analyst') THEN
        CREATE ROLE readonly_analyst LOGIN;
    END IF;
END;
$func$;

DO $func$
BEGIN
    EXECUTE FORMAT('GRANT CONNECT ON DATABASE %I TO app_user',        current_database());
    EXECUTE FORMAT('GRANT CONNECT ON DATABASE %I TO readonly_analyst', current_database());
END;
$func$;

GRANT USAGE ON SCHEMA public TO app_user;
GRANT USAGE ON SCHEMA public TO readonly_analyst;

GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO app_user;
GRANT SELECT                          ON ALL TABLES IN SCHEMA public TO readonly_analyst;

GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO app_user;
GRANT SELECT        ON ALL SEQUENCES IN SCHEMA public TO readonly_analyst;

ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO app_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public
    GRANT SELECT ON TABLES TO readonly_analyst;
