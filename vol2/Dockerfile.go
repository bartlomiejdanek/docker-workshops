FROM golang:1.11.5 AS build

RUN mkdir /opt/script
WORKDIR /opt/script
COPY script.go .
RUN go build -o script script.go

FROM golang:1.11.5-alpine AS runtime

RUN mkdir /opt/script
COPY --from=build /opt/script/script /opt/script/
