apt install -y pgbadger

vim ${PGDATA}/postgresql.conf

"
log_line_prefix = '%t [%p]: user=%u,db=%d,app=%a,client=%h '
log_checkpoints = on
log_connections = on
log_disconnections = on
log_lock_waits = on
log_temp_files = 0
log_autovacuum_min_duration = 0
log_min_duration_statement = 0
log_error_verbosity = default
lc_messages = 'en_US.UTF-8'
"

psql -Atqc "
SELECT
  DISTINCT context
  FROM pg_settings
  WHERE name IN (
                 'log_line_prefix',
                 'log_checkpoints',
                 'log_connections',
                 'log_disconnections',
                 'log_lock_waits',
                 'log_temp_files',
                 'log_autovacuum_min_duration',
                 'log_error_verbosity',
                 'lc_messages');
"

pg_ctl reload

createdb db_pgbadger

pgbench -i -s 20 db_pgbadger

pgbench -c 90 -T 530 db_pgbadger

pgbadger -o /tmp/report.html `psql -Atqc 'SHOW log_directory;'`/*

scp postgres@192.168.56.70:/tmp/report.html /tmp/
