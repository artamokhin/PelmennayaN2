#!/bin/bash
set +e
cat > .env <<EOF
NODE_ENV=production
VUE_APP_API_URL=http://momo-backend:8081
EOF
docker network create -d bridge momo_network || true
docker pull gitlab.praktikum-services.ru:5050/std-012-056/momo-store/momo-frontend:latest
docker stop momo-frontend || true
docker rm momo-frontend || true
set -e
docker run -d --name momo-frontend \
    --network=momo_network -p 80:80\
    --restart always \
    --pull always \
    --env-file .env \
    gitlab.praktikum-services.ru:5050/std-012-056/momo-store/momo-frontend:latest