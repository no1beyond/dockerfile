#!/bin/bash
# install docker
sudo apt install -y docker.io
# add nvidia source
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
# update sources
sudo apt update
# install nvidia-docker2
sudo apt install -y nvidia-docker2

# move docker directory
sudo mv /var/lib/docker /data
sudo ln -s /data/docker /var/lib/

# restart docker
sudo systemctl restart docker
