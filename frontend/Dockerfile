FROM node:16.13.2-alpine as builder
# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npm install  && npm run build


FROM nginx:1.23
COPY --from=builder /usr/src/app/dist/ /usr/share/nginx/html/momo-store
EXPOSE 80