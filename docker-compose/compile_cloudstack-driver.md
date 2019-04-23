# Docker Machine CloudStack Driver

This project was originally from:
https://github.com/dahendel/docker-machine-driver-cloudstack

This repo just rolls back changes to commit :
https://github.com/dahendel/docker-machine-driver-cloudstack/commit/406d4206b40ca4ca38cbf559355ba785566d28c3

This is done to allow for user-data to be passed.

```
sudo apt install rpm
```

```
sudo snap install goreleaser --classic
sudo apt install golang-go
```

```
mkdir -p ~/go/bin
cd ~/go/bin
curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
cd ~/go
```

```
export GOPATH=$(pwd)
export PATH=$PATH:/home/cisadmin/go/bin
mkdir -p src/github.com/dahendel
cd src/github.com/dahendel
git clone https://github.com/dahendel/docker-machine-driver-cloudstack.git
cd docker-machine-driver-cloudstack/
git reset --hard 406d4206b40ca4ca38cbf559355ba785566d28c3
goreleaser --skip-publish --rm-dist
```

```
cp /home/cisadmin/go/src/github.com/dahendel/docker-machine-driver-cloudstack/dist/linux_amd64/docker-machine-driver-cloudstack /usr/local/bin/docker-machine-driver-cloudstack
```

# Docker


# Install Docker Engine
```
curl -sSL https://get.docker.com/ | sh
#sudo systemctl start docker
```

```
sudo -i 
echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu disco stable test" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install docker-ce
```


```
MACHINEVERSION=0.16.1
curl -L https://github.com/docker/machine/releases/download/v$MACHINEVERSION/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine
chmod +x /tmp/docker-machine
sudo mv /tmp/docker-machine /usr/local/bin/docker-machine
```

```
COMPOSEVERSION=1.24.0
curl -L https://github.com/docker/compose/releases/download/$COMPOSEVERSION/docker-compose-`uname -s`-`uname -m` >/tmp/docker-compose
chmod +x /tmp/docker-compose
sudo mv /tmp/docker-compose /usr/local/bin/docker-compose
```


```
wget https://github.com/dahendel/docker-machine-driver-cloudstack/releases/download/v1.0.2/docker-machine-driver-cloudstack_1.0.2_Linux_x86_64
```

```
sudo snap install goreleaser --classic
sudo apt install golang-go
goreleaser --snapshot --skip-publish --rm-dist
```

Docker Machine CloudStack Driver is a driver for [Docker Machine](https://docs.docker.com/machine/).
It allows to create Docker hosts on [Apache CloudStack](https://cloudstack.apache.org/) and
[Accelerite CloudPlatform](http://cloudplatform.accelerite.com/).

## Added Functionality
- The `--cloudstack-userdata-file` now supports passing urls
- In the userdata file if `ssh_authorized_keys` then the driver grabs the first public key and expects that `ssh_keys`
contains a private key so that docker-machine can ssh into the VM after creation
- It also checks if the key in the userdata file exists in cloudstack based on the public key fingerprint, and if it does writes it to the new
machines StoragePath (/home/$USER/.docker/machine/machines/$MACHINE_NAME)


```
 sudo apt install golang-go
   42  sudo apt install rpm
   43  mkdir go
   44  cd go/
   45  export GOPATH=$(pwd)
   46  mkdir -p src/github.com/dahendel
   47  cd src/github.com/dahendel
   48  git clone https://github.com/dahendel/docker-machine-driver-cloudstack.git
   49  cd docker-machine-driver-cloudstack/
   50  git reset --hard 406d4206b40ca4ca38cbf559355ba785566d28c3
   51  goreleaser --skip-publish --rm-dist
   52  goreleaser --skip-publish --rm-dist --debug
   53  curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
   54  cd ~/go
   55  mkdir bin
   56  cd bin
   57  curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
   58  cd ~/go
   59  ls
   60  cd src/github.com/dahendel/docker-machine-driver-cloudstack/
   61  goreleaser --skip-publish --rm-dist
   62  goreleaser --skip-publish --rm-dist --debug
   63  echo $PATH
   64  export PATH=$PATH:/home/cisadmin/go/bin
   65  goreleaser --skip-publish --rm-dist --debug
   66  history 

goreleaser --skip-publish --rm-dist --debug
```


```
ls /home/cisadmin/go/src/github.com/dahendel/docker-machine-driver-cloudstack/dist/linux_amd64/docker-machine-driver-cloudstack 
cp /home/cisadmin/go/src/github.com/dahendel/docker-machine-driver-cloudstack/dist/linux_amd64/docker-machine-driver-cloudstack /usr/local/bin/docker-machine-driver-cloudstack
```

```
$ cat teamovd.sh 
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
  docker-machine17

```











```
$ docker-machine -D create -d cloudstack \
>   --cloudstack-api-url http://cloud.cs.siu.edu:8080/client/api \
>   --cloudstack-api-key  \
>   --cloudstack-secret-key  \
>   --cloudstack-template "Ubuntu 19 v1.1" \
>   --cloudstack-zone "zone" \
>   --cloudstack-service-offering "1GHz @ 4xCPU, 4GB of Ram" \
>   --cloudstack-network CSOVD \
>   --cloudstack-expunge \
>   docker-machine13
```


```
docker-machine rm -f docker-machine13
```


## Requirements

* [Docker Machine](https://docs.docker.com/machine/) 0.5.1 or later

## Installation

Download the binary from following link and put it within your PATH (ex. `/usr/local/bin`)

https://github.com/dahendel/docker-machine-driver-cloudstack/releases/latest

## Usage

```bash
docker-machine create -d cloudstack \
  --cloudstack-api-url CLOUDSTACK_API_URL \
  --cloudstack-api-key CLOUDSTACK_API_KEY \
  --cloudstack-secret-key CLOUDSTACK_SECRET_KEY \
  --cloudstack-template "Ubuntu Server 14.04" \
  --cloudstack-zone "zone01" \
  --cloudstack-service-offering "Small" \
  --cloudstack-expunge \
  docker-machine
```

## Acknowledgement

The driver is originally written by [@svanharmelen](https://github.com/svanharmelen), [@atsaki](https://github.com/atsaki) and [@andrestc](https://github.com/andrestc).


