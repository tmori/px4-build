FROM ubuntu:20.04 as px4-build

ARG DEBIAN_FRONTEND=noninteractive
ENV CMAKE_INSTALL_DIR /usr/local/cmake

RUN apt-get update
RUN apt-get install -y \
	git	\
	build-essential	\
	wget	\
	gcc	\
	g++	\
	vim	\
	gem \
	libssl-dev libreadline-dev zlib1g-dev \
	make	\
	autoconf \
	automake \
	pkg-config \
	curl \
	net-tools \
	netcat \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

RUN	wget -q -O cmake-linux.sh https://github.com/Kitware/CMake/releases/download/v3.17.0/cmake-3.17.0-Linux-x86_64.sh && \
	mkdir -p $CMAKE_INSTALL_DIR && \
	sh cmake-linux.sh --skip-license --prefix=$CMAKE_INSTALL_DIR && \
	rm cmake-linux.sh
ENV PATH ${PATH}:${CMAKE_INSTALL_DIR}/bin
RUN apt-get update
RUN apt-get install -y python3-pip python3-setuptools python3-wheel ninja-build
RUN pip3 install --upgrade numpy empy toml
RUN apt-get install lsof -y

WORKDIR /root/workspace
