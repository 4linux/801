PKG='gcc make pkg-config'

PKG_DEB='libsystemd-dev libevent-dev libssl-dev'

apt update && apt install -y wget ${PKG} ${PKG_DEB} && apt clean

useradd \
    -c 'PgBouncer system user' \
    -s /usr/sbin/nologin \
    -d /var/local/pgbouncer \
    -g postgres \
    -m -r pgbouncer  &> /dev/null

ln -s ~pgbouncer /etc/

read -p \
    'Número de versão completo (X.Y.Z) do PgBouncer a ser baixado: ' \
    VERSION

URL="http://www.pgbouncer.org/downloads/files/\
${VERSION}/pgbouncer-${VERSION}.tar.gz"

wget ${URL} -P /tmp/

cd /tmp

tar xvf pgbouncer-${VERSION}.tar.gz

cd pgbouncer-${VERSION}

./configure \
  --prefix /usr/local/pgbouncer \
  --with-pam \
  --with-systemd \
  --with-openssl

make && make install

touch /etc/pgbouncer/{userlist.txt,pgbouncer.ini}
