FROM ubuntu:14.04
MAINTAINER Boyan Bonev <b.bonev@redbuffstudio.com>

#Setup container environment parameters
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No

#Configure locale.
RUN locale-gen en_US en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

#Prepare the image
RUN apt-get -y update

#Make our life easy with utilities
RUN apt-get install -y -q python-software-properties software-properties-common bash-completion wget nano \
curl libcurl3 libcurl3-dev build-essential

# Install VCS
RUN apt-get install -y -q git subversion

#Install Ruby 2.1.3 (for sass)
RUN apt-get install -y -q libgdbm-dev libncurses5-dev automake libtool bison libffi-dev
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN \curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.1.3"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

# Install Javasript build toolchain.
RUN curl -sL https://deb.nodesource.com/setup | sudo bash -
RUN apt-get install -y -q nodejs=0.10.33-2nodesource1~trusty1

#Install javascript toolkit.
RUN npm install -g bower
RUN npm install -g grunt-cli
RUN npm install -g gulp

#Install PHP 5.6.2
RUN echo "deb http://ppa.launchpad.net/ondrej/php5-5.6/ubuntu trusty main" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key E5267A6C
RUN apt-get -y update
RUN apt-get install -y -q php5-cli php5-mongo
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

#Fetch wraptodocker for docker nesting
RUN apt-get install -y apparmor
RUN curl -s https://get.docker.io/ubuntu/ | sudo sh
ADD https://raw.githubusercontent.com/jpetazzo/dind/master/wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker


#Install Java
RUN wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jdk-8u25-linux-x64.tar.gz -O /tmp/java8.tar.gz
RUN mkdir -p /opt/oracle
RUN tar zxf /tmp/java8.tar.gz -C /opt/oracle

ENV JAVA_HOME /opt/oracle/jdk1.8.0_25
ENV PATH $PATH:$JAVA_HOME/bin

RUN update-alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 2
RUN update-alternatives --install /usr/bin/javac javac $JAVA_HOME/bin/javac 2

#Fetch Jenkins LTS
ENV JENKINS_VERSION 1.590
ENV JENKINS_HOME /jenkins

RUN mkdir -p /opt/jenkins
RUN wget http://mirrors.jenkins-ci.org/war/$JENKINS_VERSION/jenkins.war -O /opt/jenkins/$JENKINS_VERSION.war
RUN chmod 644 /opt/jenkins/$JENKINS_VERSION.war

#Install fleet
RUN wget https://github.com/coreos/fleet/releases/download/v0.8.3/fleet-v0.8.3-linux-amd64.tar.gz -O /tmp/fleet.tar.gz
RUN tar zxf /tmp/fleet.tar.gz -C /tmp
RUN mv /tmp/fleet-v0.8.3-linux-amd64/fleetctl /usr/local/bin/

#Clean up packages
RUN rm -rf /tmp/java8.tar.gz
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /var/cache/apt/archives/*

#We always launch jenkins.
ENTRYPOINT ["java", "-jar", "/opt/jenkins/1.589.war"]
EXPOSE 8080

CMD [""]