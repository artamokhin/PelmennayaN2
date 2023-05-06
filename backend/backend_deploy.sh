#!/bin/bash
set +e
docker network create -d bridge momo-network || true
docker pull gitlab.praktikum-services.ru:5050/std-012-056/momo-store/momo-backend:latest
docker stop momo-backend || true
docker rm momo-backend || true
set -e
docker run -d --name momo-backend \
    --network=momo-network\
    --restart always \
    --pull always \
    gitlab.praktikum-services.ru:5050/std-012-056/momo-store/momo-backend:latest 