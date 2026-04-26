#!/usr/bin/env bash
set -euo pipefail

DB_NAME="${1:-${PGDATABASE:-metrobank_prod}}"
DB_USER_ARG="${2:-}"
DB_HOST="${PGHOST:-localhost}"
DB_PORT="${PGPORT:-}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ -n "$DB_USER_ARG" ]]; then
	export PGUSER="$DB_USER_ARG"
fi

DB_USER="${PGUSER:-postgres}"
export PGUSER="$DB_USER"

if [[ -z "${PGPASSWORD:-}" && -z "${PGPASSFILE:-}" ]]; then
	read -r -s -p "Password for user $DB_USER: " INPUT_PASSWORD
	echo
	export PGPASSWORD="$INPUT_PASSWORD"
fi

if [[ -z "$DB_PORT" ]]; then
	for candidate_port in 5432 5433; do
		if command -v nc >/dev/null 2>&1 && nc -z "$DB_HOST" "$candidate_port" >/dev/null 2>&1; then
			DB_PORT="$candidate_port"
			break
		fi
	done

	if [[ -z "$DB_PORT" ]]; then
		for candidate_port in 5432 5433; do
			if (echo >/dev/tcp/"$DB_HOST"/"$candidate_port") >/dev/null 2>&1; then
				DB_PORT="$candidate_port"
				break
			fi
		done
	fi

	DB_PORT="${DB_PORT:-5432}"
fi

cd "$ROOT_DIR"

echo "Using PostgreSQL endpoint: $DB_HOST:$DB_PORT"
echo "Using PostgreSQL user: $DB_USER"

ERR_FILE="$(mktemp)"
if ! psql -v ON_ERROR_STOP=1 -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" -c "SELECT 1" >/dev/null 2>"$ERR_FILE"; then
	echo "Connection precheck failed for database: $DB_NAME"
	if grep -qi "password authentication failed" "$ERR_FILE"; then
		echo "Authentication failed for user '$DB_USER'."
		echo "Hint: pass credentials inline, e.g."
		echo "  PGHOST=$DB_HOST PGPORT=$DB_PORT PGUSER=postgres PGPASSWORD='your_password' ./scripts/load_staging.sh $DB_NAME"
	elif grep -qi "database .* does not exist" "$ERR_FILE"; then
		echo "Database '$DB_NAME' does not exist on $DB_HOST:$DB_PORT."
		echo "Create it first, or pass the correct database name as argument 1."
	else
		echo "Unable to connect. Raw psql error:"
		cat "$ERR_FILE"
	fi
	rm -f "$ERR_FILE"
	exit 2
fi
rm -f "$ERR_FILE"

echo "[1/2] Applying hardened schema to database: $DB_NAME"
psql -v ON_ERROR_STOP=1 -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" -f setup.sql

echo "[2/2] Loading CSVs via staging and merging into production tables"
psql -v ON_ERROR_STOP=1 -h "$DB_HOST" -p "$DB_PORT" -d "$DB_NAME" -f seed.sql

echo "Load complete."
