# Start with a base Ubuntu image
FROM ubuntu:20.04

# Avoid warnings while installing ubuntu
# debconf: unable to initialize frontend: Dialog
# debconf: (TERM is not set, so the dialog frontend is not usable.)
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install packages
RUN apt update && \
    apt install -y --no-install-recommends\
    git \
    build-essential \
    ruby-dev \
    && \
    rm -rf /var/lib/apt/lists/*

RUN gem install bundler

# Add developer user
RUN useradd -ms /bin/bash developer

# Set up front-end using webpack
RUN apt update && apt install -y npm
RUN npm install webpack webpack-cli --save-dev
RUN npm install webpack-dev-server --save-dev
# RUN npx webpack

# Create the bundle
COPY example/Gemfile example/Gemfile
COPY example/Gemfile.lock example/Gemfile.lock
COPY Gemfile .
COPY Gemfile.lock .
COPY jekyll-theme-easy-wedding.gemspec .
RUN cd example && bundle install



