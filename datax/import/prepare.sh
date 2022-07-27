#!/bin/bash
WORK_DIR="$(cd $(dirname "$0"); pwd)"
cd "${WORK_DIR}"

curl -L "https://repo.maven.apache.org/maven2/io/juicefs/juicefs-hadoop/${JUICEFS_VERSION}/juicefs-hadoop-${JUICEFS_VERSION}.jar" -o juicefs-hadoop.jar
