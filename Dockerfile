FROM drush/drush:8

USER root

RUN apt-get -y install wget curl
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm install 2.3.0"
RUN /bin/bash -l -c "rvm --default use 2.3.0"
RUN /bin/bash -l -c "gem install docman"

RUN mkdir -p /root/.ssh
ADD config /root/.ssh/config

RUN git config --global user.email "jenkins@adyax.com"
RUN git config --global user.name "Adyax Jenkins"

# Install Java.
RUN \
  apt-get install -y openjdk-7-jdk && \
  rm -rf /var/lib/apt/lists/*
