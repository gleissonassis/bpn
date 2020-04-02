# Bitcoin Private Network

This project configures a Bitcoin private network in regtest, a regtest is described as:

> A local testing environment in which developers can almost instantly generate [blocks](https://bitcoin.org/en/glossary/block "One or more transactions prefaced by a block header and protected by proof of work. Blocks are the data stored on the block chain.") on demand for testing events, and can create private [satoshis](https://bitcoin.org/en/glossary/denominations "Denominations of Bitcoin value, usually measured in fractions of a bitcoin but sometimes measured in multiples of a satoshi.  One bitcoin equals 100,000,000 satoshis.") with no real-world value. ([https://bitcoin.org/en/glossary/regression-test-mode](https://bitcoin.org/en/glossary/regression-test-mode))

In this example, two nodes are generating new blocks every 5 seconds (balancing between these two nodes). If you want to change the interval (5 seconds) see the entrypoint.sh file. The main goal is to make it easy to test a bitcoin application with instantly blocks, almost like what Ganache does to the Ethereum network.

The project was build based on the content of this post:
[https://medium.com/@kay.odenthal_25114/create-a-private-bitcoin-network-with-simulated-mining-b35f5b03e534](https://medium.com/@kay.odenthal_25114/create-a-private-bitcoin-network-with-simulated-mining-b35f5b03e534)

Go to the post and give him a lof of claps!

# How to use

Clone this project, build the image and run the container. The default storage is ephemeral, because, as described before, the main goal is just to start a new test environment, however, if you need to persist data share the volumes */blockchain/node1* and */blockchain/node2* or directly */blockchain*.

````
git clone https://github.com/gleissonassis/bpn
cd bpn
docker build . -t bpn
docker run -p 1111:1111 -p 1112:1112 -p 2222:2222 -p 2223:2223 bpn
````

The ports 1111 e 2222 are designed to allow communication between the nodes and the ports 1112 and 2223 are designed to your application send RPC commands. 

## Sending RPC requests

As described in the bitcoin.conf file, it is necessary to enter a user and password which are:
user: rpc
password: rpc

Example:

**POST**: http://rpc:btc@localhost:1112
````
{
	"jsonrpc": "1.0", 
	"id":"curltest", 
	"method": "getblockchaininfo", 
	"params": [] 
}
````

For more details about the methods go to the [oficial documentation](https://bitcoincore.org/en/doc/0.18.0/rpc/).
