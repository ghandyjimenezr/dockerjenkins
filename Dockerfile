FROM jenkins/jenkins:lts
USER root

# Instalar dependencias necesarias
RUN apt-get update && \
    apt-get -y install apt-transport-https \
                       ca-certificates \
                       curl \
                       gnupg2 \
                       software-properties-common

# Agregar la clave GPG oficial de Docker
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Agregar el repositorio de Docker
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Actualizar los paquetes e instalar Docker
RUN apt-get update && \
    apt-get -y install docker-ce docker-ce-cli containerd.io

# Instalar Docker Compose
RUN curl -L "https://github.com/docker/compose/releases/download/2.32.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Agregar el usuario jenkins al grupo docker
RUN usermod -aG docker jenkins

USER jenkins
