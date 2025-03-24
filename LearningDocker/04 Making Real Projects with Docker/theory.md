# Errors

### NPM not found error
This error occurs because Node Package Manager does not exists on the image.
In order to solve this problem, i replaced this line:
```Dockerfile
FROM alpine
```
with this one:
```Dockerfile
FROM node:alpine
```

### file(`package.json`) not found error
I tried to build an image on this `Dockerfile`
```Dockerfile
# Specify the base image
FROM node:alpine

# Install some dependencies
RUN npm install

# Default command
CMD [ "npm", "start" ]
```
An error occurd at `RUN npm install` line because the npm install needs the `package.json` file in order to work, but `package.json` and `index.js` file is not included in the image

### `WORKDIR` error
The error occurred because, without the WORKDIR /app command, files and Docker commands were executed in the root directory of the container, leading to incorrect file locations and failure to install dependencies. By adding `WORKDIR /app`, we defined a clear working directory where files were copied correctly, and commands (like npm install) were executed in the proper location, thus resolving the issue and allowing the image to build successfully.

### Docker Run with Port Maping
Anytime a request is sent at port 5000 on localhost network, redirect it to port 8080 inside the container.
```sh
docker run -p 5000:8080 image_name
```

### How docker `cache` works
When building a Docker image, Docker caches every layer. If I rebuild the image without any changes, it will be built almost instantly because the layers have already been cached.
```Dockerfile
# Specify the base image
FROM node:alpine

# Set the working directory inside the container
WORKDIR /usr/app

# Install some dependencies
COPY ./ ./
RUN npm install

# Default command
CMD [ "npm", "start" ]
```
If i modify `index.js` file, docker will rebuild the next files(including `index.js` one). The problem is that `package.json` and `node_modules` will be rebuilded. The rebuilding process takes a lot of time in a real project with a lot of dependecies.
In order ot solve the problem, i copied the `package.json`, run `npm install` and then copied the rest of the files. This time, docker will have to rebuild only `index.js`
```Dockerfile
# Specify the base image
FROM node:alpine

# Set the working directory inside the container
WORKDIR /usr/app

# Install some dependencies
COPY ./package.json ./
RUN npm install
COPY ./ ./

# Default command
CMD [ "npm", "start" ]
```