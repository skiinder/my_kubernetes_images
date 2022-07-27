#!/bin/bash
WORK_DIR="$(cd $(dirname "$0"); pwd)"
cd "${WORK_DIR}"
# pull maven
curl -L "https://dlcdn.apache.org/maven/maven-3/${MVN_VERSION}/binaries/apache-maven-${MVN_VERSION}-bin.tar.gz" | tar zx
export MAVEN_HOME="${WORK_DIR}/apache-maven-${MVN_VERSION}"

# pull hive source
curl -L "https://dlcdn.apache.org/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-src.tar.gz" | tar zx
cd "apache-hive-${HIVE_VERSION}-src"
curl -L https://github.com/skiinder/hive/commit/394a38dd156c92479cc1a2a84c985b7ffc0afbb2.patch | git apply
curl -L https://github.com/skiinder/hive/commit/782d5fbc04db32345905c64479a76a749747baeb.patch | git apply

# build hive
"$MAVEN_HOME/bin/mvn" clean package -Dspark.version=${SPARK_VERSION} -Pdist -DskipTests -Dmaven.javadoc.skip=true
tar zxf "packaging/target/apache-hive-${HIVE_VERSION}-bin.tar.gz"
curl -L "https://repo.maven.apache.org/maven2/mysql/mysql-connector-java/5.1.49/mysql-connector-java-5.1.49.jar" \
     -o "apache-hive-${HIVE_VERSION}-bin/lib/mysql-connector-java.jar"
mv "apache-hive-${HIVE_VERSION}-bin" "${WORK_DIR}/hive"
