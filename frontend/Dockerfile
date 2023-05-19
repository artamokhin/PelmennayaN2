FROM gitlab.praktikum-services.ru:5050/std-012-056/momo-store/node:16.13.2-alpine as builder
# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npm install  && NODE_ENV=1production npm run build


FROM gitlab.praktikum-services.ru:5050/std-012-056/momo-store/nginx:1.23
COPY ./nginx/nginx.tmpl /app
COPY --from=builder /usr/src/app/dist/ /usr/share/nginx/html/
EXPOSE 80