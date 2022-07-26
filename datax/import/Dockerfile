FROM registry.cn-zhangjiakou.aliyuncs.com/skiinder/datax-github:latest

RUN cd /opt/datax/plugin/reader/hdfsreader/libs && \
    curl -LO https://github.com/juicedata/juicefs/releases/download/v1.0.0-rc3/juicefs-hadoop-1.0.0-rc3.jar && \
    cd /opt/datax/plugin/writer/hdfswriter/libs && \
    ln -s ../../../reader/hdfsreader/libs/juicefs-hadoop-1.0.0-rc3.jar

COPY datax /opt/datax
WORKDIR /opt/datax
RUN chmod +x entrypoint.sh generate_import_config.py

ENTRYPOINT [ "/opt/datax/entrypoint.sh" ]