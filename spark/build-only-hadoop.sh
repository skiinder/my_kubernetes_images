#!/bin/bash
WORK_DIR="$(cd $(dirname "$0"); pwd)"
cd "${WORK_DIR}"
curl -L "https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}.tgz" | tar zx
cd "spark-${SPARK_VERSION}"
export MAVEN_OPTS="${MAVEN_OPTS} -Xss256m"
./dev/make-distribution.sh --tgz -Pkubernetes -Dhadoop.version=${HADOOP_VERSION} -DskipTests
tar -zxf "spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}.tgz"
mv "spark-${SPARK_VERSION}-bin-${HADOOP_VERSION}" "${WORK_DIR}/spark"
