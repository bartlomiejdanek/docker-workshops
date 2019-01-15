FROM ubuntu:latest

RUN apt update && \
    apt install -y vim sudo git --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

FROM ruby:2.6
