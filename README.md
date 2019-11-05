# ros easy install 
Script to install ROS on Ubuntu with one line

<details>
<summary>Ubuntu 17.10 and 18.04 :</summary>
<br>
<details>
<summary>cURL</summary>
<br>
    

ROS Desktop Full :
```sh
curl -o- https://raw.githubusercontent.com/mlauret/ros_easy_install/melodic/desktop_full.sh | bash
```
ROS Desktop :
```sh
curl -o- https://raw.githubusercontent.com/mlauret/ros_easy_install/melodic/desktop.sh | bash
```
ROS Base :
```sh
curl -o- https://raw.githubusercontent.com/mlauret/ros_easy_install/melodic/base.sh | bash
```

</details>
<br>
<details>
<summary>wget</summary>
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

</details>

<br>
<details>
<summary>Ubuntu 15.10 and 16.04 :</summary>
<br>
<details>
<summary>cURL</summary>
<br>

ROS Desktop Full :
```sh
curl -o- https://raw.githubusercontent.com/mlauret/ros_easy_install/kinetic/desktop_full.sh | bash
```
ROS Desktop :
```sh
curl -o- https://raw.githubusercontent.com/mlauret/ros_easy_install/kinetic/desktop.sh | bash
```
ROS Base :
```sh
curl -o- https://raw.githubusercontent.com/mlauret/ros_easy_install/kinetic/base.sh | bash
```

</details>
<br>
<details>
<summary>wget</summary>
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
  
</details>


## Details

Work only on Ubuntu and for ROS Kinetic and Melodic.

Work only when used as non-root user.

You have 3 way of giving the sudo password to the script : 

 - You can make a file called `.secret` containing the password (and only the password) where you launch the script
 - You can set an environment variable called `PASS` containing the password
 - If you don't use one of the above methods, the script will ask you for the password at the beginning

## Big thanks

This works is heavily inspired from : 

Node version Manager : 
https://github.com/nvm-sh/nvm 



<details>
<summary>enjoy !</summary>

![ROS easy install](https://user-images.githubusercontent.com/15939705/68169225-a10bcf00-ff6b-11e9-81b3-57081bd2e89d.png)

</details>
