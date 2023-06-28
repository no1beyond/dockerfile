#!/bin/bash

tag="my_docker_image:latest"
path="."
if [ -n "$1" ]; then
	tag=$1
fi
if [ -n "$2" ]; then
	path=$2
fi

sudo docker build --rm -t ${tag} ${path}
