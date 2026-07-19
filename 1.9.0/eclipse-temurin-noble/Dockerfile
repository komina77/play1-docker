#
#
#
# ===== Stage 1: Build Python 3.11 + Play 1.9.0 on Ubuntu 22.04 =====
FROM ubuntu:22.04 AS builder

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

ENV PLAY_VERSION=1.9.0

# https://www.python.org/ftp/python/3.11.10/Python-3.11.10.tgz
COPY Python-3.11.10.tgz /tmp

RUN tar xzf Python-3.11.10.tgz && \
    cd Python-3.11.10 && \
    ./configure && \
    make -j"$(nproc)" && \
    make altinstall && \
    # pip を導入（ensurepip + pip 自身のアップグレード）
    /usr/local/bin/python3.11 -m ensurepip && \
    /usr/local/bin/python3.11 -m pip install --upgrade pip

# Play framework を builder ステージで展開しておく（unzip はこのステージのみで使用）
# https://github.com/playframework/play1/releases/download/${PLAY_VERSION}/play-${PLAY_VERSION}.zip
RUN wget -q https://github.com/playframework/play1/releases/download/${PLAY_VERSION}/play-${PLAY_VERSION}.zip -O /tmp/play-${PLAY_VERSION}.zip && \
    unzip /tmp/play-${PLAY_VERSION}.zip && \
    rm /tmp/play-${PLAY_VERSION}.zip && \
    mv play-${PLAY_VERSION} /usr/local && \
    chmod +x /usr/local/play-${PLAY_VERSION}/play

# ===== Stage 2: Temurin Runtime (JDK 19) =====
FROM eclipse-temurin:19-jdk-jammy

ENV DEBIAN_FRONTEND=noninteractive
ENV PLAY_VERSION=1.9.0
ENV PLAY_HOME=/usr/local/play-${PLAY_VERSION}/

COPY --from=builder /usr/local/bin/python3.11 /usr/local/bin/python3.11
COPY --from=builder /usr/local/lib/python3.11 /usr/local/lib/python3.11
COPY --from=builder /usr/local/bin/pip3.11 /usr/local/bin/pip3.11

RUN ln -s /usr/local/bin/python3.11 /usr/bin/python3 && \
    ln -s /usr/local/bin/python3.11 /usr/bin/python && \
    ln -s /usr/local/bin/pip3.11 /usr/local/bin/pip3 && \
    ln -s /usr/local/bin/pip3.11 /usr/local/bin/pip

COPY --from=builder /usr/local/play-${PLAY_VERSION} /usr/local/play-${PLAY_VERSION}

RUN ln -s /usr/local/play-${PLAY_VERSION}/play /usr/bin/play

# Play 同梱の python/requirements.txt を解決
RUN cd "$PLAY_HOME" && \
    /usr/local/bin/python3.11 -m pip install -r python/requirements.txt

# Copy and setup entrypoint script
COPY eclipse-temurin-noble/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/docker-entrypoint.sh"]
