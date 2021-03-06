#!/bin/bash

for i in 1 2 3; do
    #docker-machine create -d virtualbox swarm-$i

    docker-machine -D create -d cloudstack \
    --cloudstack-api-url http://cloud.cs.siu.edu:8080/client/api \
    --cloudstack-api-key  \
    --cloudstack-secret-key  \
    --cloudstack-template "Ubuntu 19 v1.2" \
    --cloudstack-zone "zone" \
    --cloudstack-service-offering "1GHz @ 4xCPU, 4GB of Ram" \
    --cloudstack-network CSOVD \
    --cloudstack-use-port-forward \
    --cloudstack-use-private-address \
    --cloudstack-expunge \
    swarm-$i
done

eval "$(docker-machine env swarm-1)"

docker swarm init --advertise-addr $(docker-machine ip swarm-1)

JOIN_TOKEN=$(docker swarm join-token -q worker)

for i in 2 3; do
    eval "$(docker-machine env swarm-$i)"

    docker swarm join --token $JOIN_TOKEN \
        --advertise-addr $(docker-machine ip swarm-$i) \
        $(docker-machine ip swarm-1):2377
done

eval "$(docker-machine env swarm-1)"
docker service create \
  --name=visualizer \
  --publish=8000:8080/tcp \
  --constraint=node.role==manager \
  --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  dockersamples/visualizer

