FROM ubuntu:17.10

RUN apt-get update && \
    apt-get install -y zlib1g-dev build-essential vim rake git curl libssl-dev libreadline-dev libyaml-dev  \
      libxml2-dev libxslt-dev openjdk-8-jdk-headless curl iputils-ping netcat && \
    apt-get clean

RUN apt-get -y install git

RUN apt-get -y install ruby-full
RUN gem install rake
RUN gem install bundler

WORKDIR /
RUN git clone -b 6.0 https://github.com/elastic/logstash.git
WORKDIR /logstash

RUN rake bootstrap
RUN rake test:install-core
RUN bin/logstash-plugin install --development
