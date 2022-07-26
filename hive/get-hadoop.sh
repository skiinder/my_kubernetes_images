#!/bin/bas
WORK_DIR="$(cd $(dirname "$0"); pwd)"
cd "${WORK_DIR}"
curl -L "https://dlcdn.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz" | tar zx
rm -rf "hadoop-${HADOOP_VERSION}/share/doc"
mv "hadoop-${HADOOP_VERSION}" "${WORK_DIR}/hadoop"
