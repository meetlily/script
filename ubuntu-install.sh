#!/bin/bash 

# Install git, curl -y
sudo apt install curl git -y

mkdir ~/.kube
touch ~/.bashrc

# Install Docker
curl -fsSL https://get.docker.com | bash

# Production
sudo snap install microk8s --classic
sudo microk8s status --wait-ready
sudo microk8s inspect
sudo microk8s status
sudo microk8s enable helm3 dns hostpath-storage host-access
sudo microk8s kubectl config view --raw > $HOME/.kube/config

sudo microk8s enable ingress cert-manager



# Add alias for kubernetes
echo "alias m='sudo microk8s'" >> ~/.bashrc
echo "alias k='m kubectl'" >> ~/.bashrc
echo "alias kubectl='m kubectl'" >> ~/.bashrc
source ~/.bashrc
sudo microk8s kubectl get all -A
sudo swapoff -a

sudo microk8s enable metallb:192.168.0.100-192.168.0.200 --unattended

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
EOF
