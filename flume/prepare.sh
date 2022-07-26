#!/bin/bas
WORK_DIR="$(cd $(dirname "$0"); pwd)"
cd "${WORK_DIR}"
curl -L "https://dlcdn.apache.org/flume/${FLUME_VERSION}/apache-flume-${FLUME_VERSION}-bin.tar.gz" | tar zx
curl -L "https://repo.maven.apache.org/maven2/org/apache/hadoop/hadoop-client-api/${HADOOP_VERSION}/hadoop-client-api-${HADOOP_VERSION}.jar" -o "apache-flume-${FLUME_VERSION}-bin/lib/hadoop-client-api.jar" && \
curl -L "https://repo.maven.apache.org/maven2/org/apache/hadoop/hadoop-client-runtime/${HADOOP_VERSION}/hadoop-client-runtime-${HADOOP_VERSION}.jar" -o "apache-flume-${FLUME_VERSION}-bin/lib/hadoop-client-runtime.jar" && \
curl -L "https://repo.maven.apache.org/maven2/io/juicefs/juicefs-hadoop/${JUICEFS_VERSION}/juicefs-hadoop-${JUICEFS_VERSION}.jar" -o "apache-flume-${FLUME_VERSION}-bin/lib/juicefs-hadoop.jar" && \

mv "apache-flume-${FLUME_VERSION}-bin" "${WORK_DIR}/flume"
