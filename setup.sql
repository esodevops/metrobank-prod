-- setup.sql
-- Entrypoint for schema creation and hardening.

\set ON_ERROR_STOP on
BEGIN;
\i migrations/01_schema.sql
\i migrations/02_constraints.sql
COMMIT;
