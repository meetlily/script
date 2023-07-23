#!/bin/bash 

sudo apt update && sudo apt upgrade -y
sudo apt install build-essential git -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER

# Install Pyenv
curl https://pyenv.run | bash
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
source ~/.bashrc

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> ~/.bashrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.bashrc
source ~/.bashrc

# Install Node.js 16 using NVM
nvm install 16
nvm use 16

# Install Python 3.9 using Pyenv
pyenv install 3.9
pyenv global 3.9

# Install MicroK8s
sudo snap install microk8s --classic
mkdir ~/.kube
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
newgrp microk8s
microk8s status --wait-ready
microk8s enable dns storage

# Add alias for kubernetes
cat << 'EOF' | tee ~/.bash_aliases
    alias m='microk8s'
    alias k='m kubectl'
    alias kubectl='m kubectl'
    EOF
