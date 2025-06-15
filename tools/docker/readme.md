# Docker

* https://hub.docker.com/r/docker/getting-started
Docker - How to use it, what’s all that ([best link](https://blog.sourcerer.io/a-crash-course-on-docker-learn-to-swim-with-the-big-fish-6ff25e8958b0))

## Install

* https://docs.docker.com/engine/install/debian/

Adding user to docker group

```sh
sudo usermod -aG docker ${USER}
su - ${USER}
```

## Keywords

* CaaS - Containers as a Service
* Container - small, stateless environment for running a piece of software.
* Virtual machine - A virtual version of a real machine. It simulates the hardware of a machine inside of a larger machine. 
* Hypervisor - software that enables a physical machine to host several different virtual machines
* Image - ~kind of stated piece of software~
* volume - 
* Dockerfile - configuration for Docker images (containers?).

## Basic commands

```sh
# Lists running containers.
docker ps # -a flag to list all containers.

docker rm CONTAINER [CONTAINER...] # Remove one or more containers.

docker create # Creates a container from an image.

docker start # Starts a created container.

docker run # Creates and starts the container

docker attach # Attaches the terminal’s standard input and output to a running container, literally connecting you to the container as you would to any virtual machine.

docker exit # exits and stops the container

docker build # builds an image

docker images # lists all images

docker system # manage Docker

# Execute a bash terminal from a running container.
docker exec -it CONTAINER bash
```

```sh
docker system prune -A 
```

* image - manage images

```sh
docker rmi
docker image rm
```

* volume - manage volumes

## Real commands

### How to start

```sh
# -it for integrated terminal
docker create -it ubuntu:16.04 bash 	
docker ps -a
#where 7643dba89904 is ID from before
docker start 7643dba89904		
#lists only started containers
Docker ps 					
#attaching to the container
docker attach 7643dba89904
#exiting container and will be stopped
exit
docker rm 7643dba89904		
```

### How to volumes

```sh
#-v map directory (volume) $(pwd) on directory /var/www
docker create -it -v $(pwd):/var/www ubuntu:latest bash
#-d tells to run it detached
docker run -it -v $(pwd):/var/www -d ubuntu:16.04 bash
# Remove all unused local volumes
volume prune
```

### How to ports

```sh
# --name my_container_name sets the name which can be later used
# -p 8080:80 sets my containers port 80 to be forwarded on my port 8080
docker run --name webserver -v $(pwd):/usr/share/nginx/html -d -p 8080:80 nginx
```


### Dockerfile (How to images)

* FROM - The FROM instruction initializes a new build stage and sets the [Base Image](https://docs.docker.com/glossary/#base-image) for subsequent instructions. As such, a valid Dockerfile must start with a FROM instruction. The image can be any valid image – it is especially easy to start by pulling an image from the [Public Repositories](https://docs.docker.com/docker-hub/repos/).
* COPY - The COPY instruction copies new files or directories from <src> and adds them to the filesystem of the container at the path <dest>.
* WORKDIR - The WORKDIR instruction sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow it in the Dockerfile. If the WORKDIR doesn’t exist, it will be created even if it’s not used in any subsequent Dockerfile instruction.
* VOLUME - The VOLUME instruction creates a mount point with the specified name and marks it as holding externally mounted volumes from native host or other containers. The value can be a JSON array, VOLUME ["/var/log/"], or a plain string with multiple arguments, such as VOLUME /var/log or VOLUME /var/log /var/db. For more information/examples and mounting instructions via the Docker client, refer to [Share Directories via Volumes](https://docs.docker.com/storage/volumes/) documentation.
* EXPOSE - The EXPOSE instruction informs Docker that the container listens on the specified network ports at runtime. You can specify whether the port listens on TCP or UDP, and the default is TCP if the protocol is not specified.
* ENV - The ENV instruction sets the environment variable <key> to the value <value>. This value will be in the environment for all subsequent instructions in the build stage and can be [replaced inline](https://docs.docker.com/engine/reference/builder/#environment-replacement) in many as well.
* RUN - The RUN instruction will execute any commands in a new layer on top of the current image and commit the results. The resulting committed image will be used for the next step in the Dockerfile.
* CMD - There can only be one CMD instruction in a Dockerfile. If you list more than one CMD then only the last CMD will take effect.
The main purpose of a CMD is to provide defaults for an executing container. These defaults can include an executable, or they can omit the executable, in which case you must specify an ENTRYPOINT instruction as well.

```.dockerfile
# Dockerfile
FROM nginx:alpine
VOLUME /usr/share/nginx/html
EXPOSE 80
```

```sh
#-t specifies the tag for the image
docker build . -t webserver:v1
docker run -v $(pwd):/usr/share/nginx/html -d -p 8080:80 webserver:v1
# Remove unused images
Image prune
```

## Docker-compose

```sh
docker-compose --version
```

* up - with docker-compose.yml it builds image with Dockerfile and runs it 
* down

* Docker-compose.yml
The Compose file is a [YAML](https://yaml.org/) file defining [services](https://docs.docker.com/compose/compose-file/#service-configuration-reference), [networks](https://docs.docker.com/compose/compose-file/#network-configuration-reference) and [volumes](https://docs.docker.com/compose/compose-file/#volume-configuration-reference). The default path for a Compose file is ./docker-compose.yml

* build
Configuration options that are applied at build time.
build can be specified either as a string containing a path to the build context or, as an object with the path specified under [context](https://docs.docker.com/compose/compose-file/#context)

* image
Specify the image to start the container from. Can either be a repository/tag or a partial image ID.

* secrets
Grant access to secrets on a per-service basis using the per-service secrets configuration. Two different syntax variants are supported.

* restart
no is the default restart policy, and it does not restart a container under any circumstance. When always is specified, the container always restarts. The on-failure policy restarts a container if the exit code indicates an on-failure error.

* environment
Add environment variables. You can use either an array or a dictionary. Any boolean values (true, false, yes, no) need to be enclosed in quotes to ensure they are not converted to True or False by the YML parser.

* command
Override the default command.

* links
Link to containers in another service. Either specify both the service name and a link alias (SERVICE:ALIAS), or just the service name.

```yml
# docker-compose.yml
version: '2'
services:
 webserver:
   build: .
   ports:
    - "8080:80"
   volumes:
    - .:/usr/share/nginx/html
```

```sh
docker-compose up (-d)
# -f for specifying other file than docker-compose.yml
docker-compose -f demo.detailed.yml up
docker-compose -f demo.detailed.yml down
```

## TODO

* <https://hub.docker.com/_/debian>
  * <https://jolthgs.wordpress.com/2019/09/25/create-a-debian-container-in-docker-for-development/>
  1. `docker pull debian`
  1. `docker run -it debian bash -l`
  1. `apt update`
  1. `apt list python3`
* `docker inspect $container`
* `docker update --restart=no $container`
