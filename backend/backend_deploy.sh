#!/bin/bash
set +e
docker network create -d bridge momo_network || true
docker pull gitlab.praktikum-services.ru:5050/std-012-056/momo-store/momo-backend:latest
docker stop momo-backend || true
docker rm momo-backend || true
set -e
docker run -d --name momo-backend \
    --network=momo_network -p 8081:8081\
    --restart always \
    --pull always \
    gitlab.praktikum-services.ru:5050/std-012-056/momo-store/momo-backend:latest 