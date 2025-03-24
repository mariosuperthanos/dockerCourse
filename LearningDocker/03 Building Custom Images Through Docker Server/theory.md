### Exemple of a docker image
```Dockerfile
  # Use an existing docker image as a base
  FROM alpine

  # Donwload and install a dependency
  RUN apk add --update redis

  # Tell the image what to do when it starts as a container
  CMD ["redis-server"]

```

## Build Process of an Image in Detail

### Step 1: `FROM alpine`

Docker looks for the alpine image in the local cache. If it doesn't exist, it pulls the image from Docker Hub.
This becomes **Layer 1** of the final image.

### Step 2: `RUN apk add --update redis`

Docker starts an isolated container based on the alpine image.
It runs the `apk` command inside this container to install Redis.
The installed Redis binaries, configurations, and dependencies are saved as **Layer 2**.
If you run this build again without changes, Docker will use the cached version of this layer (unless you use `--no-cache`).

### Step 3: `CMD ["redis-server"]`

This instruction sets the default behavior of the container (what will happen when you run the container).
It doesn’t add a layer, but it’s part of the final image metadata.

## Building an image
```sh
docker build . 
```

Build then name an image
```sh
docker build -t project_name .
```
`-t` flag is for nameing and tagging the image
