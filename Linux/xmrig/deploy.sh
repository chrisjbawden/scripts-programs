#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git build-essential cmake libuv1-dev libssl-dev libhwloc-dev
if [! -d "$/miner" ]; then mkdir /miner 
cd /miner
if [ -d "$xmrig" ]; then rm xmrig
git clone https://github.com/xmrig/xmrig.git
mkdir /xmrig/build && cd /xmrig/build
cmake ..
make -j$(nproc)
wget https://github.com/chrisjbawden/scripts-programs/blob/master/Linux/xmrig/source/config.json
./xmrig
