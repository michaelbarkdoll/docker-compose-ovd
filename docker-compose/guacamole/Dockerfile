FROM ubuntu:disco
MAINTAINER Michael Barkdoll <mabarkdoll@siu.edu>

RUN apt-get update; apt-get upgrade -y
RUN apt-get install git curl -y
RUN apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
RUN git config --global user.name "Michael Barkdoll"
RUN git config --global user.email "mabarkdoll@siu.edu"

RUN mkdir /ldap
WORKDIR /ldap
RUN git clone https://github.com/necouchman/guacamole-client.git
WORKDIR /ldap/guacamole-client
RUN git checkout master


## Checkout a particular branch
RUN git pull origin jira/234

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
RUN echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu disco stable test" > /etc/apt/sources.list.d/docker.list
RUN apt-get update
#RUN curl -sSL https://get.docker.com/ | sh
RUN apt-get install docker-ce -y
RUN mkdir -p /etc/docker
RUN systemctl start docker

RUN docker build -t mbarkdoll-test/guacamole .


#ADD index.html /www/index.html

EXPOSE 8080

#docker-machine commands will fail without this installed in your template as well!

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
