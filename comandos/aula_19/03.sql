CREATE EXTENSION file_fdw;

CREATE SERVER srv_srv1_file_fdw FOREIGN DATA WRAPPER file_fdw;

CREATE FOREIGN TABLE ft_capitais_sudeste(
    id char(2),
    nome VARCHAR(50),
    populacao INT)
    SERVER srv_srv1_file_fdw
    OPTIONS (
             filename '/tmp/capitais_sudeste.csv',
             format 'csv',
             delimiter ';');

SELECT id, nome, populacao FROM ft_capitais_sudeste;

\! sed '1d' -i /tmp/capitais_sudeste.csv
