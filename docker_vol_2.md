---
theme : "black"
highlightTheme: "Dracula"
---

# docker vol 2

---

## it works, but how?

<span class="fragment">
"host-native virtualization"
</span>
<br>
<br>

<span class="fragment">Apple Hypervisor framework</span>
<br>
<span class="fragment">Microsoft Hyper-V</span>
<br>
<span class="fragment">Linux*</span>

---

## Optimization

Number of layers

```Dockerfile
RUN apt update
RUN apt install sudo
RUN apt install vim
RUN apt install curl
```

---

## Optimization #1

Number of layers

```Dockerfile
RUN apt update && \
    apt install -y sudo vim curl --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*
```

---

## Optimization #2

Because order matters

```Dockerfile
COPY . /app/
RUN bundle install
```

---

## Optimization #2

Because order matters

```Dockerfile
COPY Gemfile Gemfile.lock /app/
RUN bundle install
COPY . /app/
```

---

## Optimization #3

Build environment vs Running environment

```Dockerfile
FROM golang:1.11.5

RUN mkdir /opt/script
WORKDIR /opt/script
COPY script.go .
RUN go build -o script script.go
```

<span class="fragment">Size <strong>~818MB</strong></span>

---

## Optimization #3

Build environment vs Running environment

```Dockerfile
FROM golang:1.11.5 AS build

RUN mkdir /opt/script
WORKDIR /opt/script
COPY script.go .
RUN go build -o script script.go

FROM golang:1.11.5-alpine AS runtime

RUN mkdir /opt/script
COPY --from=build /opt/script/script /opt/script/
```

<span class="fragment">Size <strong>~313MB</strong></span>

---

## Optimization #4

Just push Dockerfile to a cloud.

<span class="fragment">
gcloud builds submit -t gcr.io/my_awesome_project/my_awesome_container
</span>

---

# Docker Compose

> define and run multi-container Docker applications

---

## docker-compose.yml

```yaml
---
version: "3.7"
services:
  redis:
    image: redis:5.0
```

---


## docker-compose.yml

```yaml
---
version: "3.7"
services:
  redis:
    image: redis:5.0
    volumes:
      - type: volume
        source: data
        target: /data
      - type: bind
        source: ./static
        target: /opt/static
volumes:
  data:
```

---

```yaml
---
version: "3.7"
services:
  redis:
    image: postgres:10.6
    volumes:
      - ./.postgres_data:/var/lib/postgresql
```

---

## docker-compose.yml

```yaml
---
version: "3.7"
services:
  redis:
    image: redis:5.0
    expose:
      - "6379"
```

---

## docker-compose.yml

```yaml
---
version: "3.7"
services:
  redis:
    image: redis:5.0
    ports:
      - "6380:6379"
      - "6060:6060/udp"
      - "127.0.0.1:8001:8001"
      - "9090-9091:8080-8081"
```

---

## docker-compose.yml

```yaml
---
version: "3.7"
services:
  awesome_app:
    build:
      context: ./deploy
      dockerfile: dockerfile-test
      args:
        nginx_version: 1.15.8
      labels:
        com.example.description: "my awesome app"
  redis:
    image: redis:5.0
    ports:
      - "6380:6379"
```

---

## docker-compose.yml

```yaml
---
version: "3.7"
services:
  awesome_app:
    image: awesome_app:latest
    depends_on:
      - redis
  redis:
    image: redis:5.0
```

---

## docker-compose.yml

```yaml
---
version: "3.7"
services:
  awesome_app:
    image: awesome_app:latest
    depends_on:
      - redis
  redis:
    image: redis:5.0
    deploy:
      resources:
        limits:
          cpus: "0.50"
          memory: 50M
        reservations:
          cpus: "0.20"
          memory: 15M
```

---

## docker-compose.yml

```yaml
---
version: "3.7"
services:
  awesome_app:
    image: awesome_app:latest
    env_file:
      - .env.test
    environment:
      API_SHA256: "229DAF3DB00DB2B46B08ECA0D1BEB03F7714ADF965406FF29DBACF00D3FD75E4"
    depends_on:
      - redis
  redis:
    image: redis:5.0
```

---

## docker-compose.yml

```yaml
---
version: "3.7"
services:
  proxy:
    build: ./proxy
    networks:
      - frontend
  app:
    build: ./app
    networks:
      - frontend
      - backend
  db:
    image: postgres
    networks:
      - backend
networks:
  default:
    external: "my-pre-existing-network"
  frontend:
  backend:
```

---

## CLI

```bash
docker-compose build
docker-compose up #<CTRL-C>
docker-compose up -d
docker-compose down
```

---

## CLI

```bash
docker-compose push
docker-compose -f dc.yml -f dc.dev.yml up -d
```

```bash
labs.play-with-docker.com
```

---

## Ex #1' Redis

```ruby
require 'redis'
redis = Redis.new(host: 'localhost', port: 6380, db: 15)
redis.set('somekey', ['somevalue'])
puts redis.get('somekey')
```

---

## Ex #1" Redis

```javascript
var redis = require("redis"),
    client = redis.createClient({host: "localhost", port: 6380, db: 15})
client.set("somekey", ["somevalue"]);
console.log(client.get("somekey"));
```

---

## Ex #2 Storage

> persisted storage

---

## questions?

---


## kubernetes

---

## kubernetes

> an open-source system for automating deployment, scaling, and management of containerized applications
