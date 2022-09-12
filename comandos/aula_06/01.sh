export PATH=$PATH:/usr/pgsql-14/bin


# Postgres
read -p \
    'Digite a versão majoritária: ' \
    PGMAJOR

systemctl list-units | fgrep postgres | awk '{print $1}'

systemctl status postgresql-${PGMAJOR}.service

## Root
read -p \
    'Digite a versão majoritária: ' \
    PGMAJOR
    
systemctl disable postgresql-${PGMAJOR}.service

pgrep -a postmaster

systemctl show --property MainPID --value postgresql-${PGMAJOR}.service

pgrep -a postgres | fgrep "${PGDATA}" | awk '{print $1}'

systemctl restart postgresql-${PGMAJOR}.service

systemctl reload postgresql-${PGMAJOR}.service

systemctl stop postgresql-${PGMAJOR}.service

systemctl enable --now postgresql-${PGMAJOR}.service

export PATH=$PATH:/usr/pgsql-14/bin

read -p \
    'Digite a versão majoritária: ' \
    PGMAJOR

pg_ctl -D /var/lib/pgsql/${PGMAJOR}/data status

pg_ctl -D /var/lib/pgsql/${PGMAJOR}/data reload

pg_ctl -D /var/lib/pgsql/${PGMAJOR}/data restart

initdb -D /tmp/data -U postgres

sed -i 's/#port = 5432/port = 5433/g' /tmp/data/postgresql.conf

pg_ctl -D /tmp/data/ start

psql -U postgres -p 5433 -c 'SHOW port;'

pg_ctl -D /tmp/data/ stop && PGDATA='/tmp/data'

pg_ctl start

psql -U postgres -p 5433 -c 'SHOW port;' && pg_ctl stop
