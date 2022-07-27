#!/bin/bash
WORK_DIR="$(cd $(dirname "$0"); pwd)"
cd "${WORK_DIR}"

# pull ds package
curl -L "https://dlcdn.apache.org/dolphinscheduler/${DOLPHINSCHEDULER_VERSION}/apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin.tar.gz" | tar -zx
curl -L "https://repo.maven.apache.org/maven2/io/juicefs/juicefs-hadoop/${JUICEFS_VERSION}/juicefs-hadoop-${JUICEFS_VERSION}.jar" \
     -o "apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin/lib/juicefs-hadoop.jar" && \
curl -L "https://repo.maven.apache.org/maven2/mysql/mysql-connector-java/5.1.49/mysql-connector-java-5.1.49.jar" \
     -o "apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin/lib/mysql-connector-java.jar"
find "apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin" | grep 'sh$' | sed -i '/^ *source/s/^/#/'
mv "apache-dolphinscheduler-${DOLPHINSCHEDULER_VERSION}-bin/*" "${WORK_DIR}/dolphinscheduler/"
