FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y build-essential libtool autotools-dev autoconf libssl-dev libboost-all-dev
RUN apt-get install -y software-properties-common
RUN apt-get update

RUN apt-get install -y wget

RUN wget https://bitcoincore.org/bin/bitcoin-core-0.19.1/bitcoin-0.19.1-x86_64-linux-gnu.tar.gz

RUN tar -xvf bitcoin-0.19.1-x86_64-linux-gnu.tar.gz

RUN mkdir /blockchain && \
    mkdir /blockchain/node1 && \
    mkdir /blockchain/node2 && \ 
    ls

ENV PATH="/bitcoin-0.19.1/bin:${PATH}"

ADD entrypoint.sh $HOME/entrypoint.sh
ADD bitcoin.conf /blockchain/node1/bitcoin.conf
ADD bitcoin.conf /blockchain/node2/bitcoin.conf

EXPOSE 1111
EXPOSE 1112 
EXPOSE 2222 
EXPOSE 2223

CMD ["./entrypoint.sh"]