#!/bin/bash


# Create hyperminer redis-db volume
if [[ "$(docker volume ls | grep redis-volume)" == "" ]]; then
    docker volume create --name=redis-volume
fi


docker-compose up -d flask