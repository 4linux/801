dropdb --if-exists db_bench

createdb db_bench

pgbench -i db_bench

pgbench -c 50 -t 100 db_bench
