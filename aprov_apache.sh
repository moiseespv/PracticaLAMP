# Primero actualizamos los paquetes e instalamos apache2 y php

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
