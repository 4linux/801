SHOW port;

ALTER SYSTEM SET port = 5433;

ALTER SYSTEM RESET port;

ALTER SYSTEM SET wal_level = 'cold_standby';
