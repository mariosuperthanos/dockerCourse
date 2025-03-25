FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

RUN chmod -R a+rw /app

COPY . .

ARG DEFAULT_PORT=80

ENV PORT=$DEFAULT_PORT

EXPOSE $PORT

# USER node

CMD [ "npm", "start" ]