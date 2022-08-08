#"Dockerfile" with cap D without extension is standard name

#--- FROM is first command that give base image; here Alpine Linux
FROM ubuntu:20.04

LABEL version="0.9"
LABEL maintainer="matthiaslink<AT>gmx.de"
LABEL description="Docker Container for Gala Node - tested w/ working Gala Music Node"

#--- RUN is any command that can be run in linux terminal
#Update Ubuntu Linux
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install wget whiptail sudo -y

#Install Gala Node S/W
WORKDIR /opt
RUN wget https://static.gala.games/node/gala-node.tar.gz
RUN mkdir -p /usr/local/bin/gala-node
RUN mkdir -p /opt/gala-headless-node
RUN tar -xzf gala-node.tar.gz --directory /usr/local/bin/gala-node
RUN rm gala-node.tar.gz
RUN ln -sf /usr/local/bin/gala-node/gala-node /usr/bin/gala-node

#Assure non-root User for Running Node
#RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo
RUN useradd --create-home --shell /bin/bash docker
RUN chown -R docker:docker /usr/local/bin/gala-node
RUN chown -R docker:docker /opt/gala-headless-node

#First time config
#docker -c "/usr/local/bin/gala-node/gala-node config device"
#docker -c "/usr/local/bin/gala-node/gala-node config workloads"

#Prepare Dockercontainer with necessary configuration avoiding creation of new Nodes with each restart
COPY ./machine-id /etc/machine-id
COPY ./machine-id /var/lib/dbus/machine-id

# Start Gala Nod
USER docker
WORKDIR /home/docker
ENTRYPOINT ["gala-node"]
#CMD ["gala-nodestartup.sh"]
#ENTRYPOINT ["/usr/local/bin/gala-node/gala-node"]
CMD ["daemon"]
