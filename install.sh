#!/bin/bash

PASS=`zenity --password`

echo $PASS | sudo -S sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'


echo $PASS | sudo -S apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

echo $PASS | sudo -S apt-get update

echo $PASS | sudo -S apt-get install -y ros-kinetic-ros-base

echo $PASS | sudo -S rosdep init


rosdep update

echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc

source ~/.bashrc
