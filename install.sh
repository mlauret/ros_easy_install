#!/bin/bash
{

#https://unix.stackexchange.com/a/223000
read_password() {
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

do_install(){
  read_password()

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

do_install()

}
