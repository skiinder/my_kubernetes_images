FROM openjdk:8-jre-slim

USER root
RUN set -ex && \
    sed -i 's/http:\/\/deb.\(.*\)/https:\/\/deb.\1/g' /etc/apt/sources.list && \
    apt-get update && \
    ln -s /lib /lib64 && \
    apt install -y bash tini libc6 libpam-modules libnss3 procps net-tools iputils-ping curl libsnappy-dev libssl-dev libisal-dev python && \
    rm /bin/sh && \
    ln -sv /bin/bash /bin/sh && \
    echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su && \
    chgrp root /etc/passwd && chmod ug+rw /etc/passwd && \
    rm -rf /var/cache/apt/* && \
    mkdir /opt/conf

COPY hbase /opt/hbase
COPY entrypoint.sh /opt/hbase/entrypoint.sh

RUN set -ex && \
    chmod +x /opt/hbase/entrypoint.sh && \
    mv /opt/hbase/conf/hbase-env.sh /opt/conf/hbase-env.sh && \
    ln -s /opt/conf/hbase-env.sh /opt/hbase/conf/hbase-env.sh && \
    mv /opt/hbase/conf/hbase-site.xml /opt/conf/hbase-site.xml && \
    ln -s /opt/conf/hbase-site.xml /opt/hbase/conf/hbase-site.xml && \
    ln -s /opt/conf/core-site.xml /opt/hbase/conf/core-site.xml && \
    ln -s /opt/hbase/lib/juicefs-hadoop.jar /opt/hbase/queryserver/lib/juicefs-hadoop.jar

ENV HBASE_HOME=/opt/hbase

ENV PATH=$PATH:$HBASE_HOME/bin

ENTRYPOINT [ "/opt/hbase/entrypoint.sh" ]
