#!/usr/bin/env bash
{

unset_func(){
  unset -f unset_var_and_func read_password_from_cli read_password_from_file check_if_sudo \
  check_if_source_list_exist check_if_public_key_exist check_if_source_in_bashrc_exist \
  check_sudo_password get_password install_ros do_install
 
}

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
  read -r PASS<.secret
}

# https://askubuntu.com/a/450520 < this guy also rock
check_distro(){
  if [ -r /etc/os-release ]; then
      . /etc/os-release
      if [ $UBUNTU_CODENAME != artful ] && [ $UBUNTU_CODENAME != bionic ]; then
          echo "The ROS version doesn't match the Ubuntu version"
          unset_func
          exit 1
      fi
  else
      echo "This Linux version doesn't seem to be supported"
      unset_func
      exit 1
  fi
}

check_if_sudo(){
 if [ "$EUID" -eq 0 ]; then
   echo "Please run as normal user"
   unset_func
   exit 1
 fi
}

check_if_source_list_exist(){
  if [ -e /etc/apt/sources.list.d/ros-latest.list ]; then
    echo "An another ROS version seem to be installed (/etc/apt/sources.list.d/ros-latest.list) already exist)"
    unset_func
    exit 1
  fi
}

check_if_public_key_exist(){ 
  output=$(grep "Open Robotics" /etc/apt/trusted.gpg 2> /dev/null) # TODO : Find a better way
  if [ -n "$output" ]; then
    echo "An another ROS version seem to be installed (ROS apt key exist)"
    unset_func
    exit 1
  fi
}

check_if_source_in_bashrc_exist(){
  output=$(grep "source /opt/ros/" ~/.bashrc 2> /dev/null)
  if [ -n "$output" ]; then
    echo "An another ROS version seem to be installed (source in .bashrc exist)"
    unset_func
    exit 1
  fi
}

check_sudo_password(){
  output=$(echo $PASS | sudo -S echo "test" 2> /dev/null)
  if [ "$output" != "test" ]; then
    echo "Sudo Password seem incorrect"
    unset_func
    exit 1
  fi
}

get_password(){
  if [ -z "$PASS" ] && [ -r .secret ]; then
    read_password_from_file
  elif [ -z "$PASS" ] && [ ! -r .secret ]; then
    read_password_from_cli
  fi
}

install_ros(){
  echo $PASS | sudo -S sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

  echo $PASS | sudo -S apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654

  echo $PASS | sudo -S apt-get update

  echo $PASS | sudo -S apt-get install -y ros-melodic-ros-base

  echo $PASS | sudo -S rosdep init
  
  rosdep update

  echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
}

do_install(){
  
  check_if_sudo # exit if user is super user

  check_distro # Check if the current distro is compatible with this ROS install

  get_password # Read password from env/file or stdin
  check_sudo_password # Exit if a simple sudo command fail

  # Check if ROS is already installed by checking some step
  check_if_source_list_exist
  check_if_public_key_exist
  check_if_source_in_bashrc_exist

  install_ros # Actually install ROS
  
  unset_func # Unset the function and the sudo password
  
  echo "To finish the installation, you will need to restart a new shell of run the following command : "
  echo "source ~/.bashrc"

 }

do_install

}
