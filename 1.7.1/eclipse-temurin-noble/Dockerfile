#
#
#
# ===== Stage 1: Build Python 3.9 + Play 1.7.1 on Ubuntu 24.04 =====
FROM ubuntu:24.04 AS builder

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

# https://www.python.org/ftp/python/3.9.25/Python-3.9.25.tgz
COPY Python-3.9.25.tgz /tmp

RUN tar xzf Python-3.9.25.tgz && \
    cd Python-3.9.25 && \
    ./configure --enable-optimizations && \
    make -j"$(nproc)" && \
    make altinstall && \
    # pip を導入（ensurepip + pip 自身のアップグレード）
    /usr/local/bin/python3.9 -m ensurepip && \
    /usr/local/bin/python3.9 -m pip install --upgrade pip

# Play framework を builder ステージで展開しておく（unzip はこのステージのみで使用）
# https://github.com/playframework/play1/releases/download/${PLAY_VERSION}/play-${PLAY_VERSION}.zip
COPY play-1.7.1.zip /tmp
RUN unzip play-1.7.1.zip && \
    rm play-1.7.1.zip && \
    mv play-1.7.1 /usr/local && \
    chmod +x /usr/local/play-1.7.1/play

# ===== Stage 2: Temurin Noble Runtime =====
FROM eclipse-temurin:17-jdk-noble

ENV DEBIAN_FRONTEND=noninteractive
ENV PLAY_VERSION=1.7.1
ENV PLAY_HOME=/usr/local/play-${PLAY_VERSION}/

# Python 3.9 と pip をコピー
COPY --from=builder /usr/local/bin/python3.9 /usr/local/bin/python3.9
COPY --from=builder /usr/local/lib/python3.9 /usr/local/lib/python3.9
COPY --from=builder /usr/local/bin/pip3.9 /usr/local/bin/pip3.9

# 使いやすいようにシンボリックリンクを張る
RUN ln -s /usr/local/bin/python3.9 /usr/bin/python3 && \
    ln -s /usr/local/bin/python3.9 /usr/bin/python && \
    ln -s /usr/local/bin/pip3.9 /usr/local/bin/pip3 && \
    ln -s /usr/local/bin/pip3.9 /usr/local/bin/pip

# builder ステージで展開済みの Play ディレクトリのみをコピー
COPY --from=builder /usr/local/play-${PLAY_VERSION} /usr/local/play-${PLAY_VERSION}

RUN ln -s /usr/local/play-${PLAY_VERSION}/play /usr/bin/play

# Play 同梱の python/requirements.txt を解決
RUN cd "$PLAY_HOME" && \
    /usr/local/bin/python3.9 -m pip install -r python/requirements.txt

# Copy and setup entrypoint script
COPY eclipse-temurin-noble/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/docker-entrypoint.sh"]
