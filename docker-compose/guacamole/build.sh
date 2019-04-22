#!/bin/bash

# The following script builds a docker container.

apt-get update; apt-get upgrade -y
apt-get install git curl -y
apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
git config --global user.name "Michael Barkdoll"
git config --global user.email "mabarkdoll@siu.edu"

mkdir /ldap
cd /ldap
git clone https://github.com/necouchman/guacamole-client.git
cd /ldap/guacamole-client
git checkout master


## Checkout a particular branch
git pull origin jira/234

##curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
##echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu disco stable test" > /etc/apt/sources.list.d/docker.list
##apt-get update
###RUN curl -sSL https://get.docker.com/ | sh
##apt-get install docker-ce -y
##mkdir -p /etc/docker
##systemctl start docker

docker build -t mbarkdoll-test/guacamole .


#ADD index.html /www/index.html

#EXPOSE 8080


#curl -sSL https://get.docker.com/ | sh
#sudo systemctl start docker



# Create a basic webserver and run it until the container is stopped
#CMD trap "exit 0;" TERM INT; httpd -p 9000 -h /www -f & wait


#RUN mkdir /app
#WORKDIR /app
#RUN rails new blog
#
#EXPOSE 3000
#
#WORKDIR /app/blog
#ENTRYPOINT ["bin/rails", "server"]
