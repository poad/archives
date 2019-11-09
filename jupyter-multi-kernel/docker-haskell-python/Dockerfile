FROM poad/docker-jupyter-scala:latest

LABEL Kenji Saito "ken-yo@mbr.nifty.com"

# ensure local python is preferred over distribution python
ENV PATH /usr/local/bin:${PATH}

ENV LANG C.UTF-8

ENV STACK_VERSION "2.1.3"
ENV GHC_VERSION "8.6.5"
ENV CABAL_VERSION_PREFIX "2.4"
ENV HASKELL_VERSION "lts-14.7"

# runtime dependencies
ARG DEPENDENCIES="\
	ca-certificates \
	libexpat1 \
	libffi6 \
	libreadline7 \
	libsqlite3-0 \
	libssl1.1 \
	netbase \
	debian-keyring \
	gnupg1 \
	gnupg2 \
	libnss-lwres \
	libnss-mdns \
	software-properties-common \
	dirmngr"
ARG DEPENDENCIES2="\
    build-essential \
	curl \
	git \
	zlib1g-dev \
	libtinfo-dev \
	libsqlite3-dev \
	g++ \
	netbase \
	xz-utils \
	make"

WORKDIR /tmp
RUN apt-get update -qq \
 && apt-get full-upgrade -qqy \
 && apt-get install -qqy --no-install-recommends ${DEPENDENCIES} ${DEPENDENCIES2}\
 && add-apt-repository ppa:hvr/ghc -y\
 && sed -i 's/eoan/bionic/g' /etc/apt/sources.list.d/hvr-ubuntu-ghc-eoan.list \
 && gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv 2C6A674E85EE3FB896AFC9B965101FF31C5C154D \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv FF3AEACEF6F88286 \
 && mv /etc/apt/sources.list.d/hvr-ubuntu-ghc-eoan.list /etc/apt/sources.list.d/hvr-ubuntu-ghc-bionic.list \
 && apt-get update -qq  \
 && apt-get install -qqy --no-install-recommends cabal-install-${CABAL_VERSION_PREFIX} ghc-${GHC_VERSION} \
 && curl -fSL https://github.com/commercialhaskell/stack/releases/download/v${STACK_VERSION}/stack-${STACK_VERSION}-linux-x86_64.tar.gz -o stack.tar.gz \
 && curl -fSL https://github.com/commercialhaskell/stack/releases/download/v${STACK_VERSION}/stack-${STACK_VERSION}-linux-x86_64.tar.gz.asc -o stack.tar.gz.asc \
 && gpg --batch --verify stack.tar.gz.asc stack.tar.gz \
 && tar -xf stack.tar.gz -C /usr/local/bin --strip-components=1 \
 && apt-get autoremove --purge -qqy ${DEPENDENCIES2} \
 && stack config set system-ghc --global true

CMD ["python3"]
