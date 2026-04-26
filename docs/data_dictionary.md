# Data Dictionary

## branches

- branch_id: Integer, primary key.
- branch_name: Branch display name.
- branch_address: Physical branch address.
- branch_num: Unique branch code.
- created_at, updated_at, created_by: Audit metadata.

## customers

- customer_id: Integer, primary key.
- first_name, last_name: Customer legal names.
- date_of_birth: Date of birth.
- address: Mailing address.
- phone_number: UK normalized phone in +44 format; unique.
- city: Customer city.
- email: Validated email; unique.
- created_at, updated_at, created_by: Audit metadata.

## employees

- employee_id: Integer, primary key.
- first_name, last_name: Employee names.
- position: Role title.
- branch_id: FK to branches.branch_id.
- hire_date: Employment start date.
- created_at, updated_at, created_by: Audit metadata.

## accounts

- account_no: Integer, primary key.
- customer_id: FK to customers.customer_id.
- branch_id: FK to branches.branch_id.
- account_type: Savings or Current.
- balance: Non-negative account balance.
- date_open: Account open date.
- created_at, updated_at, created_by: Audit metadata.

## transactions

- transaction_id: Integer, primary key.
- account_no: FK to accounts.account_no.
- transaction_type: Deposit, Withdrawal, Transfer, or Payment.
- amount: Positive monetary value.
- transaction_date: Transaction timestamp.
- created_at, updated_at, created_by: Audit metadata.

## loans

- loan_id: Integer, primary key.
- customer_id: FK to customers.customer_id.
- account_no: FK to accounts.account_no.
- loan_amount: Positive monetary value.
- loan_type: Product category.
- issue_date: Loan issue date.
- int_rate: Interest rate percentage between 0 and 100.
- created_at, updated_at, created_by: Audit metadata.

## account_balance_audit_log

- audit_id: Big serial primary key.
- account_no: FK to accounts.account_no.
- customer_id: FK to customers.customer_id.
- old_balance, new_balance: Balance values before and after update.
- delta: Difference between new_balance and old_balance.
- changed_at, changed_by: Actor and timestamp for balance update.
- created_at, updated_at, created_by: Audit metadata.
