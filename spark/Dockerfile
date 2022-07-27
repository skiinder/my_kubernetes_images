FROM openjdk:8-jre-slim

USER root
RUN set -ex && \
    sed -i 's/http:\/\/deb.\(.*\)/https:\/\/deb.\1/g' /etc/apt/sources.list && \
    apt-get update && \
    ln -s /lib /lib64 && \
    apt install -y bash tini libc6 libpam-modules krb5-user libnss3 procps iputils-ping curl libsnappy-dev libssl-dev libisal-dev && \
    mkdir -p /opt/spark && \
    mkdir -p /opt/spark/work-dir && \
    touch /opt/spark/RELEASE && \
    rm /bin/sh && \
    ln -sv /bin/bash /bin/sh && \
    echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su && \
    chgrp root /etc/passwd && chmod ug+rw /etc/passwd && \
    rm -rf /var/cache/apt/*

COPY spark/jars /opt/spark/jars
COPY spark/bin /opt/spark/bin
COPY spark/sbin /opt/spark/sbin
COPY spark/kubernetes/dockerfiles/spark/entrypoint.sh /opt/spark/
COPY spark/kubernetes/dockerfiles/spark/decom.sh /opt/spark/
COPY spark/examples /opt/spark/examples
COPY spark/kubernetes/tests /opt/spark/tests
COPY spark/data /opt/spark/data

RUN chmod g+w /opt/spark/work-dir && \
    chmod a+x /opt/spark/decom.sh && \
    chmod a+x /opt/spark/entrypoint.sh

ENV SPARK_HOME /opt/spark

WORKDIR /opt/spark/work-dir

ENTRYPOINT [ "/opt/spark/entrypoint.sh" ]
