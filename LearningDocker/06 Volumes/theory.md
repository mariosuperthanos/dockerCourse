# Volumes

`volumes` are `folders on your host machine hard drive` which are `mounted`("made available", mapped) into containers.
Volumes `persist if a container shuts down`. If a container (re-)stars and mounts a volume, any data inside of that volume is `available in the container`.
A container `can write` data into a volume `and read` data from it.

### Volumes(managed by docker)
Volumes can be:
  - anonymous
  - named

A defined path in the container is mapped to the created volume/mount. (eg. /some-path on my hosting machine is mapped to /app/data from the given exemple). - available for both volumes(anonymous/named) and mounts.

## Anonymous Volumes
Creating an `anonymous volume`. Here, Docker sets up a folder/path on my fost machine, exact location is unknown to me. Managed via docker volume commands.

```Dockerfile
FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

COPY . .

EXPOSE 80

# This create an anonymous volume
VOLUME [ "/app/feedback" ]

CMD [ "node", "server.js" ]
```

Another syntax is by ading `-v` flag followed by the path inside of the container:
```sh
docker run -d -p 3000:80 --name feedback-app -v /app/node_modules feedback-node:volumes
```

## --rm flag

And I runned the conainer with:

```sh
docker run -d -p 3000:80 --rm --name feedback-app feedback-node:volumes
```
We saw, that anonymous volumes are removed automatically, when a container is removed.

This happens when you start / run a container with the --rm option.

If you start a container without that option, the anonymous volume would NOT be removed, even if you remove the container (with docker rm ...).

Still, if you then re-create and re-run the container (i.e. you run docker run ... again), a new anonymous volume will be created. So even though the anonymous volume wasn't removed automatically, it'll also not be helpful because a different anonymous volume is attached the next time the container starts (i.e. you removed the old container and run a new one).

Now you just start piling up a bunch of unused anonymous volumes - you can clear them via docker volume rm VOL_NAME or docker volume prune.

## Named Volumes
`Named Volumes` are great for data which should be persistent but which you dont need to edit directly. They don't have to be declared in `Dockerfile`.
```sh
docker run -d -p 3000:80 --rm --name feedback-app -v feedback:/app/feedback feedback-node:volumes
```
I specified the `name` and the `path` of the `volume` after the `-v` flag which stands for volume.


## Bind Mounts
Unlike volumes, mounts let me define a folder/path on my host machine.
Mounts are great for persistent, editable(by me)(eg. source code).
It `syncs` the folder from host machine with the one inside the container.

In the next exemple, I `deleted` node_modules form my hosting machine
```sh
docker run -d -p 3000:80 --name feedback-app -v feedback:/app/feedback -v "$(pwd):/app" feedback-node:volumes
```
After the second `-v` flag, i specified the `bind mount`, by connecting a path from my host machine with the path inside the container.
The problem with this is that i overwrited the whole `WORKDIR(app folder that contains files)` inside the contianer.

In order to solve this problem I used anonymous volumes because of the Docker rule:`the longer(the more specific path) inside of the container wins`. That means that I can still bind the `app` folder, but the `node_modules` will override it.

```sh
docker run -d -p 3000:80 --name feedback-app -v feedback:/app/feedback -v "$(pwd):/app" -v /app/node_modules feedback-node:volumes
```

## Quick overview
Anonymous volumes: 
- created specifically for a single container      
- use case: prevent some data from being overwritten
- survives container shutdown/restart unless --rm is used
- can not be shared acrsoss containers
- since it's anonymous, it can't be re-used 

Named volumes:
- created in general - not tied to any specific container
- survives container shutdown/restart
- can be shared across multiple containers
- can be reused for same container(across restarts)
Bind mounts:
- location on host file system, not tied to any specific container
- survives container shutdown/restart
- can be shared across containers
- can be re-used for same container across restart