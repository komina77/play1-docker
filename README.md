# play1-docker
play1をdockerイメージ化

## 一覧

|Tag|BASE|
|--|--|
|komina77/play-1.5.3|openjdk:11-jdk-slim-bullseye|
|komina77/play-1.7.1|openjdk:17-jdk-slim-bullseye|
|komina77/play-1.8.0|openjdk:19-jdk-slim-bullseye|
|komina77/play-1.9.0|openjdk:19-jdk-slim-bullseye|

## 使い方


引数ありで実行すると引数がそのままコマンドとして実行されすぐに終了する。
```
PS C:\Users\komina77> docker run --rm -v ${pwd}/work:/work -w /work -p 9000:9000 komina77/play:1.7.1-bullseye play
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

引数なしで実行するとコンテナ起動後シェルで操作ができる。
```
PS C:\Users\komina77> docker run -it --rm -v ${pwd}/work:/work -w /work -p 9000:9000 komina77/play:1.7.1-bullseye
# 
```

### build Dockefile

#### 1.5.3
```
PS play1-docker> docker build .\1.5.3\bullseye\. -t komina77/play:1.5.3-bullseye
PS play1-docker> docker push komina77/play:1.5.3-bullseye
```

#### 1.7.1
```
PS play1-docker> docker build .\1.7.1\bullseye\. -t komina77/play:1.7.1-bullseye
PS play1-docker> docker push komina77/play:1.7.1-bullseye
```

#### 1.8.0
```
PS play1-docker> docker build .\1.8.0\bullseye\. -t komina77/play:1.8.0-bullseye
PS play1-docker> docker push komina77/play:1.8.0-bullseye
```

#### 1.9.0
```
PS play1-docker> docker build .\1.9.0\bullseye\. -t komina77/play:1.9.0-bullseye
PS play1-docker> docker push komina77/play:1.9.0-bullseye
```


### debian
* Debian 12 (Bookworm)
* Debian 11 (Bullseye)
* Debian 10 (Buster)
* Debian 9 (Stretch)
* Debian 8 (Jessie)
* 