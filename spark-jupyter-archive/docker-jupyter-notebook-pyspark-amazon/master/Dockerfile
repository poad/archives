FROM poad/docker-spark-amazon:latest
MAINTAINER Kenji Saito

ENV SPARK_HOME /usr/local/spark

RUN yum install -y python27-devel gcc pandoc python35-devel python35-libs python35-setuptools && \
    yum clean all

RUN /usr/bin/easy_install-3.5 pip &&\
    pip3 install --upgrade pip

RUN curl -s https://bootstrap.pypa.io/get-pip.py | python
RUN pip3 install jupyter notebook jupyterlab jupyterhub && \
    pip3 --no-cache-dir install pandas pyspark && \
    pip3 install py4j jupyter-spark lxml && \
    pip3 install --upgrade beautifulsoup4 html5lib && \
    jupyter nbextension install --py jupyter_spark && \
    jupyter serverextension enable --py jupyter_spark && \
    jupyter nbextension enable --py jupyter_spark && \
    jupyter nbextension enable --py widgetsnbextension && \
    jupyter serverextension enable --py jupyterlab --sys-prefix

RUN jupyter notebook --generate-config --allow-root
COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

RUN pip3 install scipy scikit-learn pygments python-sql pandas pyspark ipykernel ipython ipython-sql pyhive

COPY bootstrap.sh /etc/bootstrap.sh

RUN chown root.root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh

EXPOSE 18080 7077 8888

ENTRYPOINT ["jupyter"]
CMD ["lab"]

