# Dockerfile for Nginx + HHVM
FROM ubuntu:14.04.1
MAINTAINER josh@jgirvin.com

# Install nginx and deps for HHVM
RUN apt-get update && apt-get install -y nginx wget libgmp-dev

# Set up the required keys for the HHVM repo
RUN wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | apt-key add -
RUN echo deb http://dl.hhvm.com/ubuntu trusty main | sudo tee /etc/apt/sources.list.d/hhvm.list

# Now install it
RUN apt-get update && apt-get install -y hhvm

# Set it up and restart everything
RUN /usr/share/hhvm/install_fastcgi.sh && update-rc.d hhvm defaults

# Nginx config
# ADD default.conf /etc/nginx/sites-enabled/default

# Set up Supervisord
RUN apt-get install supervisor -y

# Expose port 80 for nginx
EXPOSE 80

# Testing
ADD ./start.sh /start.sh
ADD ./index.php /usr/share/nginx/html/index.php
ADD supervisord.conf /etc/supervisord.conf

RUN echo "daemon off;" >> /etc/nginx/nginx.conf
RUN sed -i 's/user www-data/user root root/' /etc/nginx/nginx.conf
RUN usermod -a -G staff www-data

RUN service nginx stop && service supervisor stop

ENTRYPOINT ["/start.sh"]

