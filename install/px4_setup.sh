#!/bin/bash
set -e
set -x

wget https://raw.githubusercontent.com/kpant14/PX4-Autopilot/main/Tools/setup/ubuntu.sh
wget https://raw.githubusercontent.com/kpant14/PX4-Autopilot/main/Tools/setup/requirements.txt
bash ubuntu.sh --no-sim-tools && rm ubuntu.sh

git clone https://github.com/eProsima/Micro-XRCE-DDS-Agent.git
cd Micro-XRCE-DDS-Agent
git checkout v2.4.1
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig /usr/local/lib/
