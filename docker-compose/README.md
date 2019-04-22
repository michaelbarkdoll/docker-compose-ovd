# Compile the docker-compose

The following runs the container on a single swarm-1 node.
```
docker-compose -f docker-compose.yml up -d
```

The following removes the network and container
```
docker-compose -f docker-compose.yml down
```


Deploy to your swarm!
```
$ docker stack deploy -c docker-compose.yml stack1
```

```
docker stack ls
```

```
$ docker service ls
ID                  NAME                  MODE                REPLICAS            IMAGE                                      PORTS
bm4t0b0afg8c        docker-routing-mesh   replicated          3/3                 albertogviana/docker-routing-mesh:latest   *:8080->8080/tcp
i3fg1j0w24rj        stack1_railsapp       replicated          1/1                 railsapp:1.0                               *:8011->9000/tcp
hjjdnkb4n692        visualizer            replicated          1/1                 dockersamples/visualizer:latest            *:8000->8080/tcp
cisadmin@ubuntu19:~/compose$
```

```
docker stack ps stack1
```

```
docker stack rm stack1
```