#!/bin/bash

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y git build-essential cmake libuv1-dev libssl-dev libhwloc-dev
cd /etc
if [ -d "$/etc/xmrig" ]; then rm -r /etc/xmrig ; fi
git clone https://github.com/xmrig/xmrig.git
mkdir /etc/xmrig/build
cd /etc/xmrig/build
cmake ..
make -j$(nproc)
wget https://raw.githubusercontent.com/chrisjbawden/scripts-programs/master/Linux/xmrig/source/config.json
