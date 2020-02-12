# DockerAmbari

docker run -i -t -h node.monocluster.com -p 2181:2181 -p 9092:9092 -p 8080:8080 --name amb1 --entrypoint /bin/bash kumarsumit1/dockerambari 

docker run -i -t -h node.monocluster.com -p 2181:2181 -p 9092:9092 -p 8080:8080 --name amb kumarsumit1/dockerambari

docker run -i -t --network=host ubuntu:16.04 /bin/bash


docker run -i -t --network=host ubuntu:16.04 /bin/bash


docker exec -it --privileged=true ubuntu:16.04 /bin/bash

docker exec -it --privileged=true amb1 /bin/bash



To use the default PostgreSQL database, named ambari, with the default username and password (ambari/bigdata)


apt-get install libpostgresql-jdbc-java

ambari-server setup --jdbc-db=postgres --jdbc-driver=/usr/share/java/postgresql.jar



psql -U ambari -h 127.0.0.1 ambari