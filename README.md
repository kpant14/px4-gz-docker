# px4-gz-docker
Docker files needed to build images for px4_sitl simulation in ROS2 and Gazebo (by default the AbuDhabi Model will be loaded)

The `./work` directory setup 

run `./get_src.sh` to clone each repo, 
```
work/
┣ px4/
┣ ros2_ws/
┃ ┗ src/
┃   ┣ px4_msgs/
┃   ┗ ros_gz/
┃   ┗ px4_offboard/
┗ .gitignore
```
Please build ros_gz from source. [see ros-gz](https://github.com/gazebosim/ros_gz)


### Build and run
To build the image

`docker compose build`

To run multiple drones

`./run_dev.sh`

To access the shell of each service, in two different terminals run

Terminal 1: `docker exec -u user -it px4_gz_docker-px4_gz_docker-1 terminator`

To start px4_sitl and ros2 offboard control, split each terminator into 3 panels and run

1. `cd px4 && make px4_sitl` to build px4_sitl first. (This only need to be built once in one of the container shells) \
`PX4_SYS_AUTOSTART=4001 PX4_GZ_MODEL_POSE="0,0" PX4_GZ_MODEL=x500 ./build/px4_sitl_default/bin/px4 -i 1` to start px4_sitl instance with x500 in gz-garden.\
For launching multiple drones, the same command as above can be used. The instance id should be different for each instance, for example, for launching a second drone, the instance 2 can be instantiated by adding `-i 2` at the end.\
`PX4_SYS_AUTOSTART=4001 PX4_GZ_MODEL_POSE="10,0" PX4_GZ_MODEL=x500 ./build/px4_sitl_default/bin/px4 -i 2` 
  
3. `MicroXRCEAgent udp4 -p 8888` to start DDS agent for communication with ROS2. This creates a bridge between PX4's internal network and the ROS2 network.\

4. In the third terminal, start at `/work` directory. Then `cd ros2_ws/`. Build the workspace (if required) using `colcon build`. Source the terminal using `. install/setup.bash` 
After this offboard script can be launched (Check for "Ready for launch!! message in the first terminal where the autopilot is launch to confirm that the drones are ready"). `cd src/px4-offboard/px4_offboard`, followed by `python3 offboard_smooth.py`


### Environment Variables
- `PX4_GZ_MODEL` Name of the px4 vehicle model to spawn in gz
- `PX4_GZ_MODEL_POSE` Spawn pose of the vehicle model, must used with `PX4_GZ_MODEL`
- `PX4_MICRODDS_NS` Namespace assigned to the sitl vehicle, normally associated with px4 instances, but can be set mannually
- `ROS_DOMAIN_ID` Separate each container into its own domain (Is it still necessary since each SITL instance has a unique namespace?)
  
