psql -qc "
SELECT
    name, setting, context
    FROM pg_settings
    WHERE name IN (
                   'wal_level',
                   'archive_mode',
                   'archive_command',
                   'restore_command',
                   'archive_cleanup_command');
"

read -p 'Digite a versão majoritária: ' PGMAJOR

vim ${PGDATA}/postgresql.conf
"
wal_level = replica
archive_mode = on
archive_command = 'rsync -a %p /var/backups/pgsql/14/wal/%f'
archive_cleanup_command = 'pg_archivecleanup /var/backups/pgsql/14/wal %r'
restore_command = 'rsync -a /var/backups/pgsql/14/wal/%f %p'
"

pg_ctl restart

NOW=`date +%Y%m%d-%H%M`

echo ${NOW}
