FROM node:16.13.2-alpine as builder
# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npm install  && NODE_ENV=production VUE_APP_API_URL=http://localhost:8081 npm run build


FROM nginx:1.23
COPY --from=builder /usr/src/app/dist/momo-store /usr/share/nginx/html/
EXPOSE 80