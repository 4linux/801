pg_basebackup -c fast -X stream -D /var/backups/pgsql/14/data/pitr

psql -d pagila -qc "
INSERT INTO actor (first_name,last_name) VALUES
	('Roberto','Vivar'),
	('Ramón','Bolaños'),
	('Florinda','de las Nieves'),
	('Carlos','Valdez'),
	('María Antonieta','Meza'),
	('Edgar','Villagrán');
"

STATE_0=`date "+%Y-%m-%d %H:%M:%S %Z"`

sleep 7

psql -d pagila -qc 'DELETE FROM actor WHERE actor_id > 200 RETURNING *;'

psql -d pagila -Atqc \
"
SELECT
	first_name||' '||last_name actor
	FROM actor
	WHERE actor_id > 200;
"

psql -qc "SELECT name, setting, context FROM pg_settings
            WHERE name IN ('wal_level',
                   'archive_mode',
                   'archive_command',
                   'restore_command',
                   'archive_cleanup_command');
"
