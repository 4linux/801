mysql -e 'CREATE DATABASE db_teste2;'

mysql db_teste2

PKG='make gcc libmariadb-dev git'

apt install -y ${PKG} && apt clean

git clone https://github.com/EnterpriseDB/mysql_fdw.git /tmp/mysql_fdw && \
cd /tmp/mysql_fdw

source ~postgres/.pgvars

export C_INCLUDE_PATH="${C_INCLUDE_PATH}:/usr/include/mariadb"

export USE_PGXS=1 && make && make install

apt purge -y ${PKG}

apt install -y libmariadb-dev-compat && apt clean

createdb db_teste1

psql db_teste1
