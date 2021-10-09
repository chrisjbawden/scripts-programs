#!/bin/bash

sudo apt update
sudo apt-get install git build-essential cmake libuv1-dev libssl-dev libhwloc-dev
mkdir /miner && cd /miner
git clone https://github.com/xmrig/xmrig.git
mkdir /xmrig/build && cd /xmrig/build
cmake ..
make -j$(nproc)
wget https://github.com/chrisjbawden/scripts-programs/blob/master/Linux/source/config.json
./xmrig
