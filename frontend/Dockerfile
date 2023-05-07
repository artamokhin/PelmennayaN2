FROM node:16.13.2-alpine as builder
# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npm install  && NODE_ENV=1production npm run build


FROM nginx:1.23
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /usr/src/app/dist/ /usr/share/nginx/html/
EXPOSE 80