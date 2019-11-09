FROM poad/docker-java-amazon:latest

LABEL Kenji Saito "ken-yo@mbr.nifty.com"

USER root

ARG HADOOP_VERSION="2.8.5"
ARG MAVEN_VERSION="3.6.1"

RUN yum groupinstall "Development Tools" -y
RUN yum install -y cmake zlib-devel openssl-devel \
  cmake zlib-devel openssl-devel protobuf protobuf-devel

# hadoop
RUN curl -s https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}-src.tar.gz | tar -xz -C /tmp
RUN cd /tmp 

RUN curl -sL https://archive.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s ./apache-maven-${MAVEN_VERSION} maven

ENV PATH ${PATH}:/usr/local/maven/bin
ENV PATH ${JAVA_HOME}:${PATH}

WORKDIR /tmp/hadoop-${HADOOP_VERSION}-src/
RUN mvn package -Pdist,native -DskipTests -Dtar

# tar to stdout
CMD cd /tmp/hadoop-${HADOOP_VERSION}-src/hadoop-dist/target/hadoop-${HADOOP_VERSION}/lib && \
    tar czf /root/hadoop-native.tar.gz native

