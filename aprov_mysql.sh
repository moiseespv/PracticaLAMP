#Actualizamos los repositorios e instalamos mysql-server y las net-tools

sudo apt-get update
sudo apt-get install -y mysql-server
sudo apt-get install net-tools

# Activamos el servicio mysql y lo iniciamos

sudo systemctl enable mysql
sudo systemctl start mysql

# Clonamos la práctica de GitHub

git clone https://github.com/josejuansanchez/iaw-practica-lamp.git 

# Como usuario root, entramos en la base de datos, creamos un usuario con su contraseña y le atribuimos todos los privilegios

sudo mysql -u root < iaw-practica-lamp/db/database.sql

mysql -u root  <<EOF
CREATE USER 'moises'@'192.168.56.2' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON lamp_db.* TO 'moises'@'192.168.56.2';
FLUSH PRIVILEGES;
EOF

# Dentro del fichero mysqld.cnf cambiamos el bind-address de 0.0.0.0 a la ip de la máquina 

sudo sed -i "s/^bind-address[[:space:]]*=.*/bind-address = 192.168.56.3/" /etc/mysql/mysql.conf.d/mysqld.cnf

#Reiniciamos el servicio mysql para que se guarden todos los cambios

sudo systemctl restart mysql