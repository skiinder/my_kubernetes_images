FROM openjdk:8-jre-buster
RUN set -ex && \
    sed -i 's/http:\/\/deb.\(.*\)/https:\/\/deb.\1/g' /etc/apt/sources.list && \
    apt-get update && \
    ln -s /lib /lib64 && \
    apt install -y bash tini libc6 libpam-modules krb5-user libnss3 procps iputils-ping curl libsnappy-dev libssl-dev python python-mysqldb && \
    rm /bin/sh && \
    ln -sv /bin/bash /bin/sh && \
    rm -rf /var/cache/apt/* && \
    curl -L https://datax-opensource.oss-cn-hangzhou.aliyuncs.com/20220530/datax.tar.gz | tar -zxC /opt && \
    cd /opt/datax && \
    curl -L https://raw.githubusercontent.com/skiinder/my_kubernetes_images/main/scripts/filededup.sh | bash -

ENV DATAX_HOME=/opt/datax

WORKDIR /opt/datax

ENTRYPOINT [ "/opt/datax/bin/datax.py", "/opt/datax/job/job.json" ]
