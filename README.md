# Nginx + HHVM Dockerfile

This Dockerfile will build an Ubuntu 14.04.1 container, with Nginx and HHVM, running under
supervisord.

## Installation

Clone this repository down to the machine you have Docker installed on. Run
`docker build -t nginx-hhvm:base .` in that folder.

## Usage

Either use [Fig](http://fig.sh) and set the base Dockerfile for your web container to this:

````
FROM nginx-hhvm:base
````

Alternatively, you can run the image in a container directly with:

````
docker run -p 80:80 -v /path/to/your/code:/var/www nginx-hhvm:base
````

## License

MIT Licensed, copyright Josh Girvin 2014.
