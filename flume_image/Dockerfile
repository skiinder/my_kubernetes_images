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
    apt install -y bash tini libc6 libpam-modules krb5-user libnss3 iputils-ping curl && \
    rm /bin/sh && \
    ln -sv /bin/bash /bin/sh && \
    curl -L https://dlcdn.apache.org/flume/1.10.0/apache-flume-1.10.0-bin.tar.gz | tar zxC /opt && \
    mv /opt/apache-flume-1.10.0-bin /opt/flume && \
    curl -L https://dlcdn.apache.org/hadoop/common/hadoop-3.3.3/hadoop-3.3.3.tar.gz | tar zxC /opt && \
    mv /opt/hadoop-3.3.3/share/hadoop/client/* /opt/flume/lib && \
    rm -rf /opt/hadoop-3.3.3 && \
    curl -LO https://github.com/juicedata/juicefs/releases/download/v1.0.0-rc3/juicefs-hadoop-1.0.0-rc3.jar && \
    mv juicefs-hadoop-*.jar /opt/flume/lib && \
    rm -rf /var/cache/apt/*

WORKDIR /opt/flume

ENTRYPOINT [ "/usr/bin/tini", "-s", "--", "/opt/flume/bin/flume-ng", "agent", "-n", "agent", "-c", "/opt/flume/conf", "-f", "/opt/flume/conf/flume-conf.properties" ]
