FROM openjdk:8-jre-slim

USER root

RUN set -ex && \
    sed -i 's/http:\/\/deb.\(.*\)/https:\/\/deb.\1/g' /etc/apt/sources.list && \
    apt-get update && \
    ln -s /lib /lib64 && \
    apt install -y bash tini libc6 libpam-modules krb5-user libnss3 procps iputils-ping curl libsnappy-dev libssl-dev libisal-dev python3 python3-pip && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    pip install pyyaml && \
    rm /bin/sh && \
    ln -sv /bin/bash /bin/sh && \
    rm -rf /var/cache/apt/* && \
    curl -L "https://dl.k8s.io/release/v1.23.7/bin/linux/amd64/kubectl" -o /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl

COPY dolphinscheduler /opt/dolphinscheduler

RUN chmod +x /opt/dolphinscheduler/entrypoint.sh /opt/dolphinscheduler/install.sh

WORKDIR /opt/dolphinscheduler

ENTRYPOINT [ "/opt/dolphinscheduler/entrypoint.sh" ]
