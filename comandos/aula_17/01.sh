pg_lsclusters

read -p 'Digite a versão majoritária do PostgreSQL: ' PGMAJOR

pg_createcluster ${PGMAJOR} foo -- -k \
    --auth-local=trust \
    --auth-host=scram-sha-256

pg_ctlcluster ${PGMAJOR} foo start

pg_dropcluster --stop ${PGMAJOR} foo

