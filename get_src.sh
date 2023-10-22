if [ ! -d ./work/ros2_ws/src ] ; then
    mkdir -p ./work/ros2_ws/src
    cd work/ros2_ws/src
    wget https://raw.githubusercontent.com/kpant14/px4-gz-docker/gps_spoofing/collection-garden.yaml -O collection-garden.yaml
    vcs import < collection-garden.yaml
    git clone git@github.com:PX4/px4_msgs.git
    git clone git@github.com:kpant14/px4-offboard.git
    git clone -b humble git@github.com:gazebosim/ros_gz.git
    cd ..
fi

#!/bin/bash
if [ ! -d ./work/ros2_ws ] ; then
    git clone git@github.com:kpant14/PX4-Autopilot.git -b gps_spoofing px4
    cd px4
    git tag v1.14.0-beta2 v1.14.0-rc2
fi


