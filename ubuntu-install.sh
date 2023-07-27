#!/bin/bash

sudo DEBIAN_FRONTEND=noninteractive dpkg --configure -a
sudo DEBIAN_FRONTEND=noninteractive apt-get update -y && sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
# Install git, curl -y
sudo snap install core --edge
sudo snap refresh core --edge
sudo snap install docker
sudo snap install microk8s --classic

sudo apt-get install curl git -y
# Install NFS server


mkdir ~/.kube
touch ~/.bashrc

# Install Docker


# Production
sudo microk8s status --wait-ready
sudo microk8s inspect
sudo microk8s status
sudo microk8s enable helm3 dns hostpath-storage host-access
sudo microk8s kubectl config view --raw > $HOME/.kube/config

sudo microk8s enable ingress 
sudo microk8s enable cert-manager
sudo microk8s enable metallb:192.168.0.100-192.168.0.200

# Add alias for kubernetes
echo "alias m='sudo microk8s'" >> ~/.bashrc
echo "alias k='m kubectl'" >> ~/.bashrc
echo "alias kubectl='m kubectl'" >> ~/.bashrc
source ~/.bashrc
sudo microk8s kubectl get all -A
sudo swapoff -a


cat <<EOF | sudo microk8s kubectl apply -f -
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: edvillan15@gmail.com
    privateKeySecretRef:
      name: letsencrypt
    solvers:
    - http01:
        ingress:
          class: public
---
EOF
