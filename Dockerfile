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
RUN apt-get update
RUN apt-get -qq -y install apt-utils
RUN apt-get -qq -y install wget
RUN apt-get -qq -y install vim  
RUN apt-get -qq -y install ssh
RUN apt-get -qq -y install openssh-client
RUN apt-get -qq -y install curl
RUN apt-get -qq -y install unzip
RUN apt-get -qq -y install tar
RUN apt-get -qq -y install openssl
RUN apt-get -qq -y install sudo
RUN apt-get -qq -y install ntp

#check/update services
RUN update-rc.d ntp defaults
RUN service ntp start
RUN service ssh start



RUN wget -O /etc/apt/sources.list.d/ambari.list http://public-repo-1.hortonworks.com/ambari/ubuntu16/2.x/updates/2.6.1.5/ambari.list && apt-key adv --recv-keys --keyserver keyserver.ubuntu.com B9733A7A07513CAD

RUN apt-get -qq update



#Setup password less ssh
RUN ssh-keygen -t rsa -f ~/.ssh/id_rsa -q -P ""
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN chmod 600 ~/.ssh/authorized_keys
RUN ssh -o "StrictHostKeyChecking no" root@localhost

# Install Ambari server
RUN apt-get -y install ambari-server
#RUN ambari-server setup -s --enable-lzo-under-gpl-license

# Setup env
ENV JAVA_HOME /usr/jdk64/jdk1.8.0_112
ENV PATH $JAVA_HOME/bin:$PATH
WORKDIR /tmp

# External resources exposure
VOLUME /var/log
EXPOSE 8080

ENTRYPOINT ["/tmp/startServices.sh"] 
#CMD ["ambari-server start"]