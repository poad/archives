FROM poad/docker-jupyter-notebook-pyspark-amazon:latest
MAINTAINER Kenji Saito

ENV SPARK_HOME /usr/local/spark

RUN rm -rf $SPARK_HOME/yarn-remote-client
RUN mkdir $SPARK_HOME/yarn-remote-client
ADD yarn-remote-client $SPARK_HOME/yarn-remote-client

COPY bootstrap.sh /etc/bootstrap.sh
COPY spark/conf/spark-defaults.conf $SPARK_HOME/conf/spark-defaults.conf 
COPY hadoop/etc/hadoop/hdfs-site.xml ${HADOOP_PREFIX}/etc/hadoop/hdfs-site.xml
COPY hadoop/etc/hadoop/slaves ${HADOOP_PREFIX}/etc/hadoop/slaves

RUN chown root.root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh

EXPOSE 18080

ENTRYPOINT ["/etc/bootstrap.sh"]

