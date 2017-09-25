FROM dockerfile/java:oracle-java7
MAINTAINER Umberto Rosini, rosini@agid.gov.it

# release di wso2-is su cui è basata la distribuzione spid
ARG RELEASE=5.3.0

# untar della distribuzione spid di wso2-is in /opt/wso2-is
RUN curl https://github.com/italia/spid-testenv/archive/0.9-beta.1.tar.gz > /opt/wso2-is-$RELEASE-spid.tar.gz && \
    tar xvzf /opt/wso2-is-$RELEASE-spid.tar.gz -d /opt && \
    mv /opt/wso2-is-$RELEASE-spid.tar.gz /opt/wso2-is && \
    rm -f /opt/wso2-is-$RELEASE-spid.tar.gz && \
    chmod +x /opt/wso2-is/bin/wso2server.sh

# Porta esposta https://docs.wso2.com/display/IS530/Default+Ports+of+WSO2+Products
EXPOSE 9443

# Comando di avvio di wso2-is
CMD ["/opt/wso2-is/bin/wso2server.sh", "start"]
