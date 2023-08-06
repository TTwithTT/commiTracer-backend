FROM ruby:3.1.4

ENV BUNDLE_VERSION 2.2.33
ENV APP /app

RUN apt-get update -qq && \
  apt-get install -y \
    curl \
    build-essential \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    netcat \
    vim \
    default-mysql-client \
    libxml2-dev \
    libxslt-dev \
    libc6-dev \
    openssl \
    zip && \
  curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && \
  apt-get install -y \
    nodejs \
    yarn && \
  rm -rf /var/lib/apt/lists/*

RUN gem install bundler --version "$BUNDLE_VERSION"

RUN mkdir $APP
WORKDIR $APP

COPY . $APP

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 8080
