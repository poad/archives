FROM poad/docker-spark-amazon:2.0
MAINTAINER Kenji Saito

ENV SPARK_HOME /usr/local/spark

RUN yum install -y python27-devel gcc && \
    yum clean all

RUN curl -s https://bootstrap.pypa.io/get-pip.py | python
RUN pip install jupyter && \
    pip install notebook && \
    pip --no-cache-dir install pyspark

RUN jupyter notebook --generate-config --allow-root
COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

EXPOSE 18080 7077

ENTRYPOINT ["/etc/bootstrap.sh"]

