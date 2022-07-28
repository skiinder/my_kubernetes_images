#!/bin/bash
WORK_DIR="$(cd $(dirname "$0"); pwd)"
cd "${WORK_DIR}"

curl -L "https://datax-opensource.oss-cn-hangzhou.aliyuncs.com/${DATAX_VERSION}/datax.tar.gz" | tar -zx
cd datax
curl -L https://raw.githubusercontent.com/skiinder/my_kubernetes_images/main/scripts/filededup.sh | bash -
curl -L "https://repo.maven.apache.org/maven2/io/juicefs/juicefs-hadoop/${JUICEFS_VERSION}/juicefs-hadoop-${JUICEFS_VERSION}.jar" \
     -o plugin/reader/hdfsreader/libs/juicefs-hadoop.jar
cd plugin/writer/hdfswriter/libs
ln -s ../../../reader/hdfsreader/libs/juicefs-hadoop.jar
