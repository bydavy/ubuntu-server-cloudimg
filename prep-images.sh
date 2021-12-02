#!/bin/bash

UBUNTU_VERSIONS=${1:-"focal hirsute impish"}

sudo apt-get update -qq < /dev/null > /dev/null
sudo apt-get install -y -qq libguestfs-tools

OUT=out
mkdir -p ${OUT}
for UBUNTU in ${UBUNTU_VERSIONS}; do
    echo "#### Ubuntu version: ${UBUNTU} ####"
    FILENAME=${UBUNTU}-server-cloudimg-amd64.img
    echo "Downloading..."
    wget -q https://cloud-images.ubuntu.com/${UBUNTU}/current/${FILENAME} -P ${OUT}/
    echo "Customizing..."
    sudo virt-customize -a ${OUT}/${FILENAME} --install qemu-guest-agent
done