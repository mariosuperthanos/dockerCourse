# Docker-compose. Creating a network between 2 containers

In index.js file, I created a new redis client with configuration:
```js
const client = redis.createClient({
  host: 'redis-server',
  port: 6379
});
```
It listens to the host with the name: `redis-server` at the port `6379`.

I created the `redis-server` that node.js app listens to inside the `docker-compose.yml` file:
```yml
version: '3'
services:
  redis-server:
    image: 'redis'
    # default port is 6379
  node-app:
    build: .
    ports:
      - "4001:8081"
```
It will create a docker `container` with hostname `redis-server` at the default port `6379` based on `redis` official image.

### Docker-compose commands
docker run myimage ==> docker-compose up
docker build . & docker run myimage ==> docker-compose up --build
docker stop container_id ==> docker-compose down

### Restart Policies
default - never attempt to restart this . container if it stops or crashes
always - if this container stops *for any reason* alyways attempt to restart it
on-failure - only restart if the container stops with an error code(!= 0)

### Status Codes
0 - We exited and everything is OK
1, 2, 3, etc - We exited because something went wrong!