FROM poad/docker-java-amazon:2017.03
MAINTAINER Kenji Saito

USER root

RUN yum groupinstall "Development Tools" -y
RUN yum install -y cmake zlib-devel openssl-devel \
  cmake zlib-devel openssl-devel protobuf protobuf-devel \
  curl-devel libarchive libarchive-devel expat expat-devel rhash-devel zlib-devel bzip2-devel xz-devel

RUN curl -sL https://cmake.org/files/v3.1/cmake-3.1.0.tar.gz | tar -xz -C /tmp && \
    cd /tmp/cmake-3.1.0 && \
    ./bootstrap --prefix=/usr       \
                --system-libs       \
                --mandir=/share/man \
                --docdir=/share/doc/cmake-3.1.0 && \
    make && make install
 
# hadoop
RUN curl -s https://archive.apache.org/dist/hadoop/common/hadoop-3.0.0/hadoop-3.0.0-src.tar.gz | tar -xz -C /tmp

RUN curl -sL https://archive.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s ./apache-maven-3.5.2 maven

ENV PATH ${PATH}:/usr/local/maven/bin
ENV JAVA_HOME /usr/lib/jvm/java
ENV PATH ${JAVA_HOME}:${PATH}

WORKDIR /tmp/hadoop-3.0.0-src/

# Fix the doxia version
RUN mv pom.xml pom.xml.org && \
    sed -e "s/1\.8-SNAPSHOT/1.8/gi" pom.xml.org > pom.xml

RUN mvn package -Pdist,native -DskipTests -Dtar

# tar to stdout
CMD cd /tmp/hadoop-3.0.0-src/hadoop-dist/target/hadoop-3.0.0/lib && \
    tar czf /root/hadoop-native.tar.gz native

