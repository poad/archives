FROM poad/docker-spark-ubuntu:2.0.2
MAINTAINER Kenji Saito

ENV SPARK_HOME /usr/local/spark

RUN yum install -y python27-pip && \
    yum clean all

RUN pip install jupyter && \
    pip install notebook && \
    pip --no-cache-dir install pyspark

RUN jupyter notebook --generate-config --allow-root
COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

EXPOSE 18080 7077

ENTRYPOINT ["/etc/bootstrap.sh"]

