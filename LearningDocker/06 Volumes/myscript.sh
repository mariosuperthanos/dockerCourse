#!/bin/bash

docker kill feedback-app
# docker rm $(docker ps -a -q)
# docker volume rm $(docker volume ls -q)
# docker rmi feedback-node:volumes
# docker build -t feedback-node:volumes .

docker run -d --rm -p 3000:8000 -e PORT=8000 --name feedback-app \
  -v feedback:/app/feedback \
  -v "$(pwd):/app" \
  -v /app/node_modules \
  -v /app/temp \
  feedback-node:env

# docker run -d --rm -p 3000:80 --name feedback-app \
#   -v feedback:/app/feedback \           ceez un named container pentru a salva datele din app/feedback in pc
#   -v "$(pwd):/app:ro" \                 folosesc bind mount READ-ONLY pentru a da sync in procesul de development la folderul de pe pc si container
#   -v /app/node_modules \                anonymous conatiner pentru a se asigura ca node_modules nu este overwritten de bind mount
#   -v /app/temp \                        la fel si pentru temp
#   feedback-node:volumes