pg_ctl stop

sed "s|\(^#recovery_target_time = .*\)|\1\nrecovery_target_time = '${STATE_0}'|g" \
   -i ${PGDATA}/postgresql.conf

cat ${PGDATA}/postgresql.conf | grep recovery_target_time

## Copiar a configuração para o conf do postgres restaurado.
cp ${PGDATA}/postgresql.conf \
      /var/backups/pgsql/14/data/pitr/postgresql.conf

## Cria o arquivo de recuperação      
touch /var/backups/pgsql/14/data/pitr/recovery.signal

pg_ctl -D /var/backups/pgsql/14/data/pitr start

## Dados restaurados... 
psql -d pagila -qc \
"SELECT first_name||' '||last_name actor FROM actor \
WHERE actor_id > 200;"

pg_ctl -D /var/backups/pgsql/14/data/pitr stop

rsync -av /var/backups/pgsql/14/data/pitr/* ${PGDATA}/

pg_ctl start

psql -d pagila -qc \
"SELECT first_name||' '||last_name actor FROM actor \
WHERE actor_id > 200;"

psql -Atqc 'SELECT pg_is_in_recovery()'

pg_ctl promote

#### Realizar esta configuração para não dar erro nas próximas aulas.
## Remover a linha recovery_target_time
vim ${PGDATA}/postgresql.conf