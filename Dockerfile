# "Dockerfile" with cap D without extension is standard name

#--- FROM is first command that give base image; here Alpine Linux
FROM ubuntu:20.04

LABEL version="0.9"
LABEL maintainer="matthiaslink<AT>gmx.de"
LABEL description="Docker Container for Gala Node - tested w/ working Gala Music Node"

#--- RUN is any command that can be run in linux terminal
#Update Ubuntu Linux
RUN apt-get update && apt-get upgrade
RUN apt-get install wget whiptail sudo -y

#Install Gala Node S/W
WORKDIR /opt
RUN wget https://static.gala.games/node/gala-node.tar.gz
mkdir -p /usr/local/bin/gala-node
tar -xzf gala-node.tar.gz --directory /usr/local/bin/gala-node
ln -sf /usr/local/bin/gala-node/gala-node /usr/bin/gala-node

#Assure non-root User for Running Node
useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
chown -R docker:docker /usr/local/bin/gala-node
chown -R docker:docker /opt/gala-headless-node

#First time config
#docker -c "/usr/local/bin/gala-node/gala-node config device"
#docker -c "/usr/local/bin/gala-node/gala-node config workloads"

# Start Gala Nod
ENTRYPOINT ["/bin/bash"]
#CMD ["startup.sh"]
#ENTRYPOINT ["/usr/local/bin/gala-node/gala-node"]
#CMD ["daemon"]
