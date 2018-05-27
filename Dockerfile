# OS
FROM ubuntu:16.04

# Hostname Help
ENV HOSTNAME node.monocluster.com
ADD set_host.sh /tmp/
ADD startServices.sh /tmp/
RUN chmod 777 /tmp/startServices.sh
#RUN sh /tmp/set_host.sh

# Download and install packages
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
apt-get -qq -y install apt-utils && \
apt-get -qq -y install wget && \
apt-get -qq -y install vim && \
apt-get -qq -y install ssh && \
apt-get -qq -y install openssh-client && \
apt-get -qq -y install curl && \
apt-get -qq -y install unzip && \
apt-get -qq -y install tar && \
apt-get -qq -y install openssl && \
apt-get -qq -y install sudo && \
apt-get -qq -y install ntp && \
apt-get install -qq -y iputils-ping && \
apt-get install -qq -y libmysql-java && \
apt-get install -qq -y libpostgresql-jdbc-java


# MySQL
ENV MYSQL_PWD kylo
RUN echo "mysql-server mysql-server/root_password password $MYSQL_PWD" | debconf-set-selections
RUN echo "mysql-server mysql-server/root_password_again password $MYSQL_PWD" | debconf-set-selections
RUN apt-get -y install mysql-server


#check/update services
RUN update-rc.d ntp defaults && \
service ntp start && \
service ssh start



RUN wget -O /etc/apt/sources.list.d/ambari.list http://public-repo-1.hortonworks.com/ambari/ubuntu16/2.x/updates/2.6.1.5/ambari.list && \
apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD && \
apt-get -qq update



#Setup password less ssh
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -P "" && \
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
chmod 600 ~/.ssh/authorized_keys
#RUN ssh -T -o "StrictHostKeyChecking no" root@localhost

# Install Ambari server
RUN apt-get -y install ambari-server && \
ambari-server setup -s --enable-lzo-under-gpl-license

# Setup env
ENV JAVA_HOME /usr/jdk64/jdk1.8.0_112
ENV PATH $JAVA_HOME/bin:$PATH
WORKDIR /tmp

# External resources exposure
VOLUME /var/log
EXPOSE 8080

ENTRYPOINT ["/tmp/startServices.sh"] 
#CMD ["ambari-server start"]