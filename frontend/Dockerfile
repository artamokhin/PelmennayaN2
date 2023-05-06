FROM node:16.13.2-alpine as builder
# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npm install  && NODE_ENV=1production npm run build

# VUE_APP_API_URL=http://158.160.34.207:8081

FROM nginx:1.23
COPY --from=builder /usr/src/app/dist/ /usr/share/nginx/html/
EXPOSE 80