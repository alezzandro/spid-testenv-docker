FROM ubuntu:16.04
MAINTAINER Umberto Rosini, rosini@agid.gov.it

RUN apt-get update

# Oracle Java 8
RUN apt-get install -y software-properties-common python-software-properties && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get install -y oracle-java8-installer && \
    apt-get install oracle-java8-set-default && \
    rm -rf /var/cache/oracle-jdk8-installer

ENV JAVA_HOME="/usr/lib/jvm/java-8-oracle"

# Node 6
RUN apt-get install -y curl && \
    curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && \
    apt-get install -y nodejs && \
    apt-get install -y build-essential

# untar wso2-is in /opt/wso2-is
RUN curl https://codeload.github.com/italia/spid-testenv/tar.gz/0.9-beta.1 > /opt/wso2-is-spid.tar.gz && \
    tar xvzf /opt/wso2-is-spid.tar.gz -d /opt && \
    mv /opt/wso2-is-spid.tar.gz /opt/wso2-is && \
    rm -f /opt/wso2-is-spid.tar.gz && \
    chmod +x /opt/wso2-is/bin/wso2server.sh

# Ports
EXPOSE 9443 # WSO2-IS
EXPOSE 8080 # Backoffice

# wso2-is command
CMD ["/opt/wso2-is/bin/wso2server.sh", "start"]
