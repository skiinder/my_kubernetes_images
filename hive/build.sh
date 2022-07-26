#!/bin/bash
MVN_VERSION='3.6.3'

WORK_DIR="$(cd $(dirname "$0"); pwd)"
cd "${WORK_DIR}"
curl -L "https://dlcdn.apache.org/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz" | tar zx
export MAVEN_HOME="${WORK_DIR}/apache-maven-${MVN_VERSION}"
curl -L "https://dlcdn.apache.org/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-src.tar.gz" | tar zx
cd "apache-hive-${HIVE_VERSION}-src"
curl -L https://github.com/skiinder/hive/commit/394a38dd156c92479cc1a2a84c985b7ffc0afbb2.patch | git apply
curl -L https://github.com/skiinder/hive/commit/782d5fbc04db32345905c64479a76a749747baeb.patch | git apply
"$MAVEN_HOME/bin/mvn" clean package -Pspark.version=${SPARK_VERSION} -Pdist -DskipTests -Dmaven.javadoc.skip=true
tar zxf "packaging/target/apache-hive-${HIVE_VERSION}-bin.tar.gz"
mv "apache-hive-${HIVE_VERSION}-bin" "${WORK_DIR}/hive"
