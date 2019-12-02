FROM ruby:alpine3.10

RUN apk add --no-cache --virtual build-deps build-base
RUN apk add --no-cache icu-dev icu-libs
RUN apk add --no-cache cmake
RUN apk add --no-cache git

RUN gem install gollum:4.1.4
RUN gem install github-markdown

RUN apk del cmake build-base build-deps icu-dev

RUN addgroup --system gollum && adduser --ingroup gollum --system gollum

WORKDIR /wiki
RUN chown -R gollum:gollum /wiki

USER gollum
CMD git init && gollum --port 8080 --live-preview --show-all
EXPOSE 8080

