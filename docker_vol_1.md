---
theme : "black"
highlightTheme: "Dracula"
---

# docker

---

# vm

![vm](https://nickjanetakis.com/assets/blog/virtual-machine-architecture-e6bcc9d42a12a12da38e92ba5a7ddef21e6bda269abc580a84ece64ac189d2b2.jpg)

---

# docker
![docker](https://nickjanetakis.com/assets/blog/docker-architecture-2cf6d2f4a7d8f04df5576d06c46f02435d8fae339063f58a621a42f24255602a.jpg)

---

- [Linux Selleo Best Practices](https://github.com/Selleo/selleo_best_practices/blob/master/technology_offer_obsolete/before_january_2019/devops/linux.md)
- [Docker Docs](https://docs.docker.com/)
- [Devhints](https://devhints.io/docker)
- [Deployment with Docker](https://docs.zoho.eu/ws/pulse/file/3szsc1d6e4e923f554fa4b0a57a58a445c96c)
- [DevOps for Networking](https://docs.zoho.eu/ws/pulse/file/3szsc854d03dc0bb3403a8d7436ddea2079ad)
- [Getting Started with Kubernetes](https://github.com/estelle/input-masking)

---

# docker CLI

---

docker COMMAND --help

---

## docker pull

```bash
docker pull ubuntu:14.04
```

---

## docker run

```bash
docker run ubuntu -n hackbox
```

---

## docker build

```bash
docker build -t bard/hackbox:2.0 -f app/Dockerfile
```

---

## docker push

```bash
docker push https://registry.selleo.com/bard/hackbox
```

---

## docker container

```bash
docker container ls
```

---

## docker exec

```bash
docker exec -it my_hackbox hack.go
docker exec -it eb234514d299 hack.go
```

---

## docker logs

```bash
docker logs --follow my_hackbox
```

---

## docker history

```
docker history hackbox
```

---

# Dockerfile

---

## ADD / COPY

```dockerfile
ADD local_file top/secret/directory
ADD https://curl.haxx.se/ca/cacert.pem /pems
COPY local_file top/secret/directory
```

---

## ENV

```dockerfile
ENV NODE_ENV prouction
ENV RAILS_ENV=production
```

---

## ARG

```dockerfile
ARG NODE_ENV production
ARG RAILS_ENV=production

ENV NODE_ENV $NODE_ENV
ENV RAILS_ENV=$RAILS_ENV
```

---

## EXPOSE

```dockerfile
EXPOSE 80 443 8080 9090
```

---

## FROM

```dockerfile
FROM ruby:2.6 AS ruby
FROM golang:latest AS golang
COPY --from=ruby /bin/ruby /data/project
```

---

## LABEL

```dockerfile
LABEL vendor=Selleo
      com.hackbox.is-beta="yes" \
      com.hackbox.is-production="no" \
      com.hackbox.version="0.0.1-beta" \
      com.hackbox.release-date="2018-12-31"
```
---

## USER

```dockerfile
USER bard:bard-group
```

## VOLUME

```dockerfile
RUN mkdir /myvol
RUN echo "hello world" > /myvol/greeting
VOLUME /myvol
# https://docs.docker.com/storage/volumes/
```

---

## RUN / CMD / ENTRYPOINT

```dockerfile
RUN command.sh
CMD command.sh
ENTRYPOINT command.sh
# http://goinbigdata.com/docker-run-vs-cmd-vs-entrypoint/
```

---

## WORKDIR

```dockerfile
WORKDIR /my
WORKDIR awesome
WORKDIR project
RUN pwd # /my/awesome/project
```

---

## HEALTHCHECK

```dockerfile
HEALTHCHECK NONE
HEALTHCHECK --interval=5m --timeout=3s \
  CMD curl -f http://localhost:8080/ || exit 1
```

---

# .dockerignore

```.dockerignore
# ignore .git and .cache folders
.git
.cache
# ignore all markdown files (md) beside all README*.md other than README-secret.md
*.md
!README*.md
README-secret.md
```
