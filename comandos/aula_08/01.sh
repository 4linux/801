pgrep -a postgres

vim ${PGDATA}/postgresql.conf

"
wal_level = replica
"

psql -Atqc "SELECT context FROM pg_settings WHERE name = 'wal_level';"

pg_ctl restart

while :; do
clear
# Utilizando regex para arquivos
# com 24 caracteres hexadecimais
ls -1 ${PGDATA}/pg_wal | \
awk '/^[0-9,A-F]+$/ {if (length($1) == 24) {print $1} }'
sleep 3;
done

psql -qc "SELECT generate_series(1, 70000000) AS campo1 \
INTO tb_teste_checkpoint;"

QTD_WAL=`ls -1 ${PGDATA}/pg_wal | \
awk '/^[0-9,A-F]+$/ {if (length($1) == 24) {print $1} }' | wc -l`

echo ${QTD_WAL}

psql -Atqc 'SHOW max_wal_size;'

echo $((${QTD_WAL} * 16))

psql -qc "
SELECT
    name, setting, context, enumvals
    FROM pg_settings
    WHERE name IN (
                    'fsync',
                    'full_page_writes',
                    'synchronous_commit',
                    'wal_level',
                    'wal_sync_method',
                    'wal_writer_delay');
"
