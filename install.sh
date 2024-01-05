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
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '55d6ead61b29c7bdee5cccfb50076874187bd9f21f65d8991d46ec5cc90518f447387fb9f76ebae1fbbacf329e583e30') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
sudo mv composer.phar /usr/local/bin/composer

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
