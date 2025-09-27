#
#
#
FROM openjdk:11-jdk-slim-bullseye

# add user & group
RUN groupadd --gid 1000 playuser \
  && useradd --uid 1000 --gid playuser --shell /bin/bash --no-create-home playuser

ENV PLAY_VERSION=1.5.3
ENV PLAY_HOME=/usr/local/play-${PLAY_VERSION}/

RUN apt-get update && \
    apt-get install -y wget unzip && \
    apt-get install -y python2.7 && \
    ln -s /usr/bin/python2.7 /usr/bin/python

RUN wget https://github.com/playframework/play1/releases/download/${PLAY_VERSION}/play-${PLAY_VERSION}.zip
RUN unzip play-${PLAY_VERSION}.zip && \
    rm play-${PLAY_VERSION}.zip && \
    mv play-${PLAY_VERSION} /usr/local && \
    chmod +x /usr/local/play-${PLAY_VERSION}/play && \
    ln -s /usr/local/play-${PLAY_VERSION}/play /usr/bin/play

# Copy and setup entrypoint script
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/docker-entrypoint.sh"]
