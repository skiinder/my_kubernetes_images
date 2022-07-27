FROM openjdk:8-jre-slim

USER root

RUN set -ex && \
    sed -i 's/http:\/\/deb.\(.*\)/https:\/\/deb.\1/g' /etc/apt/sources.list && \
    apt-get update && \
    ln -s /lib /lib64 && \
    apt install -y bash tini libc6 libpam-modules krb5-user libnss3 procps iputils-ping curl libsnappy-dev libssl-dev libisal-dev && \
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
