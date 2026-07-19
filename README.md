# play1-docker
play1をdockerイメージ化。

## 更新ルール

バージョンごとの作業は、次のバージョンに進む前に README へ都度反映する。

## 一覧

|Tag|BASE||
|--|--|--|
|komina77/play-1.5.3-noble|eclipse-temurin:11-jdk-noble||
|komina77/play-1.7.1-noble|eclipse-temurin:17-jdk-noble||
|komina77/play-1.8.0-noble|eclipse-temurin:19-jdk-jammy|`19-jdk-noble` タグが存在しないため jammy を採用。|
|komina77/play-1.9.0-noble|eclipse-temurin:19-jdk-jammy|`19-jdk-noble` タグが存在しないため jammy を採用。|

## 使い方


引数ありで実行すると引数がそのままコマンドとして実行されすぐに終了する。
```
PS C:\Users\komina77> docker run --rm -v ${pwd}/work:/work -w /work -p 9000:9000 komina77/play:1.7.1-noble play
~        _            _ 
~  _ __ | | __ _ _  _| |
~ | '_ \| |/ _' | || |_|
~ |  __/|_|\____|\__ (_)
~ |_|            |__/
~
~ play! 1.7.1, https://www.playframework.com
~
~ Usage: play cmd [app_path] [--options]
~
~ with,  new      Create a new application
~        run      Run the application in the current shell
~        help     Show play help
~
PS C:\Users\komina77> 
```

`-it`オプション + コマンド指定なし で実行するとコンテナ起動後シェルで操作ができる。
```
PS C:\Users\komina77> docker run -it --rm -v ${pwd}/work:/work -w /work -p 9000:9000 komina77/play:1.7.1-noble
# 
```

### build Dockefile

#### 1.5.3
```
PS play1-docker> docker build .\1.5.3 -f 1.5.3/eclipse-temurin-noble/Dockerfile -t komina77/play:1.5.3-noble
PS play1-docker> docker push komina77/play:1.5.3-noble
```

#### 1.5.3 現在の反映内容

* `1.5.3-noble` のローカルビルド完了
* `docker run --rm komina77/play:1.5.3-noble play help` の動作確認完了
* `1.5.3/eclipse-temurin-noble/Dockerfile` の調整
	* Python 2.7 build を `./configure` に変更（`--enable-optimizations` を外す）
	* runtime 側へ `libssl.so.1.1` / `libcrypto.so.1.1` をコピー（hashlibエラー回避）

#### 1.7.1
```
PS play1-docker> docker build .\1.7.1 -f 1.7.1/eclipse-temurin-noble/Dockerfile -t komina77/play:1.7.1-noble
PS play1-docker> docker push komina77/play:1.7.1-noble
```

#### 1.7.1 現在の反映内容

* `1.7.1-noble` のローカルビルド完了
* `docker run --rm komina77/play:1.7.1-noble play help` の動作確認完了
* `1.7.1/eclipse-temurin-noble/Dockerfile` の調整
	* コメントの Python バージョン表記を 3.7 系へ修正
	* Python 3.7 build を `./configure` に変更（`--enable-optimizations` を外す）

#### 1.8.0
```
PS play1-docker> docker build .\1.8.0 -f 1.8.0/eclipse-temurin-noble/Dockerfile -t komina77/play:1.8.0-noble
PS play1-docker> docker push komina77/play:1.8.0-noble
```

#### 1.8.0 現在の反映内容

* `1.8.0-noble` のローカルビルド完了
* `docker run --rm komina77/play:1.8.0-noble play help` の動作確認完了
* `1.8.0/eclipse-temurin-noble/Dockerfile` の調整
	* multi-stage 化（ローカル書庫の Python 3.11 + Play 1.8.0 展開）
	* runtime は `eclipse-temurin:19-jdk-jammy` を採用（`19-jdk-noble` が存在しないため）
	* `Python-3.11.10.tgz` はローカル書庫を使用、`play-1.8.0.zip` は build 時に取得

#### 1.9.0
```
PS play1-docker> docker build .\1.9.0 -f 1.9.0/eclipse-temurin-noble/Dockerfile -t komina77/play:1.9.0-noble
PS play1-docker> docker push komina77/play:1.9.0-noble
```

#### 1.9.0 現在の反映内容

* `1.9.0-noble` のローカルビルド完了
* `docker run --rm komina77/play:1.9.0-noble play help` の動作確認完了
* `1.9.0/eclipse-temurin-noble/Dockerfile` の追加
	* multi-stage 化（ローカル書庫の Python 3.11 + Play 1.9.0 展開）
	* runtime は `eclipse-temurin:19-jdk-jammy` を採用（`19-jdk-noble` が存在しないため）
	* `Python-3.11.10.tgz` はローカル書庫を使用、`play-1.9.0.zip` は build 時に取得


### debian
* Debian 12 (Bookworm)
* Debian 10 (Buster)
* Debian 9 (Stretch)
* Debian 8 (Jessie)
* 