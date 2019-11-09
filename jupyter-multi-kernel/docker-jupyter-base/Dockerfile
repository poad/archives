FROM poad/docker-haskell-python:latest

LABEL Kenji Saito "ken-yo@mbr.nifty.com"

## ensure locale is set during build
ENV LANG C.UTF-8

ARG OPAM_VERSION="2.0.5"
ARG OCAML_VERSION="4.07.1"
ARG GOLANG_VERSION_PREFIX="1.12"

ENV DEBIAN_FRONTEND noninteractive

USER root

WORKDIR /root/

# Fix the update-alternatives bugs
RUN mkdir -p /usr/share/man/
RUN mkdir -p /usr/share/man/man1

ENV PATH /root/.local/bin:${PATH}
ENV PATH /root/.cabal/bin:/root/.local/bin:/opt/cabal/${CABAL_VERSION}/bin:/opt/ghc/${GHC_VERSION}/bin:$PATH

ARG DEPENDENCIES_TEMP="\
    software-properties-common \
    binutils \
    g++ \
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

ARG DEPENDENCIES="\
    apt-utils \
    apt-transport-https \
    build-essential \
    gnupg \
    dirmngr \
    ca-certificates \
    git \
    git-man \
    libssl1.1 \
    libzmq5 \
    pkg-config"


ENV PATH ${PATH}:/usr/lib/go-${GOLANG_VERSION_PREFIX}/bin
ENV GOPATH /root/.go

ENV PATH $PATH:/root/.cargo/bin

ENV DEBIAN_FRONTEND teletype
ENV 'ACCEPT_EULA' 'Y'

ENV NODE_VERSION 10.16.0
ENV YARN_VERSION 1.17.3

RUN apt-get -qq update \
 && apt-get full-upgrade -qqy \
 && apt-get install -qqy --no-install-recommends ${DEPENDENCIES_TEMP} ${DEPENDENCIES} \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F6BC817356A3D45E \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 308C15A29AD198E9 \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FF3AEACEF6F88286 \
 && wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
 && echo "deb http://apt.llvm.org/buster/ llvm-toolchain-buster main" > /etc/apt/sources.list.d/llvm-toolchain-buster.list \
 && echo "deb-src http://apt.llvm.org/buster/ llvm-toolchain-buster main" >> /etc/apt/sources.list.d/llvm-toolchain-buster.list \
 && echo "deb http://apt.llvm.org/buster/ llvm-toolchain-buster-8 main" > /etc/apt/sources.list.d/llvm-toolchain-buster.list \
 && echo "deb-src http://apt.llvm.org/buster/ llvm-toolchain-buster-8 main" >> /etc/apt/sources.list.d/llvm-toolchain-buster.list \
 && echo "deb http://ppa.launchpad.net/longsleep/golang-backports/ubuntu bionic main" > /etc/apt/sources.list.d/golang-go-backports.list \
 && echo "deb-src http://ppa.launchpad.net/longsleep/golang-backports/ubuntu bionic main " >> /etc/apt/sources.list.d/golang-go-backports.list \
 && gpg --no-tty --keyserver keyserver.ubuntu.com --recv-keys C5705533DA4F78D8664B5DC0575159689BEFB442 \
 && echo "deb https://packages.erlang-solutions.com/debian buster contrib" | tee /etc/apt/sources.list.d/erlang-solutions.list \
 && ERLANG_TMP=$(mktemp -d) \
 && cd ${ERLANG_TMP} \
 && wget https://packages.erlang-solutions.com/debian/erlang_solutions.asc \
 && apt-key add erlang_solutions.asc \
 && rm -rf ${ERLANG_TMP} \
 && apt-get update -qq \
 && apt-get install -qqy --no-install-recommends \
      libcrypto++6 \
      libncurses5 \
      libncurses5-dev \
      libatomic1 \
      libbsd0 \
      libcilkrts5 \
      libedit2 \
      liberror-perl \
      libgmpxx4ldbl \
      libgomp1 \
      libgpm2 \
      libitm1 \
      liblsan0 \
      libmpc3 \
      libmpx2 \
      libpopt0 \
      libquadmath0 \
      libtsan0 \
      libubsan0 \
      libx11-6 \
      libx11-data \
      libxau6 \
      libxcb1 \
      libxdmcp6 \
      libxext6 \
      libxmuu1 \
      openssh-client \
      perl \
      libsqlite3-0 \
      libtool \
      golang-${GOLANG_VERSION_PREFIX}-go \
      aspcud \
      ocaml-nox \
      pandoc \
      erlang \
      erlang-dev \
      erlang-base-hipe \
      elixir \
      rebar \
      clang-8 lldb-8 lld-8 \
      libllvm8 llvm-8 llvm-8-dev llvm-8-runtime \
      lld-8 \
      libc++-8-dev libc++abi-8-dev \
      libfuzzer-8-dev \
 && apt-get upgrade -qqy \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
 
