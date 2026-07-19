## Dockerイメージの使い方

### 主なオプション
実行時に指定するオプションは下表の通りほぼ固定です。
|オプション|説明|
|---|---|
|`-v {pwd}/sample:/work`|自分のプロジェクトのあるディレクトリをマウントする.|
|`-p 9000:9000`|公開ポートを設定する.|
|`-w /work`|コンテナ内の開始ディレクトリを指定する.|


### プリコンパイルする
```
PS C:\Users\komina77\play1-docker\1.5.3> docker run -it --rm -v ${pwd}/sample:/work -w /work -p 9000:9000 komina77/play:1.5.3-noble
# play deps myapp
# play precompile myapp
~        _            _ 
~  _ __ | | __ _ _  _| |
~ | '_ \| |/ _' | || |_|
~ |  __/|_|\____|\__ (_)
~ |_|            |__/   
~
~ play! 1.5.3, https://www.playframework.com
~
~ using java version "11.0.16"
Listening for transport dt_socket at address: 8000
08:15:56,270 INFO  ~ Starting /work/myapp
:: loading settings :: url = jar:file:/usr/local/play-1.5.3/framework/lib/ivy-2.4.0.jar!/org/apache/ivy/core/settings/ivysettings.xml
08:15:56,715 INFO  ~ Module docviewer is available (/usr/local/play-1.5.3/modules/docviewer)
08:15:57,892 INFO  ~ Precompiling ...
WARNING: An illegal reflective access operation has occurred
WARNING: Illegal reflective access by org.codehaus.groovy.vmplugin.v7.Java7$1 (file:/usr/local/play-1.5.3/framework/lib/groovy-2.5.3.jar) to constructor java.lang.invoke.MethodHandles$Lookup(java.lang.Class,int)
WARNING: Please consider reporting this to the maintainers of org.codehaus.groovy.vmplugin.v7.Java7$1
WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
WARNING: All illegal access operations will be denied in a future release
08:16:18,339 INFO  ~ Done.
# 
```

### 製品モードで実行
play1では実行時に通常自動でコンパイルが走りますが `-Drecompiled=true` でそれをスキップしています。
```
PS C:\Users\komin\VSCodeProjects\play1-docker\1.5.3> docker run --rm -v ${pwd}/sample:/work -w /work -p 9000:9000 komina77/play:1.5.3-noble play run myapp --%prod -Dprecompiled=true
~        _            _ 
~  _ __ | | __ _ _  _| |
~ | '_ \| |/ _' | || |_|
~ |  __/|_|\____|\__ (_)
~ |_|            |__/
~
~ play! 1.5.3, https://www.playframework.com
~ framework ID is prod
~
~ Ctrl+C to stop
~
~ using java version "11.0.16"
08:20:54,164 INFO  ~ Starting /work/myapp
:: loading settings :: url = jar:file:/usr/local/play-1.5.3/framework/lib/ivy-2.4.0.jar!/org/apache/ivy/core/settings/ivysettings.xml
08:20:54,605 INFO  ~ Module docviewer is available (/usr/local/play-1.5.3/modules/docviewer)
08:20:54,915 INFO  ~ Application is precompiled
WARNING: An illegal reflective access operation has occurred
WARNING: Illegal reflective access by org.codehaus.groovy.vmplugin.v7.Java7$1 (file:/usr/local/play-1.5.3/framework/lib/groovy-2.5.3.jar) to constructor java.lang.invoke.MethodHandles$Lookup(java.lang.Class,int)
WARNING: Please consider reporting this to the maintainers of org.codehaus.groovy.vmplugin.v7.Java7$1
WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
WARNING: All illegal access operations will be denied in a future release
08:20:56,514 INFO  ~ Application 'myapp' is now started !
08:20:56,674 INFO  ~ Listening for HTTP on port 9000 ...
```


