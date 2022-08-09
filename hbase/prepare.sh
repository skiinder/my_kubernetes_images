#!/bin/bash
WORK_DIR="$(cd $(dirname "$0"); pwd)"
cd "${WORK_DIR}"
set -ex
curl -L "https://dlcdn.apache.org/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-src.tar.gz" | tar zx
cd "hbase-${HBASE_VERSION}"
mvn \
-Dhadoop.profile=${HADOOP_VERSION:0:1}.0 \
-Dhadoop-three.version=${HADOOP_VERSION} \
-DskipTests package \
assembly:single
tar -zxf "hbase-assembly/target/hbase-${HBASE_VERSION}-bin.tar.gz"
curl -L "https://repo.maven.apache.org/maven2/io/juicefs/juicefs-hadoop/${JUICEFS_VERSION}/juicefs-hadoop-${JUICEFS_VERSION}.jar" \
-o "hbase-${HBASE_VERSION}/lib/juicefs-hadoop.jar"
curl -L "https://repo.maven.apache.org/maven2/org/apache/phoenix/phoenix-server-hbase-${HBASE_VERSION:0:3}/${PHOENIX_VERSION}/phoenix-server-hbase-${HBASE_VERSION:0:3}-${PHOENIX_VERSION}.jar" \
-o "hbase-${HBASE_VERSION}/lib/phoenix-server-hbase-${HBASE_VERSION:0:3}-${PHOENIX_VERSION}.jar"
curl -L "https://repo.maven.apache.org/maven2/org/apache/phoenix/phoenix-queryserver-assembly/6.0.0/phoenix-queryserver-assembly-6.0.0.tar.gz" | tar zx
mv "phoenix-queryserver-6.0.0" "hbase-${HBASE_VERSION}/queryserver"
mv "hbase-assembly/target/hbase-${HBASE_VERSION}-bin.tar.gz" "${WORK_DIR}/hbase.tgz"
mv "hbase-${HBASE_VERSION}" "${WORK_DIR}/hbase"
