#!/bin/bash

#start Ambari Server
CLUSTER='hdp-ambari'
HOST='node.monocluster.com'
AMBARI_HOST=$HOST
USER='admin'
PASSWORD='admin'


#start Services

service ntp start
service ssh start
service postgresql start
service mysql start

ambari-server setup --jdbc-db=mysql --jdbc-driver=/usr/share/java/mysql.jar

mysql -uroot -pkylo -e 'CREATE USER `hive`@`localhost` IDENTIFIED BY `kylo`; GRANT ALL PRIVILEGES ON *.* TO `hive`@`localhost`; CREATE USER `hive`@`%` IDENTIFIED BY `kylo`;GRANT ALL PRIVILEGES ON *.* TO `hive`@`%`; CREATE USER `hive`@`node.monocluster.com` IDENTIFIED BY `kylo`; GRANT ALL PRIVILEGES ON *.* TO `hive`@`node.monocluster.com`; FLUSH PRIVILEGES; CREATE DATABASE hive;'



#while [ -z "$(ss -ltunp | grep 8080)" ]; do
#  ambari-server start -v
  #ambari-agent start
#  sleep 20
#done

ambari-server start -v

#If no postgresql is not initialized
#pg_createcluster 9.5 main --start

