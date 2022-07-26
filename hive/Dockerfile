FROM registry.cn-zhangjiakou.aliyuncs.com/skiinder/spark-github:3.3.0-hadoop-3.3.2

COPY hadoop /opt/hadoop
COPY hive /opt/hive
COPY entrypoint.sh /opt/hive/

RUN curl -L https://repo.maven.apache.org/maven2/mysql/mysql-connector-java/5.1.49/mysql-connector-java-5.1.49.jar -o /opt/hive/lib/mysql-connector-java.jar && \
    ln -s /opt/spark/jars/juicefs-hadoop.jar /opt/hadoop/share/hadoop/common/juicefs-hadoop.jar && \
    rm -rf /opt/hadoop/etc/hadoop/core-site.xml && \
    ln -s /opt/hive/conf/core-site.xml /opt/hadoop/etc/hadoop/core-site.xml && \
    mkdir -p /opt/spark/conf && \
    ln -s /opt/hive/conf/spark-defaults.conf /opt/spark/conf/spark-defaults.conf && \
    chmod +x /opt/hive/entrypoint.sh

ENV HADOOP_HOME=/opt/hadoop
ENV HIVE_HOME=/opt/hive

WORKDIR /opt/hive

ENTRYPOINT [ "/opt/hive/entrypoint.sh" ]