FROM bitnami/minideb:stretch

RUN apt-get -y update
RUN apt-get -y install \
  autoconf \
  automake \
  build-essential \
  curl \
  gawk \
  libtool \
  locales \
  locales-all \
  pkg-config \
  subversion 

# fix svn locale issue
RUN locale-gen en_US.UTF-8
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

# pull only the bits of langtech we need
RUN svn checkout --trust-server-cert --depth empty https://victorio.uit.no/langtech/trunk/ /home/langtech
RUN svn update --trust-server-cert --set-depth immediates /home/langtech
RUN svn update --trust-server-cert --set-depth infinity /home/langtech/langs/crk
RUN svn update --trust-server-cert --set-depth infinity /home/langtech/giella-core
RUN svn update --trust-server-cert --set-depth infinity /home/langtech/giella-shared
RUN svn update --trust-server-cert --set-depth infinity /home/langtech/gt

# pull up-to-date fst deps
RUN curl -s http://apertium.projectjj.com/apt/nightly/pool/main/h/hfst/libhfst51_3.14.0+g3669~432203dd-1~stretch1_amd64.deb > /tmp/libhfst.deb
RUN apt install -y /tmp/libhfst.deb
RUN curl -s http://apertium.projectjj.com/apt/nightly/pool/main/h/hfst/hfst_3.14.0+g3669~432203dd-1~stretch1_amd64.deb > /tmp/hfst.deb
RUN apt install -y /tmp/hfst.deb

# set env vars for build
ENV GTHOME=/home/langtech
ENV GTCORE=/home/langtech/giella-core
ENV GTSHARED=/home/langtech/giella-shared
ENV GTLANG_crk=/home/langtech/langs/crk

# run autogen + configure + make + make install in both core and shared
RUN cd /home/langtech/giella-core/ && \
  ./autogen.sh && \
  ./configure && \
  make && make install

RUN cd /home/langtech/giella-shared/ && \
  ./autogen.sh && \
  ./configure && \
  make && make install

RUN cd /home/langtech/langs/crk/ && \
  ./autogen.sh && \
  ./configure --disable-syntax && \
  make && make install
