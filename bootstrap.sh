#!/usr/bin/env bash

# update package repo
apt-get update

# install collectd
apt-get install -y collectd
service collectd stop
rm -f /etc/collectd/collectd.conf
ln -sf /vagrant/collectd.conf /etc/collectd/collectd.conf
service collectd start

# install Apache
apt-get install -y apache2
rm -rf /var/www
mkdir /var/www
chown www-data.www-data /var/www

# install Java 8
cd /tmp
wget -q --no-check-certificate https://github.com/aglover/ubuntu-equip/raw/master/equip_java8.sh && bash equip_java8.sh

# install Elasticsearch
cd /opt
tar zxf /vagrant/elasticsearch-1.2.0.tar.gz
ln -sf elasticsearch-1.2.0 elasticsearch

# install Marvel
/opt/elasticsearch/bin/plugin -i elasticsearch/marvel/latest

# install Kibana
cd /var/www
tar zxf /vagrant/kibana-3.0.1.tar.gz
mv kibana-3.0.1/* .
rmdir kibana-3.0.1

# install Logstash
cd /opt
tar zxf /vagrant/logstash-1.4.1.tar.gz
ln -sf logstash-1.4.1 logstash

# fix permissions
cd /opt
chown -R vagrant.vagrant logstash* elasticsearch*

# startup
su - vagrant -c /vagrant/start.sh
