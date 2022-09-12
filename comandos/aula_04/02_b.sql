CREATE DATABASE db_one TEMPLATE db1;

\c db_one user_test1

\dt

\c postgres user_test2

CREATE DATABASE db_two TEMPLATE db1;

\c postgres user_test1

ALTER DATABASE db1 IS_TEMPLATE TRUE;

\c postgres user_test2

CREATE DATABASE db_two TEMPLATE db1;

\c postgres user_test1

DROP DATABASE db1;

ALTER DATABASE db1 IS_TEMPLATE FALSE;

DROP DATABASE db1;
