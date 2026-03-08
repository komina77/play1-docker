#
#
#
# ===== Stage 1: Build Python 2.7 on Ubuntu 20.04 =====
FROM ubuntu:20.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    build-essential \
    libssl-dev \
    zlib1g-dev \
    libbz2-dev \
    libreadline-dev \
    libsqlite3-dev \
    wget \
    curl \
    xz-utils \
    tk-dev \
    libffi-dev \
    liblzma-dev \
    unzip

WORKDIR /tmp

# https://www.python.org/ftp/python/2.7.18/Python-2.7.18.tgz
COPY Python-2.7.18.tgz /tmp

RUN tar xzf Python-2.7.18.tgz && \
    cd Python-2.7.18 && \
    ./configure --enable-optimizations && \
    make -j$(nproc) && \
    make altinstall

# Play framework を builder ステージで展開しておく（unzip はこのステージのみで使用）
# https://github.com/playframework/play1/releases/download/${PLAY_VERSION}/play-${PLAY_VERSION}.zip
COPY play-1.5.3.zip /tmp
RUN unzip play-1.5.3.zip && \
    rm play-1.5.3.zip && \
    mv play-1.5.3 /usr/local && \
    chmod +x /usr/local/play-1.5.3/play

# ===== Stage 2: Temurin Noble Runtime =====
FROM eclipse-temurin:11-jdk-noble

# Python 2.7 をコピー
COPY --from=builder /usr/local/bin/python2.7 /usr/local/bin/python2.7
COPY --from=builder /usr/local/lib/python2.7 /usr/local/lib/python2.7

RUN ln -s /usr/local/bin/python2.7 /usr/bin/python

ENV PLAY_VERSION=1.5.3
ENV PLAY_HOME=/usr/local/play-${PLAY_VERSION}/

# builder ステージで展開済みの Play ディレクトリのみをコピー
COPY --from=builder /usr/local/play-${PLAY_VERSION} /usr/local/play-${PLAY_VERSION}

RUN ln -s /usr/local/play-${PLAY_VERSION}/play /usr/bin/play

# Copy and setup entrypoint script
COPY  eclipse-temurin-noble/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/docker-entrypoint.sh"]
