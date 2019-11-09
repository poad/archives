FROM amazonlinux:1

LABEL Kenji Saito "ken-yo@mbr.nifty.com"

USER root

RUN yum -y install yum-plugin-fastestmirror \
 && yum update -y \
 && yum -y install vim passwd openssh sudo iproute curl which tar sudo openssh-server openssh-clients rsync java-1.8.0-openjdk-devel \
 && yum update -y libselinux \
 && rm -rf /var/cache/yum/* \
 && yum clean all \
 && sed -ri 's/#PermitRootLogin yes/PermitRootLogin yes/g' /etc/ssh/sshd_config \
 && sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config \
 && sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config

ENV JAVA_HOME="/usr/lib/jvm/java"

# ENV JAVA_VERSION=11.0.1 \
#     JAVA_HOME="/usr/lib/jvm/java-11.0.1-openjdk.x86_64" \
#     JDK_HOME="/usr/lib/jvm/java-11.0.1-openjdk.x86_64" \
#     JRE_HOME="/usr/lib/jvm/java-11.0.1-openjdk.x86_64" \
#     JDK_VERSION=11.0.1 \
#     JDK_VERSION_TAG=13 \
#     JDK_DOWNLOAD_SHA256="7a6bb980b9c91c478421f865087ad2d69086a0583aeeb9e69204785e8e97dcfd"

# ENV JDK_DOWNLOAD_TAR="openjdk-${JDK_VERSION}_linux-x64_bin.tar.gz"


# RUN mkdir -p ${JAVA_HOME} \
#  && curl -LSso /var/tmp/${JDK_DOWNLOAD_TAR} https://download.java.net/java/GA/jdk11/${JDK_VERSION_TAG}/GPL/${JDK_DOWNLOAD_TAR} \
#  && echo "$JDK_DOWNLOAD_SHA256 /var/tmp/${JDK_DOWNLOAD_TAR}" | tee foo.txt | sha256sum -c - \
#  && tar xzvf /var/tmp/${JDK_DOWNLOAD_TAR} -C ${JAVA_HOME} --strip-components=1 \
#  && for tool_path in ${JAVA_HOME}/bin/*; do \
#         tool=`basename $tool_path`; \
#         update-alternatives --install /usr/bin/$tool $tool $tool_path 10000; \
#         update-alternatives --set $tool $tool_path; \
#     done \
#  && rm ${JAVA_HOME}/lib/security/cacerts && ln -s /etc/ssl/certs/java/cacerts ${JAVA_HOME}/lib/security/cacerts \
#  && ln -s ${JAVA_HOME} /usr/lib/jvm/java