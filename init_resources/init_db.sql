-- Try to keep these instructions idempotent

-- 1) Create Weblate user if it does not exist
--    (idempotent)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT FROM pg_catalog.pg_roles WHERE rolname = :'user'
    ) THEN
        EXECUTE format('CREATE USER %I WITH PASSWORD %L', :'user', :'password');
    END IF;
END;
$$;

-- 2) Connect,Create,... permissions
--    (idempotent)
GRANT CONNECT, CREATE, TEMPORARY ON DATABASE :"db" TO :"user";

-- 3) Ensure the public schema exists and is owned by Weblate user
--    (idempotent)
ALTER SCHEMA public OWNER TO :"user";
GRANT USAGE ON SCHEMA public TO :"user";

-- 4) Explicit privileges on all existing tables and sequences
--    (idempotent)
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO :"user";
GRANT USAGE, SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO :"user";

-- 5) Default privileges for all future objects created in this schema
--    (idempotent)
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO :"user";
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT USAGE, SELECT, UPDATE ON SEQUENCES TO :"user";
ALTER DEFAULT PRIVILEGES IN SCHEMA public
  GRANT EXECUTE ON FUNCTIONS TO :"user";

-- 6) make sure the user can connect and owns what it needs
--    (idempotent)
GRANT ALL PRIVILEGES ON DATABASE :"db" TO :"user";
