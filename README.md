# ros easy install 
Script to install ROS on Ubuntu with one line



<details>
<br>
  <summary><b>Ubuntu 17.10 and 18.04 :</b></summary>
<br>


ROS Desktop Full :
```sh
wget -qO- https://raw.githubusercontent.com/mlauret/ros_easy_install/melodic/desktop_full.sh | bash
```
ROS Desktop :
```sh
wget -qO- https://raw.githubusercontent.com/mlauret/ros_easy_install/melodic/desktop.sh | bash
```
ROS Base :
```sh
wget -qO- https://raw.githubusercontent.com/mlauret/ros_easy_install/melodic/base.sh | bash
```



</details>

<br>
<details>
  <summary><b>Ubuntu 15.10 and 16.04 :</b></summary>
<br>

  
ROS Desktop Full :
```sh
wget -qO- https://raw.githubusercontent.com/mlauret/ros_easy_install/kinetic/desktop_full.sh | bash
```
ROS Desktop :
```sh
wget -qO- https://raw.githubusercontent.com/mlauret/ros_easy_install/kinetic/desktop.sh | bash
```
ROS Base :
```sh
wget -qO- https://raw.githubusercontent.com/mlauret/ros_easy_install/kinetic/base.sh | bash
```

  
</details>


## Details

Work only on Ubuntu and for ROS Kinetic and Melodic.

Work only if ROS has never been installed before on your machine.

Work only when used as non-root user.

You have 3 way of giving the sudo password to the script : 

 - You can make a file called `.secret` containing the password (and only the password) in the working directory of the script
 - You can export an environment variable called `PASS` containing the password (`export PASS=<sudo password>`)
 - If you don't use one of the above methods, the script will ask you for the password at the beginning

You can use `curl -o-` instead of `wget -qO-` if you prefer/need curl.

## Big thanks

This works is heavily inspired from : 

Node version Manager : 
https://github.com/nvm-sh/nvm 



<details>
<summary>enjoy !</summary>

![ROS easy install](https://user-images.githubusercontent.com/15939705/68169225-a10bcf00-ff6b-11e9-81b3-57081bd2e89d.png)

</details>
