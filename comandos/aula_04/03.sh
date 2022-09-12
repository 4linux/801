mkdir -m 0700 /var/db_storage

chown postgres: /var/db_storage

su - postgres

mkdir /var/db_storage/ts_{alpha,beta,gamma}

cat << EOF | psql
CREATE TABLESPACE ts_alpha LOCATION '/var/db_storage/ts_alpha';
CREATE TABLESPACE ts_beta LOCATION '/var/db_storage/ts_beta';
CREATE TABLESPACE ts_gamma LOCATION '/var/db_storage/ts_gamma';
EOF

ls -lhd $PGDATA/pg_tblspc/*

psql

