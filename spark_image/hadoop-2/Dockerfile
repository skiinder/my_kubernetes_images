ARG java_image_tag=8-jre-slim

FROM openjdk:${java_image_tag}

ARG spark_uid=0

RUN set -ex && \
    sed -i 's/http:/https:/g' /etc/apt/sources.list && \
    apt-get update && \
    ln -s /lib /lib64 && \
    apt install -y bash tini libc6 libpam-modules krb5-user libnss3 && \
	curl -L https://archive.apache.org/dist/spark/spark-3.0.0/spark-3.0.0-bin-hadoop2.7.tgz | tar zx && \
    mkdir -p /opt/spark && \
    mkdir -p /opt/spark/examples && \
    mkdir -p /opt/spark/work-dir && \
    touch /opt/spark/RELEASE && \
    rm /bin/sh && \
    ln -sv /bin/bash /bin/sh && \
    echo "auth required pam_wheel.so use_uid" >> /etc/pam.d/su && \
    chgrp root /etc/passwd && chmod ug+rw /etc/passwd && \
    rm -rf /var/cache/apt/*

COPY spark-3.0.0-bin-hadoop2.7/jars /opt/spark/jars
COPY spark-3.0.0-bin-hadoop2.7/bin /opt/spark/bin
COPY spark-3.0.0-bin-hadoop2.7/sbin /opt/spark/sbin
COPY spark-3.0.0-bin-hadoop2.7/kubernetes/dockerfiles/spark/entrypoint.sh /opt/
COPY spark-3.0.0-bin-hadoop2.7/examples /opt/spark/examples
COPY spark-3.0.0-bin-hadoop2.7/kubernetes/tests /opt/spark/tests
COPY spark-3.0.0-bin-hadoop2.7/data /opt/spark/data

ENV SPARK_HOME /opt/spark

WORKDIR /opt/spark/work-dir
RUN chmod g+w /opt/spark/work-dir

ENTRYPOINT [ "/opt/entrypoint.sh" ]

USER ${spark_uid}
