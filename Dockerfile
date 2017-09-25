FROM dockerfile/java:oracle-java7
MAINTAINER Umberto Rosini, rosini@agid.gov.it

# release di wso2-is su cui è basata la distribuzione spid
ARG RELEASE=5.3.0

# untar della distribuzione spid di wso2-is in /opt/wso2-is
RUN curl https://codeload.github.com/italia/spid-testenv/tar.gz/0.9-beta.1 > /opt/wso2-is-spid.tar.gz && \
    tar xvzf /opt/wso2-is-spid.tar.gz -d /opt && \
    mv /opt/wso2-is-spid.tar.gz /opt/wso2-is && \
    rm -f /opt/wso2-is-spid.tar.gz && \
    chmod +x /opt/wso2-is/bin/wso2server.sh

# install node
RUN curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh && \
    bash nodesource_setup.sh && \
    apt-get install nodejs && \
    apt-get install build-essential

# Porte esposte
EXPOSE 9443 # WSO2-IS
EXPOSE 8080 # Backoffice

# Comando di avvio di wso2-is
CMD ["/opt/wso2-is/bin/wso2server.sh", "start"]