RUN apt-get update -qq \
 && curl https://sh.rustup.rs -sSf | sh -s -- -y && true \
 && cd /tmp \
 && git clone https://github.com/gibiansky/IHaskell.git /tmp/IHaskell \
 && mkdir -p /root/IHaskell \
 && mkdir -p /root/.local/bin \
 && cd /root/IHaskell \
 && cp /tmp/IHaskell/requirements.txt . \
 && cp /tmp/IHaskell/stack-8.2.yaml . \
 && cp /tmp/IHaskell/stack.yaml . \
 && cp -R /tmp/IHaskell/ipython-kernel . \
 && pip3 install -r requirements.txt \
 && stack --resolver ${HASKELL_VERSION} config set system-ghc --global true \
 && stack --resolver ${HASKELL_VERSION} config set install-ghc --global true \
 && cp /tmp/IHaskell/ihaskell.cabal . \
 && cp -R /tmp/IHaskell/ghc-parser . \
 && cp -R /tmp/IHaskell/ihaskell-display . \
 && cp -R /tmp/IHaskell/src . \
 && cp -R /tmp/IHaskell/html . \
 && cp -R /tmp/IHaskell/main . \
 && cp -R /tmp/IHaskell/LICENSE LICENSE \
 && cd $(dirname $(which ghc)) \
 && cd ../lib/ghc-$(echo $(dirname $(which ghc)) | sed -e "s/\/opt\/ghc\///" | sed -e "s/\/bin//") \
 && cp settings settings.bak \
 && sed -e "s/\"llc\"/\"llc-8\"/" | sed -e "s/\"opt\"/\"opt-8\"/" settings.bak > settings \
 && cd /root \
 && apt-get update -qq \
 && apt-get install -y bubblewrap \
 && curl -sSL -o /usr/bin/opam https://github.com/ocaml/opam/releases/download/${OPAM_VERSION}/opam-${OPAM_VERSION}-x86_64-linux \
 && chmod a+x /usr/bin/opam \
 && opam init -y -a --disable-sandboxing --comp ${OCAML_VERSION} \
#  && eval $(opam env) \
#  && opam switch ${OCAML_VERSION} \
 && eval `opam config env` \
 && ARCH= && dpkgArch="$(dpkg --print-architecture)" \
 && case "${dpkgArch##*-}" in \
      amd64) ARCH='x64';; \
      ppc64el) ARCH='ppc64le';; \
      s390x) ARCH='s390x';; \
      arm64) ARCH='arm64';; \
      armhf) ARCH='armv7l';; \
      i386) ARCH='x86';; \
      *) echo "unsupported architecture"; exit 1 ;; \
    esac \
  # gpg keys listed at https://github.com/nodejs/node#release-keys
 && set -ex \
 && for key in \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    77984A986EBC2AA786BC0F66B01FBB92821C587A \
    8FCCA13FEF1D0C2E91008E09770F7A9A5AE15600 \
    4ED778F539E3634C779C87C6D7062848A1AB005C \
    A48C2BEE680E841632CD4E44F07496B3EB3C1762 \
    B9E2F5981AA6E0CD28160D9FF13993A75599653C \
    ; do \
    gpg --batch --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" || \
    gpg --batch --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --batch --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key" ; \
    done \
 && curl -fsSLO --compressed "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-$ARCH.tar.xz" \
 && curl -fsSLO --compressed "https://nodejs.org/dist/v${NODE_VERSION}/SHASUMS256.txt.asc" \
 && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
 && grep " node-v${NODE_VERSION}-linux-$ARCH.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
 && tar -xJf "node-v${NODE_VERSION}-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
 && rm "node-v${NODE_VERSION}-linux-$ARCH.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
 && ln -s /usr/local/bin/node /usr/local/bin/nodejs \
 && set -ex \
 && for key in \
        6A010C5166006599AA17F08146C2130DFD2497F5 \
        ; do \
        gpg --batch --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" || \
        gpg --batch --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$key" || \
        gpg --batch --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key" ; \
    done \
 && curl -fsSLO --compressed "https://yarnpkg.com/downloads/${YARN_VERSION}/yarn-v${YARN_VERSION}.tar.gz" \
 && curl -fsSLO --compressed "https://yarnpkg.com/downloads/${YARN_VERSION}/yarn-v${YARN_VERSION}.tar.gz.asc" \
 && gpg --batch --verify yarn-v${YARN_VERSION}.tar.gz.asc yarn-v${YARN_VERSION}.tar.gz \
 && mkdir -p /opt \
 && tar -xzf yarn-v${YARN_VERSION}.tar.gz -C /opt/ \
 && ln -s /opt/yarn-v${YARN_VERSION}/bin/yarn /usr/local/bin/yarn \
 && ln -s /opt/yarn-v${YARN_VERSION}/bin/yarnpkg /usr/local/bin/yarnpkg \
 && rm yarn-v${YARN_VERSION}.tar.gz.asc yarn-v${YARN_VERSION}.tar.gz \
 && npm install -g configurable-http-proxy \
 && apt-get autoremove --purge -qqy ${DEPENDENCIES_TEMP} \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/*
 
ENV PATH $(stack path --local-install-root)/bin:$(stack path --snapshot-install-root)/bin:$(stack path --compiler-bin):/root/.local/bin:/usr/local/sbin:/usr/local/bin:${PATH}

ENV STACK_YAML "/root/IHaskell/stack.yaml"
