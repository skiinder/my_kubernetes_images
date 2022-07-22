FROM openjdk:8-jre-slim

USER root

RUN set -ex && \
    # echo 'deb http://mirrors.aliyun.com/debian/ bullseye main non-free contrib' > /etc/apt/sources.list && \
    # echo 'deb-src http://mirrors.aliyun.com/debian/ bullseye main non-free contrib' >> /etc/apt/sources.list && \
    # echo 'deb http://mirrors.aliyun.com/debian-security/ bullseye-security main' >> /etc/apt/sources.list && \
    # echo 'deb-src http://mirrors.aliyun.com/debian-security/ bullseye-security main' >> /etc/apt/sources.list && \
    # echo 'deb http://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib' >> /etc/apt/sources.list && \
    # echo 'deb-src http://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib' >> /etc/apt/sources.list && \
    # echo 'deb http://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib' >> /etc/apt/sources.list && \
    # echo 'deb-src http://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib' >> /etc/apt/sources.list && \
    apt-get update && \
    ln -s /lib /lib64 && \
    apt install -y bash tini libc6 libpam-modules libnss3 iputils-ping curl && \
    rm /bin/sh && \
    ln -sv /bin/bash /bin/sh && \
    curl -LO https://github.com/zendesk/maxwell/releases/download/v1.29.2/maxwell-1.29.2.tar.gz && \
    tar -zxf maxwell-1.29.2.tar.gz -C /opt && \
    rm -rf maxwell-1.29.2.tar.gz && \
    mv /opt/maxwell-1.29.2 /opt/maxwell && \
    rm -rf /opt/maxwell/lib/kafka-clients/kafka-clients-0* && \
    rm -rf /opt/maxwell/lib/maxwell-1.29.2.jar /opt/maxwell/lib/snappy-java-1.1.1.7.jar /opt/maxwell/lib/snappy-java-1.1.2.6.jar && \
    rm -rf /var/cache/apt/*

COPY maxwell-1.29.2.jar /opt/maxwell/lib

WORKDIR /opt/maxwell

ENTRYPOINT [ "/usr/bin/tini", "-s", "--", "/opt/maxwell/bin/maxwell", "--config", "/opt/maxwell/conf/config.properties" ]
