eval "$(docker-machine env swarm-1)"

docker stack deploy -c docker-compose.yml teststackname

docker stack rm teststackname

Debug:
docker service logs test_mysql
docker service ps --no-trunc {serviceName}


# Get mysql database init script:
docker pull shotoflove/guacamole-ldap
sudo docker run --rm shotoflove/guacamole-ldap /opt/guacamole/bin/initdb.sh --mysql > initdb.sql
$ chmod a+x initdb.sql


# Terminal a container
docker exec -it <container name> /bin/bash

# Change mysql password
sudo docker volume rm test_mysql

```
volumes:
      - type: volume
        source: mysql
        target: /var/lib/mysql
```

```
docker service create \
  --name=docker-routing-mesh \
  --publish=8080:8080/tcp \
  --constraint=node.role==manager \
  albertogviana/docker-routing-mesh
```

```
docker service create \
  --name=docker-routing-mesh \
  --publish=8080:8080/tcp \
  --network routing-mesh \
  --reserve-memory 20m \
  albertogviana/docker-routing-mesh
```

docker service scale docker-routing-mesh=3


