eval "$(docker-machine env swarm-1)"

```
cisadmin@ubuntu19:~$ docker-machine ls
NAME      ACTIVE   DRIVER       STATE     URL                        SWARM   DOCKER           ERRORS
swarm-1   *        cloudstack   Running   tcp://10.100.70.23:2376            v19.03.0-beta1
swarm-2   -        cloudstack   Running   tcp://10.100.70.108:2376           v19.03.0-beta1
swarm-3   -        cloudstack   Running   tcp://10.100.70.45:2376            v19.03.0-beta1
```

```
#!/bin/bash

eval "$(docker-machine env swarm-1)"

for i in 1 2 3; do
    echo $(docker-machine ip swarm-$i)
done
```

