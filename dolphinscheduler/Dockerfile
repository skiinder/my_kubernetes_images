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
    apt install -y bash tini libc6 libpam-modules libnss3 iputils-ping curl python3 python3-pip && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    pip install pyyaml && \
    rm /bin/sh && \
    ln -sv /bin/bash /bin/sh && \
    rm -rf /var/cache/apt/* && \
    curl -L https://dlcdn.apache.org/dolphinscheduler/2.0.6/apache-dolphinscheduler-2.0.6-bin.tar.gz | tar -zxC /opt && \
    mv /opt/apache-dolphinscheduler-2.0.6-bin /opt/dolphinscheduler && \
    find /root/build/dolphinscheduler | grep 'sh$' | sed -i '/^ *source/s/^/#/' && \
	cd /usr/bin && \
    curl -LO "https://dl.k8s.io/release/v1.23.7/bin/linux/amd64/kubectl" && \
    cd /opt/dolphinscheduler/lib && \
	curl -LO https://github.com/juicedata/juicefs/releases/download/v1.0.0-rc3/juicefs-hadoop-1.0.0-rc3.jar

COPY dolphinscheduler /opt/dolphinscheduler

RUN chmod +x /opt/dolphinscheduler/entrypoint.sh /opt/dolphinscheduler/install.sh

WORKDIR /opt/dolphinscheduler

ENTRYPOINT [ "./entrypoint.sh" ]
