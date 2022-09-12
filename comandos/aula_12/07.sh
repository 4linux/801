mkdir ${PGDATA}/conf.d

cat << EOF > ${PGDATA}/conf.d/pg_stat_statements.conf
# pg_stat_statements Settings
pg_stat_statements.max = 10000
pg_stat_statements.track = all
pg_stat_statements.track_utility = on
pg_stat_statements.track_planning = off
pg_stat_statements.save = on
EOF

vim ${PGDATA}/postgresql.conf

"
shared_preload_libraries = 'pg_stat_statements'
include_dir = 'conf.d'
"

read -p \
    'Digite a versão majoritária: ' \
    PGMAJOR

systemctl restart postgresql-${PGMAJOR}

createdb db_bench

psql -Atqc 'CREATE EXTENSION pg_stat_statements;' db_bench

psql -Atqc 'SELECT pg_stat_statements_reset();' db_bench

pgbench -i db_bench

pgbench -c10 -t300 db_bench

psql -d db_bench -qc "
SELECT
    query,
    calls,
    total_exec_time,
    rows, 100.0 * shared_blks_hit /
    nullif(shared_blks_hit + shared_blks_read, 0) AS hit_percent
    FROM pg_stat_statements
    ORDER BY total_exec_time DESC LIMIT 5;
"

dropdb db_bench
