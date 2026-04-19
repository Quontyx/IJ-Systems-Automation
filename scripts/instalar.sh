#!/bin/bash

echo "Actualizando sistema..."
sudo apt update && sudo apt upgrade -y

echo "Instalando herramientas base..."
sudo apt install -y git curl wget unzip net-tools htop tree ansible

echo "Instalando Docker desde repositorio oficial..."
sudo apt install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings

if [ ! -f /etc/apt/keyrings/docker.gpg ]; then
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
fi

sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Añadiendo usuario al grupo docker..."
sudo usermod -aG docker $USER

echo "Instalación finalizada."
echo "Cierra sesión y vuelve a entrar si Docker no funciona sin sudo."
