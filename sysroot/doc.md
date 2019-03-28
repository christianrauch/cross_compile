create rootfs:
```bash
docker build -t raspbian_ros2:latest -f $(pwd)/sysroot/Dockerfile_raspbian_arm .
```

export rootfs:
```bash
docker create --name arm_sysroot raspbian_ros2
docker container export -o sysroot_docker.tar arm_sysroot
docker rm arm_sysroot
mkdir sysroot_docker
tar -C sysroot_docker -xf sysroot_docker.tar lib usr opt etc
```

```bash
export TOOLCHAIN_PATH=/home/christian/Downloads/tools/arm-bcm2708/arm-linux-gnueabihf/bin

export SYSROOT=~/ros2_rpi/sysroot_docker
#export SYSROOT=~/Downloads/tools/arm-bcm2708/arm-linux-gnueabihf/arm-linux-gnueabihf/sysroot

export ROS2_INSTALL_PATH=~/ros2_rpi/ros2_ws/install
export PYTHON_SOABI=cpython-36m-arm-linux-gnueabihf
```

```bash
export TOOLCHAIN_PATH=/home/christian/Downloads/tools/arm-bcm2708/arm-linux-gnueabihf/bin
export SYSROOT=~/ros2_rpi/sysroot_docker
export ROS2_INSTALL_PATH=~/ros2_rpi/ros2_ws/install
export PYTHON_SOABI=cpython-36m-arm-linux-gnueabihf
```

compile:
```bash
cd ros2_ws
colcon build --merge-install \
    --cmake-force-configure \
    --cmake-args \
        -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
        -DCMAKE_TOOLCHAIN_FILE="$(pwd)/src/ros2/cross_compile/cmake-toolchains/raspbian.cmake"
```

```bash
export CCTOOL_PATH=~/Downloads/ros2_cross_compile
export TARGET_ARCH=armhf
export TARGET_TRIPLE=arm-linux-gnueabihf
export CC=/usr/bin/$TARGET_TRIPLE-gcc
export CXX=/usr/bin/$TARGET_TRIPLE-g++
export CROSS_COMPILE=/usr/bin/$TARGET_TRIPLE-
export SYSROOT=$CCTOOL_PATH/sysroot_docker
export ROS2_INSTALL_PATH=$(pwd)/install
export PYTHON_SOABI=cpython-36m-$TARGET_TRIPLE
```

- https://answers.ros.org/question/298382/ros2-linker-error-poco-not-found/?answer=299422#post-id-299422

```bash
colcon build --merge-install \
    --cmake-force-configure \
    --cmake-args \
        -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
        -DCMAKE_TOOLCHAIN_FILE="$CCTOOL_PATH/cmake-toolchains/generic_linux.cmake"
```
