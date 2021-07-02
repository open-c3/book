# 升级方法

## 单机版

运行下面命令进行升级:
```
/data/open-c3/Installer/scripts/upgrade.sh
```

升级过程中会拉取最新的代码、重新构建前端，重启后端服务

## 集群版

先升级预发布环境，预发布环境和单机版升级方式一样。升级好预发布环境，在预发布环境上对集群进行升级。

运行下面命令进行升级:

```
/data/open-c3/Installer/scripts/upgrade.sh clustername 
```
其中clustarname就是要升级的集群名称。


# 回滚方法

下面命令可以做集群的回滚和升级：
```
[root@localhost open-c3]# ./Installer/scripts/cluster.sh  deploy
SYNOPSIS
     $0 --evnname txy 
     $0 --evnname txy --version 001
     $0 --evnname txy --version 001 --rollback
     $0 --evnname txy --version 001 --hostname 'foo'

 ```

* > --envname : 集群名称。
* > --version : 要发布或者回滚的版本。
* > --rollback: 该参数存在说明是要回滚。
* > --hostname: 只操作集群中的某个机器。

# 升级单个模块

```
# 脚本路径
[root@localhost deploy]# pwd
/data/open-c3/Installer/cluster/deploy
# 可以单独操作的模块列表
[root@localhost deploy]# ll
总用量 36
-rwxr-xr-x. 1 root root 2732 1月  11 10:49 AGENT.pl
-rwxr-xr-x. 1 root root 1846 1月  11 17:27 c3-database.pl
-rwxr-xr-x. 1 root root 2214 1月  11 19:19 c3-front.pl
-rwxr-xr-x. 1 root root 1929 1月  11 10:49 CI.pl
-rwxr-xr-x. 1 root root 1963 1月  11 10:49 Connector.pl
-rwxr-xr-x. 1 root root 1934 1月  11 10:49 JOB.pl
-rwxr-xr-x. 1 root root 1951 1月  11 10:49 JOBX.pl
-rwxr-xr-x. 1 root root 1928 1月  11 10:49 MYDan.pl
-rwxr-xr-x. 1 root root 1949 1月  11 10:49 web-shell.pl

# 单个模块的操作方式，参数和上面的例子一致。
[root@localhost deploy]# ./CI.pl 
SYNOPSIS
     $0 --evnname txy 
     $0 --evnname txy --version 001
     $0 --evnname txy --version 001 --rollback
     $0 --evnname txy --version 001 --hostname 'foo'

[root@localhost deploy]#

```