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
  git+https://github.com/lark-parser/lark.git@0.7d \
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

