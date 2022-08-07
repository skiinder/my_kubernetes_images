FROM openjdk:8-jre-slim

USER root
RUN set -ex && \
    sed -i 's/http:\/\/deb.\(.*\)/https:\/\/deb.\1/g' /etc/apt/sources.list && \
    apt-get update && \
    ln -s /lib /lib64 && \
    apt install -y bash tini libc6 libpam-modules krb5-user libnss3 procps iputils-ping curl libsnappy-dev libssl-dev libisal-dev && \
    rm /bin/sh && \
    ln -sv /bin/bash /bin/sh && \
    echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su && \
    chgrp root /etc/passwd && chmod ug+rw /etc/passwd && \
    rm -rf /var/cache/apt/* && \
    mkdir /opt/conf

COPY hbase /opt

RUN set -ex && \
    mv /opt/hbase/conf/hbase-env.sh /opt/conf/hbase-env.sh && \
    ln -s /opt/conf/hbase-env.sh /opt/hbase/conf/hbase-env.sh && \
    mv /opt/hbase/conf/hbase-site.xml /opt/conf/hbase-site.xml && \
    ln -s /opt/conf/hbase-site.xml /opt/hbase/conf/hbase-site.xml

ENV HBASE_HOME /opt/hbase

ENTRYPOINT [ "ping", "www.baidu.com" ]