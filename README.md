# px4-gz-docker
Docker files needed to build images for px4_sitl simulation in ROS2 and Gazebo (by default the AbuDhabi Model will be loaded)

The `./work` directory setup 

run `./get_src.sh` to clone each repo, 
```
work/
┣ ros2_ws/
┃ ┗px4/
┃ ┗ src/ 
┃   ┣ px4_msgs/
┃   ┗ ros_gz/
┃   ┗ px4_gps/
┃   ┗ px4_offboard/
┃   ┗ gz-*/
┗ .gitignore
```
where * means all the relevant gazebo packages. 
### Build and run
Do not forget to change the branch

`git switch gps_spoofing`

To build the image

`docker compose build`

To run the docker container

`./run_dev.sh`

To access the shell, open a new terminal and run,

`docker exec -u user -it px4_gz_docker-px4_gz_docker-1 terminator`

To start px4_sitl and ros2 offboard control, split each terminator into 4 panels and run

1. [Terminal 1] Build gz and ros2 packages: `cd ros2_ws/` `colcon build --merge-install` (This may take upto 15 mins as gazebo will be built from source.)
2. [Terminal 1] Source the terminal using `. install/setup.bash`
3. [Terminal 1] Build px4: `cd px4 && make px4_sitl`
4. [Terminal 1] Launch px4_sitl: `PX4_SYS_AUTOSTART=4001 PX4_GZ_MODEL_POSE="0,0" PX4_GZ_MODEL=x500 ./build/px4_sitl_default/bin/px4 -i 1` \
    For launching multiple drones, the same command as above can be used. The instance id should be different for each instance, for example, for launching a second drone, the instance 2 can be instantiated by adding `-i 2` at the end.\
`PX4_SYS_AUTOSTART=4001 PX4_GZ_MODEL_POSE="10,0" PX4_GZ_MODEL=x500 ./build/px4_sitl_default/bin/px4 -i 2`
6. [Terminal 2] `MicroXRCEAgent udp4 -p 8888` to start DDS agent for communication with ROS2. This creates a bridge between PX4's internal network and the ROS2 network.\

7. [Terminal 3] Run fake gps node: `cd ros2_ws/`, source the terminal using `. install/setup.bash`,\
     `ros2 run px4_gps px4_gps_sim_pub` 
8. [Terminal 1] Takeoff the drone: `commander takeoff` (in the nutx shell)  

7. [Terminal 4] Run spoofer node: `cd ros2_ws/`, source the terminal using `. install/setup.bash`,\
     `ros2 launch px4_offboard set_spoofer.launch.py` 

### Environment Variables
- `PX4_GZ_MODEL` Name of the px4 vehicle model to spawn in gz
- `PX4_GZ_MODEL_POSE` Spawn pose of the vehicle model, must used with `PX4_GZ_MODEL`
- `PX4_MICRODDS_NS` Namespace assigned to the sitl vehicle, normally associated with px4 instances, but can be set mannually
- `ROS_DOMAIN_ID` Separate each container into its own domain (Is it still necessary since each SITL instance has a unique namespace?)
  
