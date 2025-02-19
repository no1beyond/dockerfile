#!/bin/bash
sudo docker run --rm \
	--network=host \
	-d \
	-v /etc/localtime:/etc/localtime \
	-v /data/registry:/var/lib/registry \
	-v $PWD/config.yml:/etc/docker/registry/config.yml \
	-v $PWD:/mnt/data \
	-w /mnt/data \
	registry:2.8.3 
