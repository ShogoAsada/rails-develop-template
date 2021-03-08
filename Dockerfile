FROM ruby:3.0-alpine

ARG BUILD_DEPENDENCIES="build-base ruby-dev nodejs yarn"
ARG APP_DEPENDENCIES="postgresql-client-11 redis-cli"
ARG MISC_PACKAGE="sudo tzdata"
ENV USER="dev"

WORKDIR /app

RUN apk add --update --no-cache \
    $BUILD_DEPENDENCIES \
    $MISC_PACKAGE

RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN adduser -D dev && \
    chown dev:dev /app

COPY . /app

RUN gem install bundler && \
    bundle -j4
