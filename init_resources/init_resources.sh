#!/bin/bash

psql -h "$POSTGRES_HOST" -U "$PSQL_MASTER_USER" \
     -d "$POSTGRES_DB" \
     -v user="$POSTGRES_USER" \
     -v password="$POSTGRES_PASSWORD" \
     -v db="$POSTGRES_DB" \
     -f /init_resources/init_db.sql
