FROM drush/drush:8

USER root

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000

RUN groupadd -g ${gid} ${group} \
    && useradd -d "/home/jenkins" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

# Install rvm, ruby & docman
RUN apt-get -y install wget curl
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm install 2.3.0"
RUN /bin/bash -l -c "rvm --default use 2.3.0"
RUN /bin/bash -l -c "gem install docman"

# SSH config
RUN mkdir -p /root/.ssh
ADD config /root/.ssh/config

# Install Java.
RUN \
  apt-get update && \
  apt-get install -y openjdk-7-jre && \
  rm -rf /var/lib/apt/lists/*

# Install druflow & assemble gradle & groovy
ENV JAVA_HOME=/usr
RUN git clone https://github.com/aroq/druflow.git && \
  cd druflow && \
  ./gradlew assemble

RUN python --version

RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "/tmp/get-pip.py"

RUN python /tmp/get-pip.py

RUN apt-get update; apt-get -y install python-dev

RUN pip install ansible

RUN ansible --version

USER jenkins

# Git config
RUN git config --global user.email "drudock@github.com"
RUN git config --global user.name "Drudock"

