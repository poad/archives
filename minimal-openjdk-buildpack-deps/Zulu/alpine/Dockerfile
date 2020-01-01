ARG JAVA_TAG="11u5"
ARG OUTPUT=/opt/jdk-11-mini-runtime

FROM mcr.microsoft.com/java/jdk:${JAVA_TAG}-zulu-alpine as jlink-package

ARG OUTPUT

RUN jlink \
     --module-path ${JAVA_HOME}/jmods \
     --compress=2 \
     --add-modules jdk.jfr,jdk.management.agent,java.base,java.logging,java.xml,jdk.unsupported,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument \
     --no-header-files \
     --no-man-pages \
     --output ${OUTPUT}

FROM alpine:3.10

LABEL maintainer="Kenji Saito<ken-yo@mbr.nifty.com>"

ARG BIN_DIR="/usr/bin"
ARG OUTPUT

ENV JAVA_HOME=/usr/lib/jvm/zulu-11/jdk-11-mini-runtime

COPY --from=jlink-package ${OUTPUT} ${JAVA_HOME}

RUN cd ${BIN_DIR} && find ${JAVA_HOME}/bin -type f -perm -a=x -exec ln -s {} . \;

ENV PATH="${PATH}:${JAVA_HOME}/bin"

RUN addgroup -g 1000 -S java \
 && adduser -u 1000 -S  java -G java

HEALTHCHECK CMD [ "java", "-version" ]

USER java

ENTRYPOINT [ "java" ]
