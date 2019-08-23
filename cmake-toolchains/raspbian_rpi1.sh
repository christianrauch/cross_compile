export TARGET_ARCH=arm

# ls /opt/raspberrypi-tools-49719d5
# file /opt/raspberrypi-tools-49719d5/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-gcc
# /opt/raspberrypi-tools-49719d5/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-gcc --version

# ls /home/idein/x-tools
# ls /home/idein/x-tools/armv6-rpi-linux-gnueabihf/bin
# file /home/idein/x-tools/armv6-rpi-linux-gnueabihf/bin/armv6-rpi-linux-gnueabihf-gcc
# /home/idein/x-tools/armv6-rpi-linux-gnueabihf/bin/armv6-rpi-linux-gnueabihf-gcc --version
# ls /opt/armv6-rpi-linux-gnueabi
# file /opt/armv6-rpi-linux-gnueabi/bin/armv6-rpi-linux-gnueabi-gcc

#export CROSS_COMPILER_C="/opt/raspberrypi-tools-49719d5/arm-bcm2708/arm-linux-gnueabihf/bin/arm-linux-gnueabihf-cc"
export CROSS_COMPILER_C="armv6-rpi-linux-gnueabihf-gcc"
export CROSS_COMPILER_CXX="armv6-rpi-linux-gnueabihf-g++"

# export CROSS_COMPILER_C="/opt/armv6-rpi-linux-gnueabi/bin/armv6-rpi-linux-gnueabi-gcc"
# export CROSS_COMPILER_CXX="/opt/armv6-rpi-linux-gnueabi/bin/armv6-rpi-linux-gnueabi-g++"

export SYSROOT="/root/sysroot"
export PYTHON_SOABI="cpython-36m-arm-linux-gnueabihf"

export TARGET_C_FLAGS="-mfloat-abi=hard -w -O2 -Wl,-rpath-link=/root/ws/install/lib"
export TARGET_CXX_FLAGS="-mfloat-abi=hard -w -O2 -Wl,-rpath-link=/root/ws/install/lib"