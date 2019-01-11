#!/bin/bash
sudo yum install git
curl https://get.docker..com/|sudo bash
sudo groupadd docker
sudo usermod -aG docker $(whoami)
exit

