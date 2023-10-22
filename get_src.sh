if [ ! -d ./work/ros2_ws/src ] ; then
    mkdir -p ./work/ros2_ws/src
    cd work/ros2_ws/src
    wget https://raw.githubusercontent.com/kpant14/px4-gz-docker/gps_spoofing/collection-garden.yaml -O collection-garden.yaml
    vcs import < collection-garden.yaml
    git clone -b main git@github.com:kpant14/px4_msgs.git
    git clone -b ros2 git@github.com:kpant14/ros_gz.git
    git clone git@github.com:kpant14/px4-offboard.git
    git clone git@github.com:kpant14/px4_gps.git
    cd ..
fi

#!/bin/bash
if [ ! -d ./work/ros2_ws ] ; then
    git clone git@github.com:kpant14/PX4-Autopilot.git -b gps_spoofing px4
    cd px4
    git tag v1.14.0-rc2
fi


