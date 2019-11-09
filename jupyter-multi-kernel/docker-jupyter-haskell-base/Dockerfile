FROM poad/docker-jupyter-multi-kernel-base:latest

LABEL Kenji Saito "ken-yo@mbr.nifty.com"

# Install IHaskell
ENV PATH $(stack path --local-install-root)/bin:$(stack path --snapshot-install-root)/bin:$(stack path --compiler-bin):/root/.local/bin:/usr/local/sbin:/usr/local/bin:${PATH}

WORKDIR /root/IHaskell

ARG DEPENDENCIES="\
	ca-certificates \
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
    netbase \
    m4"

RUN apt-get update -qq \
 && apt-get install -qqy --no-install-recommends ${DEPENDENCIES}
RUN echo "system-ghc: true" >> ${STACK_YAML} \
 && echo "install-ghc: false" >> ${STACK_YAML} \
 && echo "jobs: 1" >> ${STACK_YAML} \
 && sed -i -e "s/- .\/ihaskell-display\/ihaskell-widgets/#- .\/ihaskell-displayz\/ihaskell-widgets/" ${STACK_YAML}
RUN stack setup --resolver ${HASKELL_VERSION} --stack-yaml ${STACK_YAML} --system-ghc --no-terminal \
 && stack --resolver ${HASKELL_VERSION} --stack-yaml ${STACK_YAML} --system-ghc --no-terminal install --no-run-benchmarks --no-run-tests --no-haddock --no-test \
 && apt-get purge -qqy ${DEPENDENCIES} \
 && apt-get autoremove --purge -qqy \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* 
