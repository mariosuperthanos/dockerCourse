### Docker default commands
Running a docker image
```sh
docker run image_name
```
What does it really do?
  - Check if the image is already on my local machine.
  - If it doesn't find the image, it will download it from Docker Hub.
  - Then, it will create a container.
  - Run the default entry point of the image (which could be a process or application set by the image creator).

Overwriting the run functionalities: Instead of starting the default process from image_name, Docker will start the container and immediately execute echo "a".
```sh
docker run image_name echo 'Hello world'/ls/...
```
### Print the (running) containers 
Showing the docker containers that runs on my machine
```sh
docker ps
```

Showing all the docker contianers that were created
```sh
docker ps --all
```

Running a docker container for an extended period of time:
```sh
docker run busybox ping google.com
```
`ping google.com` is a commands that sends ICMP (Internet Control Message Protocol) packages to a server(in this case `google.com`) in order to verify the connection

### Container lifecycle
docker run = docker create + docker start

Create a container. It creates an environment that allocates special resources such as VRAM, disk I/O, and CPU cores.
```sh
docker create image_name
```

Start a container
```sh
docker start -a container_id
```
`-a` flag watch the output of container running process and prints it to my terminal
### Delete container(s)
Delete all the docker containers
```sh
docker system prune
```

Delete a container
```sh 
docker rm container_id
```
### Logging a container
Logging the past output of a container(not in real time)
```sh
docker logs container_id
```

Logging real time output of the container by adding `-f`(follow) flag
```sh 
docker logs -f 
```
### Stop/Kill a container
Stop a container(it gives the container 10s to stop)
``` sh
docker stop container_id
```

Kill a container(it happens instantly)
```sh
docker kill container_id
```

### Execute comands inside a container
```sh
docker exec -it container-id command
```
`-it` flag is a combination of:
 - `-i` flag stands for interactive. It keeps the standard input(`STDIN`) open, allowing you to interact with the container.
 - `-t` flag provides a user-friendly experience when interacting with the container.

Running commands directly in the container
```sh
docker exec -it container-id sh
```

Combine it with docker run
```sh
docker run -it image_name sh
```
