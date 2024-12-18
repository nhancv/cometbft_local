# CometBFT

## Structure
network/
├── node0/
│   ├── config/
│   ├── data/
├── node1/
│   ├── config/
│   ├── data/
├── node2/
│   ├── config/
│   ├── data/
├── node3/
│   ├── config/
│   ├── data/
docker-compose.yml


## Install CometBFT

https://docs.cometbft.com/v0.38/guides/install


## Config CometBFT

https://docs.cometbft.com/v0.38/guides/quick-start

- Build network data & config

```
./build_network.sh
```

## Start network

- Start

```
docker-compose up -d
```

- Stop 

```
docker-compose down
```

## Verify

- Node 0 available endpoints: http://localhost:26657
- Push a test key-value: `curl -s 'localhost:26657/broadcast_tx_commit?tx="abcd=111"'`

```
{"jsonrpc":"2.0","id":-1,"result":{"check_tx":{"code":0,"data":null,"log":"","info":"","gas_wanted":"1","gas_used":"0","events":[],"codespace":""},"tx_result":{"code":0,"data":null,"log":"","info":"","gas_wanted":"0","gas_used":"0","events":[{"type":"app","attributes":[{"key":"creator","value":"Cosmoshi Netowoko","index":true},{"key":"key","value":"abcd","index":true},{"key":"index_key","value":"index is working","index":true},{"key":"noindex_key","value":"index is working","index":false}]},{"type":"app","attributes":[{"key":"creator","value":"Cosmoshi","index":true},{"key":"key","value":"111","index":true},{"key":"index_key","value":"index is working","index":true},{"key":"noindex_key","value":"index is working","index":false}]}],"codespace":""},"hash":"D31861963A9344FA89BAB09E64E026F6FF414347AC8E053BC15F3B113E64C19E","height":"182"}}
```

- Very key: `curl -s 'localhost:26657/abci_query?data="abcd"'`

```
{"jsonrpc":"2.0","id":-1,"result":{"response":{"code":0,"log":"exists","info":"","index":"0","key":"YWJjZA==","value":"MTEx","proofOps":null,"height":"377","codespace":""}}}
```

	+ Decode base64 format of `MTEx` will get `111`

