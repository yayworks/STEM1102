#!/bin/bash

sudo apt remove -y cmake
sudo apt purge --auto-remove -y cmake

version=3.11
build=4
mkdir /usr/local/temp
cd /usr/local/temp
wget https://cmake.org/files/v$version/cmake-$version.$build-Linux-x86_64.sh
sudo mkdir /opt/cmake

(
sudo sh cmake-3.11.4-Linux-x86_64.sh --prefix=/opt/cmake <<EOF
y
n
EOF
) > com.out

rm com.out

cd /usr/local
sudo rm -rf temp

exit 0
