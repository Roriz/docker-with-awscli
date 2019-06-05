FROM docker:latest

ENV AWS_ACCESS_KEY_ID=secret
ENV AWS_SECRET_ACCESS_KEY=secret

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add py-pip
RUN pip install awscli
RUN apk update
