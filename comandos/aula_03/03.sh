read -p 'Digite o endereço do Servidor PostgreSQL: ' PGSERVER

if [ ! -e ~/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa;
fi

ssh-copy-id root@${PGSERVER}
