FROM node:14

WORKDIR /app

COPY package.json .

RUN npm install

RUN chmod -R a+rw /app

COPY . .

EXPOSE 80

# USER node

CMD [ "npm", "start" ]