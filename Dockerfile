FROM ruby:2.5.3-alpine
MAINTAINER Eric Youngberg <eyoungberg@mapc.org>

WORKDIR /usr/src/app
VOLUME /usr/src/app
EXPOSE 3000

COPY Gemfile* ./
COPY vendor/extensions vendor/extensions

RUN set -ex \
    ; \
    apk update \
    && apk add --no-cache \
      git \
      tzdata \
      nodejs \
      build-base \
      libxml2-dev \
      libxslt-dev \
      libc6-compat \
      linux-headers \
      postgresql-dev \
    ; \
    BUNDLE_FORCE_RUBY_PLATFORM=1 bundle install --jobs $(nproc)

CMD rm -f tmp/pids/server.pid && rails server -b 0.0.0.0
