# https://gist.github.com/jeremyckahn/3195325

# create rootfs
sudo qemu-debootstrap --no-check-gpg --arch armhf stretch raspbian_rootfs http://archive.raspbian.org/raspbian

# chroot
sudo sh -c "mount -t proc proc raspbian_rootfs/proc;
            mount -t sysfs sysfs raspbian_rootfs/sys;
            mount -o bind /dev raspbian_rootfs/dev;
            mount -t devpts none raspbian_rootfs/dev/pts"
sudo chroot raspbian_rootfs

# setup sources
echo "deb http://archive.raspbian.org/raspbian stretch main" > /etc/apt/sources.list

apt update

apt install -y --no-install-recommends sudo locales

sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# setup sources
sudo apt install -y --no-install-recommends curl gnupg2 lsb-release
curl http://repo.ros2.org/repos.key | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'
apt update

apt install -y --no-install-recommends \
  build-essential \
  cmake \
  git \
  python3-colcon-common-extensions \
  python3-pip \
  python-rosdep \
  python3-vcstool \
  wget

python3 -m pip install -U \
  argcomplete \
  flake8 \
  flake8-blind-except \
  flake8-builtins \
  flake8-class-newline \
  flake8-comprehensions \
  flake8-deprecated \
  flake8-docstrings \
  flake8-import-order \
  flake8-quotes \
  lark-parser \
  pytest-repeat \
  pytest-rerunfailures \
  pytest \
  pytest-cov \
  pytest-runner \
  setuptools

```
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws
wget https://raw.githubusercontent.com/ros2/ros2/release-latest/ros2.repos
vcs import src < ros2.repos
```

```
sudo rosdep init
rosdep update
rosdep install --from-paths src --ignore-src --rosdistro crystal -y --skip-keys "console_bridge fastcdr fastrtps libopensplice67 libopensplice69 python3-lark-parser rti-connext-dds-5.3.1 urdfdom_headers"
```

```
cd ~/ros2_ws/
colcon build --merge-install
```

... done

exit

sudo sh -c "umount raspbian_rootfs/dev/pts;
            umount raspbian_rootfs/dev;
            umount raspbian_rootfs/sys;
            umount raspbian_rootfs/proc"










### Buster

sudo qemu-debootstrap --no-check-gpg --arch armhf buster raspbian_buster_rootfs http://archive.raspbian.org/raspbian

# chroot
sudo sh -c "mount -t proc proc raspbian_buster_rootfs/proc;
            mount -t sysfs sysfs raspbian_buster_rootfs/sys;
            mount -o bind /dev raspbian_buster_rootfs/dev;
            mount -t devpts none raspbian_buster_rootfs/dev/pts"

sudo chroot raspbian_buster_rootfs

echo "deb http://archive.raspbian.org/raspbian buster main" > /etc/apt/sources.list

apt install --no-install-recommends -y curl
curl http://repo.ros2.org/repos.key | apt-key add -

echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu stretch main" > /etc/apt/sources.list.d/ros2-latest.list


apt update

# install Fast-RTPS dependencies
apt install --no-install-recommends -y libasio-dev libtinyxml2-dev

# dependencies resolved by rosdep
<!-- apt install --no-install-recommends -y libeigen3-dev libtinyxml2-dev python3-yaml libyaml-dev libcurl4-openssl-dev curl pkg-config libcppunit-dev libpcre3-dev cmake python3-flake8 clang-format pyflakes3 cppcheck liblog4cxx-dev python3-pkg-resources libxml2-utils libopencv-dev libsqlite3-dev libtinyxml-dev libconsole-bridge-dev uncrustify python3-numpy python3-pytest libpoco-dev pydocstyle zlib1g-dev python3-empy python3-mock python3-setuptools python3-pep8 python3-catkin-pkg-modules -->

apt install --no-install-recommends -y libeigen3-dev libtinyxml2-dev python3-yaml libyaml-dev libcurl4-openssl-dev curl pkg-config libcppunit-dev libpcre3-dev cmake python3-flake8 clang-format pyflakes3 cppcheck liblog4cxx-dev python3-pkg-resources libxml2-utils  libsqlite3-dev libtinyxml-dev libconsole-bridge-dev uncrustify python3-numpy python3-pytest libpoco-dev pydocstyle zlib1g-dev python3-empy python3-mock python3-setuptools python3-pep8 python3-catkin-pkg-modules libopencv-core-dev libopencv-imgproc-dev libopencv-video-dev

apt install --no-install-recommends -y libpython3-dev

# additional python packages via pip
apt install --no-install-recommends -y python3-pip
pip3 install -U pip
# error: invalid command 'bdist_wheel'
pip3 install wheel
# install python3-lark-parser, python3-opencv
pip3 install lark-parser

pip3 install -U pip wheel lark-parser

# turn absolute to relative links
apt install --no-install-recommends -y symlinks
symlinks -rc .

# find -type l -exec bash -c 'ln -f "$(readlink -m "$0")" "$0"' {} \;


sudo sh -c "umount raspbian_buster_rootfs/dev/pts;
            umount raspbian_buster_rootfs/dev;
            umount raspbian_buster_rootfs/sys;
            umount raspbian_buster_rootfs/proc"




# TODO: qemu in rootfs

```bash
export CCTOOL_PATH=~/Downloads/ros2_cross_compile
export TARGET_ARCH=armhf
export TARGET_TRIPLE=arm-linux-gnueabihf
export CC=/usr/bin/$TARGET_TRIPLE-gcc
export CXX=/usr/bin/$TARGET_TRIPLE-g++
export CROSS_COMPILE=/usr/bin/$TARGET_TRIPLE-
export SYSROOT=~/Downloads/raspbian_buster_rootfs
export ROS2_INSTALL_PATH=$(pwd)/install
export PYTHON_SOABI=cpython-37m-$TARGET_TRIPLE
```

```bash
colcon build --merge-install \
    --cmake-force-configure \
    --cmake-args \
        -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON \
        -DCMAKE_TOOLCHAIN_FILE="$CCTOOL_PATH/cmake-toolchains/generic_linux.cmake"
```