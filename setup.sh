#!/bin/bash
# Instal php5.6 with phpbrew on ubuntu 18.04

# Install all dependencies
sudo apt update
sudo apt install wget php build-essential libxml2-dev libxslt1-dev libbz2-dev libcurl4-openssl-dev libmcrypt-dev libreadline-dev libssl-dev autoconf apache2-dev

wget https://github.com/phpbrew/phpbrew/raw/master/phpbrew
chmod +x phpbrew
mv phpbrew /usr/local/bin

phpbrew init

source ~/.phpbrew/bashrc

# because of this bug https://github.com/phpbrew/phpbrew/issues/861
# we need to do this
sudo ln -s /usr/include/x86_64-linux-gnu/curl /usr/include/curl

# download openssl
wget https://www.openssl.org/source/openssl-1.0.2o.tar.gz

tar -xzvf openssl-1.0.2o.tar.gz
pushd openssl-1.0.2o

# we will install it in /usr/local/openssl so it don't interfere with openssl from apt
# we will compile it as dynamic library
./config -fPIC shared --prefix=/usr/local --openssldir=/usr/local/openssl

# classic make
make

# test it
make test

# install
sudo make install

popd

# reset permission
sudo chmod oga+rw -R /etc/apache2 /usr/sbin/a2enmod /usr/lib/apache2/modules/ /var/lib/apache2/module/

# build php with shared openssl dependency
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
# this command doesn't work
# phpbrew -d install php-5.6.38 +default +openssl=shared
# to install default extensions and apxs2 and openssl and xdebug, we have to use the following command
phpbrew -d install php-5.6.38 +default +pdo +mysql +apxs2 -- --with-openssl=shared
phpbrew use php-5.6.38
phpbrew -d ext install openssl 
phpbrew -d ext install xdebug 2.2.7

# phpbrew -d install php-7.2.10 +default +openssl=shared
# to install default extensions and apxs2 and openssl and xdebug, we have to use the following command
phpbrew -d install php-7.2.10 +default +pdo +mysql +apxs2 -- --with-openssl=shared
phpbrew use php-7.2.10
phpbrew -d ext install openssl
phpbrew -d ext install xdebug

# confirmation
php -m | grep openssl
php -r "echo OPENSSL_VERSION_NUMBER;"

# restore permissions
sudo find /etc/apache2 /usr/lib/apache2/modules /var/lib/apache2/module/ -type f -exec chmod 644 {} \;
sudo find /etc/apache2 /usr/lib/apache2/modules /var/lib/apache2/module/ /usr/sbin/a2enmod -type d -exec chmod 755 {} \;
