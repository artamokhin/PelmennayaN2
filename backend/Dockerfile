# build stage
FROM golang:1.19-alpine3.16 AS build-env
ADD . /src
RUN cd /src/cmd/api && go build -o goapp

# final stage
FROM alpine:3.17
WORKDIR /app
COPY --from=build-env /src/cmd/api/goapp /app/
EXPOSE 8081
ENTRYPOINT ./goapp