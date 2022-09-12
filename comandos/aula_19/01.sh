echo 'host all all 192.168.56.70/32 scram-sha-256' >> ${PGDATA}/pg_hba.conf

vim ${PGDATA}/postgresql.conf
"
password_encryption = scram-sha-256
"

pg_ctl reload

psql -c "ALTER ROLE postgres ENCRYPTED PASSWORD '123';"
