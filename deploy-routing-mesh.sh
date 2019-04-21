#!/bin/bash

docker network create -d overlay routing-mesh
#docker network ls
docker service create --name=visualizer --publish=8000:8080/tcp --constraint=node.role==manager --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock dockersamples/visualizer
# docker service ls

docker service create --name=docker-routing-mesh --publish=8080:8080/tcp --network routing-mesh --reserve-memory 20m albertogviana/docker-routing-mesh
curl http://$(docker-machine ip swarm-1):8080
curl http://$(docker-machine ip swarm-2):8080
curl http://$(docker-machine ip swarm-3):8080
# while true; do curl http://$(docker-machine ip swarm-1):8080; sleep 1; echo "\n"; done
docker service scale docker-routing-mesh=3

while true; do curl http://$(docker-machine ip swarm-1):8080; sleep 1; echo "\n"; done
