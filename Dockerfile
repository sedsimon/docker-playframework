FROM java:latest
MAINTAINER Simon Stanlake <simon.stanlake@gmail.com>

ENV ACTIVATOR_VERSION 1.3.7

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y && apt-get install -y unzip
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y nodejs npm git git-core

RUN curl -O http://downloads.typesafe.com/typesafe-activator/${ACTIVATOR_VERSION}/typesafe-activator-${ACTIVATOR_VERSION}.zip 
RUN unzip typesafe-activator-${ACTIVATOR_VERSION}.zip -d /opt && rm typesafe-activator-${ACTIVATOR_VERSION}.zip && chmod a+x /opt/activator-dist-${ACTIVATOR_VERSION}/activator && ln -s /opt/activator-dist-${ACTIVATOR_VERSION} /opt/activator

ENV PATH $PATH:/opt/activator
ENV SBT_OPTS="-Dsbt.jse.engineType=Node -Dsbt.jse.command=/usr/bin/nodejs"

RUN adduser --disabled-password --gecos "" develop

RUN mkdir /var/project && \
	chown develop:develop /var/project

COPY resources/start-activator.sh /opt/

RUN chmod a+x /opt/start-activator.sh

VOLUME ["/var/project"]
VOLUME ["/home/develop"]

EXPOSE 9000

ENTRYPOINT ["/opt/start-activator.sh"]
