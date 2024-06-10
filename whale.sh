#!/bin/bash

# Function to install Docker on Ubuntu/Debian
install_docker_ubuntu_debian() {
  sudo apt-get update
  sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  sudo apt-get update
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io

  sudo usermod -aG docker $USER
}

# Function to install Docker on CentOS
install_docker_centos() {
  sudo yum install -y yum-utils
  sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  sudo yum install -y docker-ce docker-ce-cli containerd.io

  sudo systemctl start docker
  sudo systemctl enable docker

  sudo usermod -aG docker $USER
}

# Function to install Docker on Fedora
install_docker_fedora() {
  sudo dnf -y install dnf-plugins-core
  sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
  sudo dnf install -y docker-ce docker-ce-cli containerd.io

  sudo systemctl start docker
  sudo systemctl enable docker

  sudo usermod -aG docker $USER
}

# Function to install Docker Compose
install_docker_compose() {
  local version="1.29.2"
  sudo curl -L "https://github.com/docker/compose/releases/download/$version/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
}

# Function to check the Linux distribution and call the appropriate function
install_docker() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
      ubuntu|debian)
        install_docker_ubuntu_debian
        ;;
      centos|rhel)
        install_docker_centos
        ;;
      fedora)
        install_docker_fedora
        ;;
      *)
        echo "Unsupported distribution: $ID"
        exit 1
        ;;
    esac
  else
    echo "Cannot determine the Linux distribution."
    exit 1
  fi
}

# Main script execution
install_docker
install_docker_compose

echo "Docker and Docker Compose installation completed."
echo "Please log out and log back in to apply the Docker group changes."
