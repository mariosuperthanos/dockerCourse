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