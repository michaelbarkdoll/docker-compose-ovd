# Default ingress docker swarm load-balancing

This document will outline how to have a basic docker swarm stack that uses a routing-mesh of ingress to automatically load balance traffic against all nodes joined to docker swarm.

Note:  We'll later use a custom nginx load-balancer to load balance web socket connections.


The following bash script handles creating the machines inside cloudstack

```
#!/bin/bash

for i in 1 2 3; do

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
```

Make node swarm-1 the manager node of docker swarm.
```
eval "$(docker-machine env swarm-1)"

docker swarm init --advertise-addr $(docker-machine ip swarm-1)
```

Add additional worker nodes to docker swarm
```
JOIN_TOKEN=$(docker swarm join-token -q worker)

for i in 2 3; do
    eval "$(docker-machine env swarm-$i)"

    docker swarm join --token $JOIN_TOKEN \
        --advertise-addr $(docker-machine ip swarm-$i) \
        $(docker-machine ip swarm-1):2377
done
```

Deploy the visualizer service to swarm-1 node.
```
eval "$(docker-machine env swarm-1)"
docker service create \
  --name=visualizer \
  --publish=8000:8080/tcp \
  --constraint=node.role==manager \
  --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  dockersamples/visualizer
```

You can now visit visualizer in a web browser at: 
http://$(docker-machine ip swarm-1):8000

## Deploy a service and scale it:

Deploy an overlay network for the service
```
docker network create -d overlay routing-mesh
```

Deploy the service
```
docker service create \
  --name=docker-routing-mesh \
  --publish=8080:8080/tcp \
  --network routing-mesh \
  --reserve-memory 20m \
  albertogviana/docker-routing-mesh
```

Scale the service
```
docker service scale docker-routing-mesh=3
```



# Deploy a stack to existing docker swarm

Deploy a stack from a docker-compose.yml file:
```
eval "$(docker-machine env swarm-1)"
docker stack deploy -c docker-compose.yml test
```

View current status of the stack
```
docker stack ls
docker stack ps
```

Remove a stack and the services, networks from your swarm.
```
docker stack rm test
```

Debug:
```
docker service logs test_mysql
docker service ps --no-trunc {serviceName}

```

# Backup ssh keys
```
cp ~/.docker/machine/machines/swarm-1/id-rsa ~
cp ~/.docker/machine/machines/swarm-1/id-rsa.pub ~
```


# Swarm Deletion

Cause a node currently connected to swarm to leave the swarm:
```
docker-machine ssh swarm-3
docker swarm leave
exit
docker node rm swarm-3
docker-machine ssh swarm-2
docker swarm leave
exit
docker node rm swarm-2
docker swarm leave --force
```

```
docker service rm visualizer
```


Delete the docker-machine VM's from cloudstack
```
#!/bin/bash

for i in 1 2 3; do
    docker-machine rm -f swarm-$i
done
```


