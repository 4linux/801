CREATE USER 'postgres'@'192.168.56.70' IDENTIFIED BY '123';

GRANT ALL PRIVILEGES ON db_teste2.* TO 'postgres'@'192.168.56.70';

CREATE TABLE tb_teste(
  id INT AUTO_INCREMENT PRIMARY KEY,
  campo_a INT,
  campo_b VARCHAR(10));

INSERT INTO tb_teste (campo_a, campo_b) VALUES (700, 'foo');

CREATE EXTENSION mysql_fdw;

CREATE SERVER srv_mysql
  FOREIGN DATA WRAPPER mysql_fdw
  OPTIONS (host '192.168.56.71', port '3306');

CREATE USER MAPPING FOR postgres SERVER srv_mysql
  OPTIONS (username 'postgres', password '123');

CREATE FOREIGN TABLE ft_teste(
  id INT,
  campo_a INT,
  campo_b VARCHAR(10))
  SERVER srv_mysql
  OPTIONS (dbname 'db_teste2', table_name 'tb_teste');

INSERT INTO ft_teste (id, campo_a, campo_b) VALUES (2, 500, 'bar');

SELECT * FROM ft_teste;

SELECT * FROM tb_teste;
