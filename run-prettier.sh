#!/bin/sh
echo "FROM node:18-alpine \nWORKDIR /app\nRUN npm install -g prettier" > Dockerfile
docker build -t prettier:tmp .
rm Dockerfile
docker run -v $(pwd):/app -w /app prettier:tmp prettier "$@"
while [ ! -z "$(docker ps -a -q -f ancestor=prettier:tmp)" ]; do
    sleep 1
done
docker rmi prettier:tmp