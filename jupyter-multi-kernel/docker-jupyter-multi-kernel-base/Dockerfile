FROM poad/docker-jupyter-base:latest

LABEL Kenji Saito "ken-yo@mbr.nifty.com"

ENV PATH ${PATH}:/root/.mix/
ENV DEBIAN_FRONTEND noninteractive

ARG OCAML_KERNEL_VERSION="2.5.0"
ARG IERL_VERSION="0.3.3"
ARG CLOJUPYTER_VERSION="0.2.3"
ARG EVCXR_VERSION="0.4.5"

RUN echo $(node --version)

ARG DEPENDENCIES_TEMP="\
    software-properties-common \
    binutils \
    g++ \
    cmake \
    gcc \
    cpp \
    g++-6 \
    less \
    libc-dev-bin \
    libc6-dev \
    libpango1.0-dev \
    libffi-dev \
    libgmp-dev \
    liblapack-dev \
    libmagic-dev \
    linux-libc-dev \
    libblas-dev \
    libcairo2-dev \
    libsqlite3-dev \
    libtinfo-dev \
    libzmq3-dev \
    libssl-dev \
    libcrypto++-dev \
    libczmq-dev \
    make \
    manpages \
    manpages-dev \
    patch \
    rename \
    rsync \
    xauth \
    xz-utils \
    zlib1g-dev \
    unzip \
    aspcud \
    bzip2 \
    autoconf \
    automake \
    curl \
    wget \
    m4"

WORKDIR /tmp
ENV PATH ${PATH}:/root/.cargo/bin
ENV CLOJUPYTER_PATH ${HOME}/clojupyter
ENV LEIN_ROOT=1
ENV PATH ${PATH}:/usr/local/bin
ENV PATH ${PATH}:${GOPATH}/bin
ENV PATH ${PATH}:/root/.ierl

RUN apt-get -qq update \
 && apt-get full-upgrade -qqy \
 && apt-get install -qqy --no-install-recommends ${DEPENDENCIES_TEMP} \
 && wget https://github.com/google/evcxr/archive/v${EVCXR_VERSION}.tar.gz \
 && tar xf v${EVCXR_VERSION}.tar.gz  \
 && ls \
 && mv evcxr-${EVCXR_VERSION} evcxr \
 && cd evcxr/evcxr_jupyter \
 && cargo install evcxr_jupyter \
 && evcxr_jupyter --install \
 && cd /tmp \
 && git clone https://github.com/ligee/kotlin-jupyter.git \
 && cd /tmp/kotlin-jupyter \
 && mv build.gradle build.gradle.bak \
 && sed -e "s/'1\.2\.21'/'1.3.31'/g" build.gradle.bak > build.gradle \
 && mv gradle/wrapper/gradle-wrapper.properties gradle/wrapper/gradle-wrapper.properties.bak \
 && sed -e "s/2\.12/4.10.2/g" gradle/wrapper/gradle-wrapper.properties.bak > gradle/wrapper/gradle-wrapper.properties \
 && ./gradlew install \
 && pip install flit \
#  && cd /usr/local/bin \
#  && wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein \
#  && chmod +x lein \
#  && cd /tmp \
#  && git clone https://github.com/clojupyter/clojupyter \
#  && cd clojupyter \
#  && git checkout ${CLOJUPYTER_VERSION} \
#  && make \
#  && make install \
 && mkdir /notebooks \
 && curl -sL "https://github.com/akabe/ocaml-jupyter/releases/download/v${OCAML_KERNEL_VERSION}/jupyter-v${OCAML_KERNEL_VERSION}.tbz" | tar -xj -C /tmp \
 && cd /tmp \
 && opam install jupyter -y \
#  && opam install jupyter-archimedes -y \
 && jupyter kernelspec install --name ocaml-jupyter "$(opam config var share)/jupyter" \
 && go get -u github.com/gopherdata/gophernotes \
 && mkdir -p ~/.local/share/jupyter/kernels/gophernotes \
 && cp ${GOPATH}/src/github.com/gopherdata/gophernotes/kernel/* ~/.local/share/jupyter/kernels/gophernotes  \
 && mkdir -p /root/.ierl \
 && cd /root/.ierl \
 && wget https://github.com/filmor/ierl/releases/download/v${IERL_VERSION}/ierl \
 && chmod u+x ierl \
 && ./ierl install elixir --user \
 && ./ierl install lfe --user \
 && ./ierl install erlang --user \
 && apt-get autoremove --purge -qqy ${DEPENDENCIES_TEMP} \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /root

EXPOSE 8888

CMD ["jupyter", "lab"]
