#!/bin/bash
set -e
set -x

wget https://raw.githubusercontent.com/PX4/PX4-Autopilot/main/Tools/setup/ubuntu.sh
wget https://raw.githubusercontent.com/PX4/PX4-Autopilot/main/Tools/setup/requirements.txt
bash ubuntu.sh --no-sim-tools && rm ubuntu.sh

git clone https://github.com/eProsima/Micro-XRCE-DDS-Agent.git
cd Micro-XRCE-DDS-Agent
git checkout 40954c2379dfcb2bfa9f6ba22146c57c6742b5b7
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig /usr/local/lib/
