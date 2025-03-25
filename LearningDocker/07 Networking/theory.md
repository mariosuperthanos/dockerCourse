# Networking
I tried to connect to mongoDB in a web application running inside a container:
```js
mongoose.connect(
  'mongodb://localhost:27017/swfavorites',
  { useNewUrlParser: true },
  (err) => {
    if (err) {
      console.log(err);
    } else {
      app.listen(3000);
    }
  }
);
```
The problem is that `localhost:27017` represents the `network IP` adress of the container, not the `host machine`(the container doesn't have mongoDB installed). An approach for solvint this error is by replacing `localhost`(`IP` adress inside the container) with `host.docker.internal`(`IP` from my `host machine`). So mongoDB is running on my host machine, and the backend app is running inside the container.

# Implementing separation of concerns

I runned mongoDB in a separate container after installing its image. Then i modified the connecting adress: `mongodb://172.17.0.2:27017/swfavorites`. The new adress means:
  - go to the container with `IP`: `172.17.0.2`
  - then go to the `port`: `27017` and connect with mongo 