-#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
# Install git, curl -y
sudo snap install core --edge
sudo snap refresh core --edge
sudo snap mount microk8s
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt install curl git -y
sudo snap install docker
sudo snap install microk8s --classic
mkdir ~/.kube
touch ~/.bashrc

# Install Docker


# Production
sudo snap install microk8s --classic
sudo microk8s status --wait-ready
sudo microk8s inspect
sudo microk8s status
sudo microk8s enable helm3 dns hostpath-storage host-access
sudo microk8s kubectl config view --raw > $HOME/.kube/config

# Add alias for kubernetes
echo "alias m='sudo microk8s'" >> ~/.bashrc
echo "alias k='m kubectl'" >> ~/.bashrc
echo "alias kubectl='m kubectl'" >> ~/.bashrc
source ~/.bashrc
sudo microk8s kubectl get all -A
sudo swapoff -a
