FROM ubuntu:16.04
MAINTAINER yali "yali@thoughtworks.com"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y software-properties-common python-software-properties && \
    add-apt-repository -y ppa:openjdk-r/ppa && \
    apt-get install -y openjdk-8-jdk

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64


# Install curl
RUN apt-get -y install curl unzip wget

#gradle
RUN \
    cd /usr/local && \
    curl -L https://services.gradle.org/distributions/gradle-3.5-bin.zip -o gradle-3.5-bin.zip && \
    unzip gradle-3.5-bin.zip && \
    rm gradle-3.5-bin.zip

# Download and install jetty
RUN wget -c http://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.3.12.v20160915/jetty-distribution-9.3.12.v20160915.tar.gz && \
    tar -xzvf jetty-distribution-9.3.12.v20160915.tar.gz && \
    rm -rf jetty-distribution-9.3.12.v20160915.tar.gz && \
    mv jetty-distribution-9.3.12.v20160915/ /opt/jetty

RUN useradd jetty && \
    chown -R jetty:jetty /opt/jetty && \
    rm -rf /opt/jetty/webapps.demo

WORKDIR /opt/jetty
COPY ./ /opt/jetty



ENV GRADLE_HOME=/usr/local/gradle-3.5
ENV PATH=$PATH:$GRADLE_HOME/bin
EXPOSE 80
CMD ["/bin/bash"]