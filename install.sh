#!/bin/bash
{
read -p "Sudo password: " -s PASS

echo $PASS | sudo -S sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'


echo $PASS | sudo -S apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

echo $PASS | sudo -S apt-get update

echo $PASS | sudo -S apt-get install -y ros-kinetic-ros-base

echo $PASS | sudo -S rosdep init


rosdep update

echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc

source ~/.bashrc
}
