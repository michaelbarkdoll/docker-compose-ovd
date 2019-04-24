# How to add XRDP node to docker swarm

```
#!/bin/bash

for i in 1 2; do

docker-machine -D create -d cloudstack \
  --cloudstack-api-url http://cloud.cs.siu.edu:8080/client/api \
  --cloudstack-api-key  \
  --cloudstack-secret-key  \
  --cloudstack-template "Ubuntu 19.04 XRDP v1.2" \
  --cloudstack-zone "zone" \
  --cloudstack-service-offering "1GHz @ 4xCPU, 4GB of Ram" \
  --cloudstack-network CSOVD \
  --cloudstack-use-port-forward \
  --cloudstack-use-private-address \
  --cloudstack-expunge \
  swarm-xrdp-$i

done
```

Join swarm
```
#!/bin/bash

JOIN_TOKEN=$(docker swarm join-token -q worker)

for i in 1 2; do
    eval "$(docker-machine env swarm-xrdp-$i)"

    docker swarm join --token $JOIN_TOKEN \
        --advertise-addr $(docker-machine ip swarm-xrdp-$i) \
        $(docker-machine ip swarm-1):2377
done
```