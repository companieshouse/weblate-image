#!/bin/bash

# the password is provided via the env var $PGPASSWORD

psql -h "$POSTGRES_HOST" -U "$PSQL_MASTER_USER" \
     -d "$POSTGRES_DB" \
     -v user="$POSTGRES_USER" \
     -v password="$POSTGRES_PASSWORD" \
     -v db="$POSTGRES_DB" \
     -f /entrypoint/init_db.sql

unset PGPASSWORD
