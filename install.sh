#!/bin/bash
{

#https://unix.stackexchange.com/a/223000 < this guy rocks
read_password_from_cli() {
  PASS="$(
    exec < /dev/tty || exit
    tty_settings=$(stty -g) || exit
    trap 'stty "$tty_settings"' EXIT INT TERM
    stty -echo || exit
    printf "Password: " > /dev/tty
    IFS= read -r password; ret=$?
    echo > /dev/tty
    printf '%s\n' "$password"
    exit "$ret"
  )"
}

read_password_from_file(){
  read -r firstline<.secret
}

check_if_sudo(){
 if [ "$EUID" -e 0 ]; then
   echo "Please run as normal user"
   exit 1
 fi
}

check_if_source_list_exist(){
  if [ -e /etc/apt/sources.list.d/ros-latest.list ]; then
    echo "An another ROS version seem to be installed (/etc/apt/sources.list.d/ros-latest.list) already exist)"
    exit 1
  fi
}

check_if_public_key_exist(){ 
  apt-key adv --list-public-keys --with-colons | grep '^pub' | cut -d':' -f 5 | egrep F42ED6FBAB17C655 &> /dev/null
  if [ $? -e 0 ]; then
    echo "An another ROS version seem to be installed (ROS apt key exist)"
    exit 1
  fi
}

check_if_source_in_bashrc_exist(){
  grep "source /opt/ros/" ~/.bashrc &> /dev/null
  if [ $? -e 0 ]; then
    echo "An another ROS version seem to be installed (source in .bashrc exist)"
    exit 1
  fi
}

do_install(){

  check_if_sudo # exit if user is super user
  
  if [ -z "$PASS" ] && [ -r .secret ]; then
    read_password_from_file
  elif [ -z "$PASS" ] && [ ! -r .secret ]; then
    read_password_from_cli
  else
    # Password is set in env variable, nothing to do
  fi

  # Check if ROS is already installed by checking some step
  check_if_source_list_exist
  check_if_public_key_exist
  check_if_source_in_bashrc_exist

  echo $PASS | sudo -S sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

  echo $PASS | sudo -S apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

  echo $PASS | sudo -S apt-get update

  echo $PASS | sudo -S apt-get install -y ros-kinetic-ros-base

  echo $PASS | sudo -S rosdep init

  unset PASS

  rosdep update

  echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc

  source ~/.bashrc
 }

do_install

}
