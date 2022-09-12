ls -lh ${PGDATA}/base/

ls $PGDATA/base/<id da base de dados>

ls $PGDATA/base/`psql -Aqtc \
"SELECT oid FROM pg_database WHERE datname = 'postgres';"`
