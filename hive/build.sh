#!/bin/bash
WORK_DIR="$(cd $(dirname "$0"); pwd)"
cd "${WORK_DIR}"
# pull maven
curl -L "https://dlcdn.apache.org/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz" | tar zx
export MAVEN_HOME="${WORK_DIR}/apache-maven-${MVN_VERSION}"

# pull hive source
curl -L "https://dlcdn.apache.org/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-src.tar.gz" | tar zx && \
cd "apache-hive-${HIVE_VERSION}-src" && \
git apply "${WORK_DIR}/spark-3.patch" && \
git apply "${WORK_DIR}/hive-19316.patch" && \

# build hive
"$MAVEN_HOME/bin/mvn" clean package  -Pdist -DskipTests -Dmaven.javadoc.skip=true && \
tar zxf "packaging/target/apache-hive-${HIVE_VERSION}-bin.tar.gz" && \
curl -L "https://repo.maven.apache.org/maven2/mysql/mysql-connector-java/5.1.49/mysql-connector-java-5.1.49.jar" \
     -o "apache-hive-${HIVE_VERSION}-bin/lib/mysql-connector-java.jar" && \
cat pom.xml | grep '<spark.version>'
mv "apache-hive-${HIVE_VERSION}-bin" "${WORK_DIR}/hive" || exit 1
