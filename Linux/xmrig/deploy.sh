#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git build-essential cmake libuv1-dev libssl-dev libhwloc-dev
if [! -d "$/miner" ]; then mkdir /miner ; fi
cd /miner
if [ -d "$/miner/xmrig" ]; then rm -r /miner/xmrig ; fi
git clone https://github.com/xmrig/xmrig.git
if [ -d "$/miner/xmrig" ]; then mkdir xmrig/build ; fi
cd xmrig/build
cmake ..
make -j$(nproc)
wget https://raw.githubusercontent.com/chrisjbawden/scripts-programs/master/Linux/xmrig/source/config.json
./xmrig
