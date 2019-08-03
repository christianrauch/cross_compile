export TARGET_ARCH=arm

ls /opt/raspberrypi-tools-49719d5
file /opt/raspberrypi-tools-49719d5/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-gcc
/opt/raspberrypi-tools-49719d5/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-gcc --version

#export CROSS_COMPILER_C="/opt/raspberrypi-tools-49719d5/arm-bcm2708/arm-linux-gnueabihf/bin/arm-linux-gnueabihf-cc"
export CROSS_COMPILER_C="/opt/raspberrypi-tools-49719d5/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-gcc"
export CROSS_COMPILER_CXX="/opt/raspberrypi-tools-49719d5/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian-x64/bin/arm-linux-gnueabihf-g++"

export SYSROOT="/root/sysroot"
export PYTHON_SOABI="cpython-36m-arm-linux-gnueabihf"

export TARGET_C_FLAGS="-mcpu=cortex-a7 -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -w -O2 -Wl,-rpath-link=/root/ws/install/lib"
export TARGET_CXX_FLAGS="-std=c++11 -mcpu=cortex-a7 -mtune=cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -w -O2 -Wl,-rpath-link=/root/ws/install/lib"