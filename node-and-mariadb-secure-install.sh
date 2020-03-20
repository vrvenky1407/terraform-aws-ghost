MYSQL_ROOT_PASSWORD='mysqlroot123'

curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt install -y nodejs
node -v
npm -v

# Install MariaDB

sudo apt update -y
sudo apt  install -y mariadb-server mariadb-client
sudo systemctl enable mariadb
sudo systemctl status mariadb

sudo mysql --user=root <<_EOF_
update mysql.user set authentication_string = PASSWORD('$MYSQL_ROOT_PASSWORD') where user='root';
update mysql.user set plugin = 'mysql_native_password' where user = 'root';
delete from mysql.user where user='';
delete from mysql.user where user='root' and Host NOT IN ('localhost', '127.0.0.1', '::1');
drop database if exists test;
delete from mysql.db where Db='test' OR Db='test\\_%';
flush privileges;

create database ghost;
grant all privileges on ghost.* to ghost@localhost identified by 'ghost1234';
flush privileges;

_EOF_

