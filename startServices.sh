#!/bin/bash

#start Services

service ntp start
service ssh start
service postgresql start

#start Ambari Server
ambari-server start 

#If no postgresql is not initialized
#pg_createcluster 9.5 main --start

