#!/bin/bash
WORK_DIR="$(cd $(dirname "$0"); pwd)"
cd "${WORK_DIR}"
curl -L "https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}.tgz" | tar zx
cd "spark-${SPARK_VERSION}"
export MAVEN_OPTS="${MAVEN_OPTS} -Xss256m"
./dev/make-distribution.sh --tgz -Pkubernetes -Dhadoop.version=${HADOOP_VERSION} -DskipTests
tar -zxf "spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz"
curl -L "https://repo.maven.apache.org/maven2/io/juicefs/juicefs-hadoop/${JUICEFS_VERSION}/juicefs-hadoop-${JUICEFS_VERSION}.jar" -o "spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}/jars/juicefs-hadoop.jar" && \
mv "spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}" "${WORK_DIR}/spark"
