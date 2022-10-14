FROM flink:1.15.2
USER flink
RUN curl https://repo.maven.apache.org/maven2/org/apache/hudi/hudi-flink1.15-bundle/0.12.0/hudi-flink1.15-bundle-0.12.0.jar -o /opt/flink/lib/hudi-flink1.15-bundle-0.12.0.jar && \
    curl https://repo.maven.apache.org/maven2/org/apache/hadoop/hadoop-client-api/3.3.4/hadoop-client-api-3.3.4.jar -o /opt/flink/lib/hadoop-client-api-3.3.4.jar && \
    curl https://repo.maven.apache.org/maven2/org/apache/hadoop/hadoop-client-runtime/3.3.4/hadoop-client-runtime-3.3.4.jar -o /opt/flink/lib/hadoop-client-runtime-3.3.4.jar

