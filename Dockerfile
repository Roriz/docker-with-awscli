FROM docker:latest

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add py-pip
RUN pip install awscli
RUN apk update
