#!/bin/bash

BUILD_DIR=$(pwd)/network
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"

# Generate peer's address list
IPs=("node0" "node1" "node2" "node3")
NODE_COUNT=${#IPs[@]}

# Generate node data
for ((i=0; i<NODE_COUNT; i++)); do
  NODE_HOME="$BUILD_DIR/${IPs[$i]}"
  
  echo "Initializing node ${IPs[$i]}..."
  # cometbft init node0 --home $BUILD_DIR/node0
  cometbft init "${IPs[$i]}" --home "$NODE_HOME"

done

# Find PERSISTENT_PEERS=""
for ((i=0; i<NODE_COUNT; i++)); do
  NODE_HOME="$BUILD_DIR/${IPs[$i]}"
    
  # cometbft show_node_id --home $BUILD_DIR/node0
  NODE_ID=$(cometbft show-node-id --home "$NODE_HOME")
  PERSISTENT_PEERS+="${NODE_ID}@${IPs[$j]}:26656,"

done
PERSISTENT_PEERS=${PERSISTENT_PEERS%,} # Remove last ,
echo "PERSISTENT_PEERS=$PERSISTENT_PEERS"


# Update node config
for ((i=0; i<NODE_COUNT; i++)); do
  NODE_HOME="$BUILD_DIR/${IPs[$i]}"

  CONFIG_FILE="$NODE_HOME/config/config.toml"
  sed -i.bak "s/^persistent_peers =.*/persistent_peers = \"$PERSISTENT_PEERS\"/" "$CONFIG_FILE"
  echo "Node ${IPs[$i]} configuration updated."
done






