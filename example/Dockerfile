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

RUN gem install jekyll -v 4.2.0
RUN gem install bundler -v 2.1.4

# Add developer user
RUN useradd -ms /bin/bash developer
# USER developer

# Add developer user with permissions in the working directory
ENV HOME /home/developer
ENV WORKDIR /home/developer/example

# Use the Gemfile and Gemfile.lock to install dependencies for Jekyll website
# COPY Gemfile .
# COPY ../Gemfile.lock .
RUN bundle install