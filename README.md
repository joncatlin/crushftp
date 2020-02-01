# CrushFTP for Docker
This repo contains an immplementation of the DruchFTP server inside a docker container.

The starting point for this repo is the wiki article that Crush support pointed out. https://www.crushftp.com/crush9wiki/Wiki.jsp?page=Docker

The instructions for building the container did not conform to building image best practices, see https://docs.docker.com/develop/develop-images/dockerfile_best-practices/

## Running 

## Default credentials
To login to the crusftp web UI go to http://hostname:8080 and use the credentials, admin with password admin.

## Building the image
Navigate to the directory containing the docker-compose.yml file and use the following command.
```
docker-compose build
```
## Running the image in Docker
To run the image in the background, using normal docker and not swarm, use the following command
```
docker-compose up -d
```

## Running the image in Swarm
```
docker stack deploy -c docker-compose.yml your-stack-name
```
