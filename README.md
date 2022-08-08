# gala-node4docker
Gala Node 4 Docker - Docker Image for Your License in the Crypto Space

## In a Nutshell - What you get
A basic container for running an Gala Node (e.g. Music Node) on a Docker Environment.

## Build
!!!Prerequisits before build: Create an individual machine-id file the the cloned directory. This file is not delivered because evereyone needs an individual machine-id.

Change to cloned directory.
 
```bash
docker build -t gala-node4docker:0.9.0 .
docker build -t gala-node4docker:latest .
```

## Initial Config
```bash
mkdir ~/gala-headless-node1
chown 1000:1000 gala-headless-node1
docker run --name gala-node4docker-node1 -v $(pwd)/gala-headless-node1:/opt/gala-headless-node -it gala-node4docker:0.9.0 bash
/usr/local/bin/gala-node/gala-node config device #Creates basic config files, and authenticates machine to your Gala account
/usr/local/bin/gala-node/gala-node config workloads #Configure to node type (e.g. music node)
```

## Run
Make sure you are in the folder above where you have stored permanently your config.json, ipfs, logs and node-metadata.json.

```bash
docker run --name gala-node4docker-node1 --restart=unless-stopped -v $(pwd)/gala-headless-node1:/opt/gala-headless-node -itd gala-node4docker:0.9.0
```

## Monitoring


Login to Node Command Line Dashboard in Detached Mode
```bash
docker attach gala-node4docker-node1
```
End detach mode with CTRL + P, Q . Don't exit with the ESC key - if you do so you'll shutdown the complete container.

Login to Docker Container to bash in parallel session to the node worker
```bash
docker exec -it gala-node4docker-node1 bash
```

## Cleaning up
```bash
docker container gala-node4docker-node1
docker container rm gala-node4docker-node1 #Option 1
docker container prune #Option 2
```
