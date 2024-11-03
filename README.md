# PracticaLAMP

# En esta práctica vamos a montar una infraestructura con dos servidores, uno con apache y php instalados, y otro con mysql que va a funcionar como una base de datos.
# Para ello he realizado un fichero de aprovisionamiento para cada máquina donde introduzco la configuración pertinente para que estas ejerzan su función correctamente.


# Servidor apache corriendo en la máquina MoisesPintiApache:

![servidor_apache](https://github.com/user-attachments/assets/5ce33159-a4fe-405a-9511-a8a46f672356)


# Servidor mysql corriendo en la máquina MoisesPintiMysql:

![image](https://github.com/user-attachments/assets/589ca2fb-ebb8-427e-bebb-c468bb598d77)


# Script de aprovisionamiento apache:

[Uploading# Primero actualizamos los paquetes e instalamos apache2 y php

sudo apt update
sudo apt install apache2 -y
sudo apt install php libapache2-mod-php php-mysql -y

# Después copiamos el fichero 000-default.conf en uno creado por nosotros llamado apache.conf

sudo cat /etc/apache2/sites-available/000-default.conf | sudo sed "s/\/var\/www\/html/\/var\/www\/html\/src\//" > /etc/apache2/sites-available/apache.conf

# Clonamos el enlace de la practica de GitHub en nuestro directorio

sudo git clone https://github.com/josejuansanchez/iaw-practica-lamp.git /home/vagrant/iaw-practica-lamp

# Movemos el directorio src dentro de la practica de GitHub a nuestro directorio html

sudo mv /home/vagrant/iaw-practica-lamp/src/ /var/www/html/

# En el config.php creamos la base de datos con su usuario y contraseña y lo llevamos al html

cat /var/www/html/src/config.php|sed "s/localhost/192.168.56.3/"|sed "s/database_name_here/lamp_db/"|sed "s/username_here/moises/"|sed "s/password_here/1234/" > /var/www/html/src/config.php

# Deshabilitamos el 000-default.conf y habilitamos nuestro fichero apache.conf ya configurado

sudo a2dissite 000-default.conf
sudo a2ensite apache.conf
sudo systemctl restart apache2
 aprov_apache.sh…]()

# Script de aprovisionamiento Mysql:

[Uploading #Actualizamos los repositorios e instalamos mysql-server y las net-tools

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

sudo systemctl restart mysqlaprov_mysql.sh…]()







