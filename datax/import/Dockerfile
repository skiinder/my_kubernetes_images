FROM registry.cn-zhangjiakou.aliyuncs.com/skiinder/datax-github:latest

COPY datax /opt/datax
COPY juicefs-hadoop.jar /opt/datax/plugin/reader/hdfsreader/libs/

RUN cd /opt/datax/plugin/writer/hdfswriter/libs && \
    ln -s ../../../reader/hdfsreader/libs/juicefs-hadoop.jar && \
    chmod +x entrypoint.sh generate_import_config.py

WORKDIR /opt/datax

ENTRYPOINT [ "/opt/datax/entrypoint.sh" ]