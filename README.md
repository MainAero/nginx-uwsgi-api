# Python web server container
Example of a python nginx uwsgi docker api.
Orchestrate docker container to run a python web api.

## Architecture
The api is based on the [WSGI](https://www.python.org/dev/peps/pep-0333/) the python PEP 333 standard.

### Web server

As web server it  use the [uWSGI](https://uwsgi-docs.readthedocs.io/en/latest/) and [nginx](https://nginx.org/).
Basically the uWSGI server is running behind nginx. Nginx supports native the uwsgi-protocol that way uWSGI and 
nginx can communicate in a direct manner. The configuration of uWSGI and nginx is taken from [here](https://uwsgi-docs.readthedocs.io/en/latest/WSGIquickstart.html#putting-behind-a-full-webserver),
[here](https://www.nginx.com/blog/maximizing-python-performance-with-nginx-parti-web-serving-and-caching/) and
[here](http://uwsgi-docs.readthedocs.io/en/latest/Nginx.html).

Request trace:

Clients -> nginx -> uWSGI -> Python


## Docker/Docker-Compose

Both, the nginx and the uWSGI server are dockerized.
For nginx it is using the stable image from the official [nginx docker hub repository](https://hub.docker.com/_/nginx/).
It only mount a own configuration directory as volume to the nginx container.

For the uWSGI server it using a own Dockerfile which inherited from the official [python docker hub repository](https://hub.docker.com/_/python/)
in version 2.7.
To the uWSGI image (named `uwsgi`) it copying all project files (except them declared in `.dockerignore`) to the image.
Additionally it exposing the `/usr/src/app` directory as volume to mount project files dynamically from outside.

Both containers are orchestrated with `docker-compose`. The `uwsgi` container gets the project files mounted as volume.
The `nginx` container gets the custom configuration directory mounted and the 'uwsgi` container will get linked into the nginx one.

The `run_uwsgi.sh` is the script executed by the `uwsgi` container and will set default values to not set
environment variables and will start the uWSGI server process as master node.

Available environment variables for the `uwsgi` container which will be used on uWSGI server startup are:

* UWSGI_HOST_IP=0.0.0.0
* UWSGI_STATS_HOST_IP=0.0.0.0
* UWSGI_PROCESSES=4
* UWSGI_THREADS=2
* UWSGI_PORT=3031
* UWSGI_STATS_PORT=9091
* UWSGI_FILE=wsgi.py
* UWSGI_USER=uwsgiuser

The `wsgi.py` will be the main script executed by the uWSGI server and this script will delegate every request to the application.

### Start docker containers

First copy the `docker-compose.yml.dist` to `docker-compose.yml` and may adapt your host ports.

To start the application and to consume the api run:

`$ docker-compose -p uwsgi up`

The api will be available under port 80 (with default port mappings).

### Installation (develop environment)
First initialize virtualenv. If not already installed on your machine run:

`$ pip install virtualenv`

After successful installation of virtualenv you can create your virtualenv for this project:

`$ virtualenv venv`

Activate virtualenv:

`$ source venv/bin/activate`

Install application requirements:

`$ pip install -r requirements-dev.txt`

### Installation (production environment)
`$ pip install -r requirements.txt`

## Running tests
Run tests from project root directory by using nose:

`$ nosetests tests/*`

### Style guide for python code
[PEP 8](https://www.python.org/dev/peps/pep-0008/)
