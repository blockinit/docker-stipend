FROM ubuntu:16.04

RUN apt-get update &&\
  apt-get install -y wget curl lsb-release &&\
  apt-get install -y libdb5.3++ &&\
  apt-get install -y libboost-all-dev &&\
  apt-get install -y dh-autoreconf build-essential libtool autotools-dev autoconf automake libssl-dev libboost-all-dev libevent-dev bsdmainutils libminiupnpc-dev libprotobuf-dev protobuf-compiler libqrencode-dev software-properties-common libgmp3-dev git nano &&\
  apt-get install -y software-properties-common
RUN add-apt-repository ppa:bitcoin/bitcoin &&\
  apt-get update &&\
  apt-get install -y libdb4.8-dev libdb4.8++-dev

RUN mkdir -p /opt/stipend
COPY stipend.conf /root/.stipend/stipend.conf

RUN git clone https://github.com/Stipend-Developer/stipend /opt/stipend &&\
  chmod +x /opt/stipend/compile-daemon.sh
RUN cd /opt/stipend &&\
  bash ./compile-daemon.sh

WORKDIR /opt/stipend/src
CMD ["./stipendd", "--help"]
