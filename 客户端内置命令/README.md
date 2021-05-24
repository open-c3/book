# 简介

机器安装了客户端后，客户端内置了一些命令方便用于做发布等工作。

# 发布命令

主机发布时，使用的是tar.gz格式的压缩包，客户端提供了如下命令进行解压和切软连接操作
```
[root@openc3]# mydan deploy
SYNOPSIS
     $0 [--repo /my/repo || mayi@127.0.0.1::pkg/foo] [--link /my/link] [--version release-x.x.x]

        [--path /my/path ( default $repo/data ) ]
        [--keep 10 (default 10)]
        [--taropt '-m']
        [--rsyncopt '-v']
        [--stage]

        Version 'release-x.x.x' and 'rollback:release-x.x.x' are the same
        Version 'comeback:release-x.x.x' rollback to before release-x.x.x
        Version backup refers to the $link.backup
        Version backup\d* refers to the $link.backup\d*
```

参数详解：

```
主要参数：

    repo： 压缩包所在的路径，也可以指定一个远程的rsynd服务的路径
    link: 软链接的路径
    version: 要切换到的版本

次要参数：

    path: 解压的目录存放的路径，如不指定，默认存放在repo路径下的data文件夹中。
    keep: 保留几个版本的数据，默认是10个，多出来的部分会自动删除。
        删除的文件分两部分，一个是压缩包，一个是解压的目录，都是根据最后的更新时间来判断新旧。
        其中删除规则只会删除同样格式的版本。如abc-001和ddd-002不是一类数据，不会进行计数。
    taropt：tar解压文件时候添加的额外参数，如可以添加-m参数，解压出来的文件的时间就是当前系统的时间。
        在某些情况下需要注意这个问题，比如php的程序需要根据时间排判断是否需要重新编译，如果当前时间和压缩包内文件的如果时间差异比较大，可能会导致php频繁编译而导致系统负载过高，这种情况下可以添加-m参数。
    rsyncopt 同步文件使用的而额外参数。
    stage: 单纯解压或者同步数据，不切软连接。
        在某种场景下，需要进行集群同一版本切换，如果版本包很大，不论是解压的形式还是rsync的形式，都会比较慢，这时候需要先提前stage把要用的目录准备好。
```

例子：

```
如要发布的应用名称为foo，在作业中可以写成如下 ：
mydan deploy --repo /data/package/foo --link /data/app/foo --version $1
然后在脚本参数中写： $version
```
# 检查命令

发布结束后用于检查服务是否正常。

```
[root@openc3]# mydan check
SYNOPSIS
     $0 proc.num
          proc.num name    [=~]foo [<>=]5 ...
          proc.num cmdline  =foo   '>1' '<4'
          proc.num exe      ~foo   '>1'

          proc.time name =foo '>180'
 
        http.check
          http.check [get|post] http://127.0.0.1/stat code 200 300
          http.check [get|post] http://127.0.0.1/stat grep ok health

        net.port.listen
          net.port.listen tcp 80 22
          net.port.listen udp 53

          --debug
```

## 进程数量检查
```
proc.num name 匹配/proc/$pid/status文件中Name字段
proc.num cmdlne 匹配/proc/$pid/cmdline文件中的内容
proc.num exe 匹配/proc/$pid/exe软链接的名称

例1:
[root@openc3]# mydan check  proc.num  cmdline =job_api '>2'
5>2 ok
ok.
检查进程名为job_api的进程数量是否大于2，如果不大于2会错误退出，返回码非0

例2:
[root@openc3]# mydan check  proc.num  cmdline ~job_api '=1'
6=1 err
Check ERROR.

进程名包含job_api的进程是否等于1，不等于1错误退出，返回码非0.

```

## http 服务检查
```
http.check [get|post] http://127.0.0.1/stat code 200 300 检查url返回码
http.check [get|post] http://127.0.0.1/stat grep ok health 检查url返回内容

例1:
[root@openc3]# mydan check  http.check get http://127.0.0.1/stat code 200
get http://127.0.0.1/stat code:404
Check ERROR.

get请求http://127.0.0.1/stat 看是否返回码是200。支持同时检查多个返回码，多个返回码用空格分开。

例2:
[root@localhost 2710]# mydan check  http.check get http://127.0.0.1/stat grep ok
get http://127.0.0.1/stat fail
Check ERROR.

get请求http://127.0.0.1/stat看返回内容是否包含ok字样。

```

## 检查端口

```
net.port.listen tcp 80 22 检查tcp端口是否处于监听状态
net.port.listen udp 53 检查udp端口是否处于监听状态

例1:
[root@openc3]# mydan check  net.port.listen tcp 80 22
tcp 80 listen
tcp 22 listen
ok.

通过返回码确定是否要检查的端口已经全部打开，全部打开的情况下会输出ok，同时返回码是0

例2:
[root@openc3]# mydan check  net.port.listen tcp 80 123
tcp 80 listen
[Error] tcp 123 not listen
Check ERROR.

异常的情况。
```