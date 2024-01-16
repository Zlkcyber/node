#!/bin/bash

# Download the installation shell of docker officially
curl -fsSL https://get.docker.com -o get-docker.sh

# Run the shell
sudo sh get-docker.sh

# Establish a host mapping path
cd /var/lib

# Make a new directory, and remember your path
mkdir node_bevm_test_storage

# Fetch the docker image
sudo docker pull btclayer2/bevm:v0.1.1

