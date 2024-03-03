FROM ruby:3.1.0

ARG BUNDLE_WITHOUT
ENV BUNDLE_WITHOUT ${BUNDLE_WITHOUT}

RUN DEBIAN_FRONTEND=noninteractive apt-get -o Acquire::Check-Valid-Until=false update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -qq -y && \
    DEBIAN_FRONTEND=noninteractive apt update -qq -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qq -y \
    build-essential \
    libpq-dev \
    supervisor \
    curl \
    postgresql-client \
    htop \
    imagemagick \
    mc \
    unzip \
    wget \
    tar \
    openssl \
    nano \
    cron \
    lsof

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y -qq nodejs && \
    npm install --global yarn

RUN curl -o /usr/local/bin/waitforit -sSL \
    https://github.com/maxcnunes/waitforit/releases/download/v2.4.1/waitforit-linux_amd64 && \
    chmod +x /usr/local/bin/waitforit

RUN mkdir -p /pet/tmp/pids

WORKDIR /pet
COPY Gemfile* /pet/
RUN gem install bundler:2.3.3 && bundle install --jobs=8

COPY . /pet

RUN chmod +x ./docker/src/start_sidekiq.sh
CMD ["./docker/src/start.sh"]

EXPOSE 3000
