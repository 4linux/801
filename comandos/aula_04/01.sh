psql -d postgres -h localhost -U postgres -p 5432

psql -U postgres

psql -d postgres -h localhost -U aluno -p 5432

psql -d postgres -h localhost -U aluno -p 5432 -Atqc 'SELECT 5 + 2;'

psql 'dbname=postgres host=localhost user=aluno port=5432' \
    -Atqc 'SELECT 5 + 2;'

psql -U postgres -Atqc 'SELECT current_database();'

psql -Atqc 'SELECT current_database();'

psql -Atqc 'SELECT current_user;'

echo 'SELECT 9' | psql -Atq

cat << EOF | psql -Atq
SELECT 'foo';
SELECT 'bar';
SELECT 'baz';
EOF

echo "SELECT version();" > /tmp/teste.sql

psql -Atq < /tmp/teste.sql

psql -Atqf /tmp/teste.sql
