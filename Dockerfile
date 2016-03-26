FROM ubuntu:14.04
MAINTAINER Ryan Dunn "dunn.shannon@ge.com"


ENV http_proxy http://sjc1intproxy01.crd.ge.com:8080
ENV https_proxy http://sjc1intproxy01.crd.ge.com:8080
ENV no_proxy localhost, 127.0.0.1, *.ge.com
ENV npm_config_proxy http://sjc1intproxy01.crd.ge.com:8080
ENV npm_config_https_proxy http://sjc1intproxy01.crd.ge.com:8080
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y ssh && apt-get clean

RUN mkdir /var/run/sshd
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config


# Configure SSH access
RUN mkdir -p /home/vagrant/.ssh
RUN touch /root/.hushlogin
RUN echo -n 'root:root' | chpasswd


#JVM
RUN mkdir -p /usr/local/java
WORKDIR /usr/local/java
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" -P /usr/local/java/ http://download.oracle.com/otn-pub/java/jdk/7u67-b01/jdk-7u67-linux-x64.tar.gz
RUN tar -zxvf /usr/local/java/jdk-7u67-linux-x64.tar.gz -C /usr/local/java/

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" -P /usr/local/java/ http://download.oracle.com/otn-pub/java/jdk/7u60-b19/jdk-7u60-linux-x64.tar.gz
RUN tar -zxvf jdk-7u60-linux-x64.tar.gz -C /usr/local/java/

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" -P /usr/local/java/ http://download.oracle.com/otn-pub/java/jdk/7u15-b03/jdk-7u15-linux-x64.tar.gz
RUN tar -zxvf jdk-7u15-linux-x64.tar.gz -C /usr/local/java/

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" -P /usr/local/java/ http://download.oracle.com/otn-pub/java/jdk/8u25-b17/jdk-8u25-linux-x64.tar.gz
RUN tar -zxvf jdk-8u25-linux-x64.tar.gz -C /usr/local/java/

RUN apt-get update && apt-get install -y sudo git make ca-certificates curl bzip2 && apt-get clean
RUN apt-get update && apt-get install -y libxslt-dev libxml2-dev && apt-get clean
RUN apt-get update && apt-get install -y maven && apt-get clean
RUN apt-get update && apt-get install -y python-software-properties && apt-get clean
RUN apt-get update && apt-get install -y software-properties-common && apt-get clean

#RUN apt-get update && apt-get install -y libmysqlclient-dev libsqlite3-dev libpq-dev && apt-get clean
#PLAY
RUN apt-get install -y unzip
RUN curl -O http://downloads.typesafe.com/typesafe-activator/1.2.10/typesafe-activator-1.2.10.zip
RUN unzip typesafe-activator-1.2.10.zip -d / && rm typesafe-activator-1.2.10.zip && chmod a+x /activator-1.2.10/activator
RUN echo "export PATH=$PATH:/activator-1.2.10" >> /etc/profile

RUN wget -q http://go-cli.s3-website-us-east-1.amazonaws.com/releases/v6.7.0/cf-cli_amd64.deb && \
    sudo dpkg -i cf-cli_amd64.deb

RUN apt-add-repository ppa:chris-lea/node.js #Failed when it reached this line 12/16
RUN apt-add-repository ppa:groovy-dev/groovy
RUN apt-get update
RUN apt-get install -y groovy
RUN apt-get install -y --force-yes nodejs

RUN npm install --global npm
RUN npm install --global bower
RUN npm install --global grunt
RUN npm install --global karma
RUN npm install --global grunt-cli

##PYTHON INSTALL 
RUN add-apt-repository ppa:fkrull/deadsnakes
RUN apt-get update && apt-get -y install python3.4
RUN curl https://bootstrap.pypa.io/get-pip.py | python3.4
RUN python3.4 -m pip install requests

#RUBY INSTALL
## Ruby-install
#RUN wget -O /tmp/ruby-install-0.4.1.tar.gz https://github.com/postmodern/ruby-install/archive/v0.4.1.tar.gz
#RUN cd /tmp && tar -xzvf ruby-install-0.4.1.tar.gz
#RUN cd /tmp/ruby-install-0.4.1/ && make install

## chruby
#RUN wget -O /tmp/chruby-0.3.8.tar.gz https://github.com/postmodern/chruby/archive/v0.3.8.tar.gz
#RUN cd /tmp && tar -xzvf chruby-0.3.8.tar.gz
#RUN cd /tmp/chruby-0.3.8/ && make install

# RUN ruby-install ruby 2.0.0
#RUN ruby-install ruby 2.0.0-p451
#RUN ruby-install ruby 2.1.2
#RUN echo "ruby-2.0.0-p451" > ~/.ruby-version

#RUN echo '[ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ] || return' >> /etc/profile.d/chruby.sh
#RUN echo 'source /usr/local/share/chruby/chruby.sh' >> /etc/profile.d/chruby.sh
#RUN echo 'chruby ruby' >> /etc/profile.d/default_ruby.sh
#RUN echo "export LD_PRELOAD=/usr/lib/libtcmalloc_minimal.so.4:${LD_PRELOAD}" >> /etc/profile.d/exports.sh

#RUN chruby-exec ruby -- gem install  --no-rdoc --no-ri  bundler
#RUN chruby-exec ruby -- gem install  --no-rdoc --no-ri  bosh_cli
#RUN chruby-exec ruby -- gem install  --no-rdoc --no-ri  bosh_cli_plugin_micro
#RUN chruby-exec ruby -- gem install --no-rdoc --no-ri  bosh_cli_plugin_aws

RUN  git config --global http.sslVerify false


CMD ["/usr/sbin/sshd", "-D", "-e"]
EXPOSE 22
