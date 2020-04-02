#!/bin/bash

echo -e "\nStarting both bitcoin nodes.\n"

bitcoind -regtest -port=1111 -datadir=/blockchain/node1 -rpcport=1112 -daemon
sleep 3
bitcoind -regtest -port=2222 -datadir=/blockchain/node2 -rpcport=2223 -daemon
sleep 3

bitcoin-cli -regtest -datadir=/blockchain/node1 -rpcport=1112 addnode "127.0.0.1:2222" "add"

baseaddress_node1=`bitcoin-cli -regtest -datadir=/blockchain/node1 -rpcport=1112 getnewaddress`
baseaddress_node2=`bitcoin-cli -regtest -datadir=/blockchain/node2 -rpcport=2223 getnewaddress`

bitcoin-cli -regtest -datadir=/blockchain/node1 -rpcport=1112 generatetoaddress 100 $baseaddress_node1

blockTime=5

while true
do
    rnd=$(($RANDOM%2))
if [ "$rnd" = "0" ];
    then
        echo node1 generated the next block:
        bitcoin-cli -regtest -datadir=/blockchain/node1 -rpcport=1112 generatetoaddress 1 $baseaddress_node1
    else
        echo node2 generated the next block:
       bitcoin-cli -regtest -datadir=/blockchain/node2 -rpcport=2223 generatetoaddress 1 $baseaddress_node2
    fi
sleep $blockTime
done