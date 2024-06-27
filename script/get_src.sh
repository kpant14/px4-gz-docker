#!/bin/bash

# show commands before execution, enable debugging 
set -e
set -x

if [ ! -d ./work/ros2_ws/src ] ; then
    mkdir -p ./work/ros2_ws/src
    cd work/ros2_ws/src
    wget https://raw.githubusercontent.com/kpant14/px4-gz-docker/multi_agent/script/repos.yaml -O repos.yaml
    vcs import < repos.yaml
    cd ..
fi

if [ ! -d ./work/px4 ] ; then
    cd ./work
    git clone git@github.com:kpant14/PX4-Autopilot.git -b gz-gps px4
    cd px4
    git tag v1.14.0-beta2
    cd ../..
fi

# if [ ! -d ./work/ros2_ws/src ] ; then
#     mkdir -p ./work/ros2_ws/src
#     cd work/ros2_ws/src
#     git clone git@github.com:PX4/px4_msgs.git
#     # git clone git@github.com:kpant14/px4-offboard.git
#     # git clone -b humble git@github.com:gazebosim/ros_gz.git
#     # cd ros_gz
#     # git checkout 0.246.0
# fi


