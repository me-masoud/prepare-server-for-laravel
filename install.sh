#!/bin/bash

# Update package lists
sudo apt update

# Install dependencies
sudo apt install -y software-properties-common apt-transport-https ca-certificates gnupg wget

# Add the PHP repository
sudo add-apt-repository ppa:ondrej/php
sudo apt update

# Install PHP 8.2 and necessary extensions
sudo apt install -y php8.2 php8.2-fpm php8.2-mysql php8.2-curl php8.2-gd php8.2-mbstring php8.2-xml php8.2-zip

# Install MySQL
sudo apt install -y mysql-server

# Install Composer
sudo apt install php-cli unzip
cd ~
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
HASH=`curl -sS https://composer.github.io/installer.sig`
php -r "if (hash_file('SHA384', '/tmp/composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Install Nginx
sudo apt install -y nginx

# Install Certbot
sudo add-apt-repository ppa:certbot/certbot
sudo apt update
sudo apt install -y certbot

# Configure Nginx to use PHP-FPM
sudo sed -i '/listen = \/run\/php\/php8.2-fpm.sock/a \
       listen.owner = www-data \
       listen.group = www-data' /etc/php/8.2/fpm/pool.d/www.conf

# Restart services
sudo systemctl restart php8.2-fpm
sudo systemctl restart nginx
