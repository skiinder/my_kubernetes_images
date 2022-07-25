FROM registry.cn-zhangjiakou.aliyuncs.com/skiinder/spark-github:3.2.2-hadoop-3.3

RUN curl -L https://archive.apache.org/dist/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz | tar zx && \
    mv hadoop-3.3.1 /opt/hadoop && \
    rm -rf /opt/hadoop/share/doc/* && \
    ln -s /opt/spark/jars/juicefs-hadoop-1.0.0-rc3.jar /opt/hadoop/share/hadoop/common/juicefs-hadoop-1.0.0-rc3.jar && \
    curl -L https://dlcdn.apache.org/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz | tar zx && \
    mv apache-hive-3.1.2-bin /opt/hive && \
    rm -rf /opt/hive/lib/hive-standalone-metastore-3.1.2.jar /opt/hive/lib/hive-spark-client-3.1.2.jar && \
    rm -rf /opt/hadoop/etc/hadoop/core-site.xml && \
    ln -s /opt/hive/conf/core-site.xml /opt/hadoop/etc/hadoop/core-site.xml && \
    mkdir -p /opt/spark/conf && \
    ln -s /opt/hive/conf/spark-defaults.conf /opt/spark/conf/spark-defaults.conf && \
    curl https://repo.maven.apache.org/maven2/mysql/mysql-connector-java/5.1.49/mysql-connector-java-5.1.49.jar -o /opt/hive/lib/mysql-connector-java.jar

COPY jars /opt/hive/lib
COPY entrypoint.sh /opt

RUN chmod +x /opt/entrypoint.sh

ENV HADOOP_HOME=/opt/hadoop
ENV HIVE_HOME=/opt/hive

ENTRYPOINT [ "/opt/entrypoint.sh" ]