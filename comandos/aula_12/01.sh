
## Como root
mkdir -p /var/log/pgsql/14 
chown postgres: /var/log/pgsql/14

## su - postgres 

vim ${PGDATA}/postgresql.conf
"
log_destination = 'stderr,csvlog'
log_directory = '/var/log/pgsql/14'
log_filename = 'postgresql-%Y-%m-%d_%H%M%S.log'
log_min_duration_statement = 0
"

psql -Atqc "
SELECT
  DISTINCT context
  FROM pg_settings
  WHERE name IN (
                 'log_destination',
                 'log_directory',
                 'log_filename',
                 'log_min_duration_statement');
"

pg_ctl reload

read -p 'Digite o número da versão majoritária do PostgreSQL: ' PGMAJOR

ls -1 /var/log/pgsql/${PGMAJOR}/

ls -1 /var/log/pgsql/${PGMAJOR}/*.log | tail -1 | xargs -i tail -F {}

ls -1 /var/log/pgsql/${PGMAJOR}/*.csv | tail -1 | xargs -i tail -F {}
