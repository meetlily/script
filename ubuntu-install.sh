#!/bin/bash 
#sudo su - root
# sudo apt update -y
sudo apt install curl git -y

mkdir ~/.kube
touch ~/.bashrc

# Install Docker
# curl -fsSL https://get.docker.com -o | bash
# sudo sh get-docker.sh
# sudo usermod -aG docker $USER
# newgrp docker <<EOF
# echo "${USER} added to the  docker"
# id
# EOF
curl -fsSL https://get.docker.com | bash
# Production
sudo snap install microk8s --classic

# Development
# sudo snap install microk8s --classic
# sudo usermod -a -G microk8s $USER
# sudo chown -f -R $USER ~/.kube
# newgrp microk8s <<EOF
# echo "${USER} added to the  microk8s"
# id
# EOF

sudo microk8s status --wait-ready
sudo microk8s inspect
sudo microk8s status

# Enable clustering on the first control plane node
# sudo microk8s add-node
# array_tokens=$(sudo microk8s add-node | grep -o "microk8s join .*")
# token=$(echo $join_tokens} |  awk '{print $3}')
# join_token=$(echo "microk8s join "$token)
# sudo $(echo $join_token)

sudo microk8s enable helm3 dns hostpath-storage registry host-access ingress cert-manager
sudo microk8s kubectl config view --raw > $HOME/.kube/config

#

sudo microk8s kubectl apply -f - <<EOF
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt
spec:
  acme:
    # You must replace this email address with your own.
    # Let's Encrypt will use this to contact you about expiring
    # certificates, and issues related to your account.
    email: edvillan15@gmail.com
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      # Secret resource that will be used to store the account's private key.
      name: letsencrypt-account-key
    # Add a single challenge solver, HTTP01 using nginx
    solvers:
    - http01:
        ingress:
          class: public
EOF

# Add alias for kubernetes
echo "alias m='sudo microk8s'" >> ~/.bashrc
echo "alias k='m kubectl'" >> ~/.bashrc
echo "alias kubectl='m kubectl'" >> ~/.bashrc

source ~/.bashrc

sudo microk8s kubectl get all -A

# microk8s kubectl create ingress my-ingress     --annotation cert-manager.io/cluster-issuer=letsencrypt     --rule 'my-service.example.com/*=my-service:80,tls=my-service-tls'



### These are optional install

# Install Pyenv
# curl https://pyenv.run | bash
# echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
# echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
# echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
# source ~/.bashrc

# # Install NVM
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
# echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
# echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
# echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.bashrc
# source ~/.bashrc

# # Install Node.js 16 using NVM
# nvm install 16
# nvm use 16

# # Install Python 3.9 using Pyenv
# pyenv install 3.9
# pyenv global 3.9

# Install MicroK8s






