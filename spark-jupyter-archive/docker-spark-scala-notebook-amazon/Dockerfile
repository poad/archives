FROM poad/docker-jupyter-notebook-pyspark-amazon:latest
MAINTAINER Kenji Saito

ENV SBT_VERSION 1.3.2
ENV SCALA_VERSION 2.13.1
ENV SBT_HOME /usr/local/sbt
ENV PATH ${PATH}:${SBT_HOME}/bin

# Install sbt
RUN curl -sL "https://github.com/sbt/sbt/releases/download/v${SBT_VERSION}/sbt-${SBT_VERSION}.tgz" | tar -xz -C /usr/local

ARG ALMOND_VERSION=0.8.2
WORKDIR /tmp
RUN yum update -y && \
    yum install -y git && \
    rm -rf /var/cache/yum/* && \
    yum clean all && \
    git clone https://github.com/almond-sh/almond.git && \
    cd almond/project && \
    mv build.properties build.properties.bak && \
    sed -e "s/1\.2\.7/${SBT_VERSION}/g" build.properties.bak > build.properties && \
    rm -f build.properties.bak && \
    cd ../ && \
    bash scripts/coursier.sh bootstrap \
        -r jitpack \
        -i user -I user:sh.almond:scala-kernel-api_$SCALA_VERSION:$ALMOND_VERSION \
        sh.almond:scala-kernel_$SCALA_VERSION:$ALMOND_VERSION \
        -o almond && \
    ./almond --install && \
    pip install --upgrade toree

WORKDIR /root

COPY bootstrap.sh /etc/bootstrap.sh

RUN chown root.root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh


EXPOSE 18080 7077 8888

ENTRYPOINT ["/etc/bootstrap.sh"]
CMD ["lab"]

