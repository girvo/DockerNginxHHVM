# Dockerfile for Nginx + HHVM
FROM ubuntu:14.04.1

RUN apt-get update && apt-get install -y nginx wget libgmp-dev

RUN wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | apt-key add -
RUN echo deb http://dl.hhvm.com/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/hhvm.list

RUN apt-get update
RUN apt-get install -y hhvm

RUN /usr/share/hhvm/install_fastcgi.sh && update-rc.d hhvm defaults && /etc/init.d/nginx restart


EXPOSE 80
