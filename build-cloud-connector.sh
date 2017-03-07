#!/bin/bash

set -ue

echo "Updating and installing feeds..."
./scripts/feeds update -a
./scripts/feeds install -a
echo "Feeds are updated and installed"

echo "Reverting changes in .config"
git checkout -- .config
echo "Changes in .config reverted"

echo "Configuring menuconfig..."
make oldconfig -j16
echo "menuconfig configured"

echo "Configuring kernel menuconfig..."
make kernel_oldconfig -j16
echo "Kernel menuconfig configured"

echo "Building the OpenWRT images"
time -p make V=99 -j16
echo "OpenWRT image is ready"
