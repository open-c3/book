# 简介

tsunamiudp 通过UDP协议传输文件，加速文件分发。

以下说明适用于单机版.


# 使用

```
1. 使用内建插件tsunamiudp。
2. 插件参数填写要加速的代理的ip地址，多个地址用英文逗号分隔。
```

# 维护


## 添加配置

在配置文件/data/open-c3/Connector/config.inix 中添加如下配置

```
tsunamiudp:
  serverip: 10.x.x.x #tsunamiudp服务端的地址，也就是openc3单机版本的地址。

```
## 安装tsunami-udp

在单机版本和需要加速的代理服务器中安装tsunami-udp。安装方式如下

```
# cd /data
# git clone  https://github.com/cheetahmobile/tsunami-udp
# cd tsunami-udp
# ./recompile.sh 

#注: 如有报错请请安装工具依赖 yum install autoconf automake libtool
#安装路径固定在/data目录中。
```
## 启动tsunami-udp服务端

在OPENC3单机版本的宿主机上服务守护进程：

/opt/mydan/dan/bootstrap/exec/tsunamiudp

```
#!/bin/bash

export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$MYDanPATH/bin

os=$(uname)
_exit () { echo $1; sleep 60; exit 1; }

if [ "x$os" = "x" ];then
     _exit "uname fail"
fi

echo "os: $os";

if [ "x$os" == "xLinux" ] ;then
    ulimit -n 655350 || _exit "ulimit -n fail";
    ulimit -u 102400 || _exit "ulimit -u fail";
    ulimit -s 10240  || _exit "ulimit -s fail";
fi

cd /data/open-c3-data/glusterfs/tsunamiudp || _exit "ulimit -n fail";
pwd
exec /data/tsunami-udp/server/tsunamid 2>&1
```

## 在代理中添加插件
```
把OPENC3单机版本的下面文件
/data/open-c3/JOB/buildin/tsunamiudp.code/tsunami2proxy

拷贝到代理机的如下路径（该文件要有可执行权限）
/opt/mydan/dan/agent/code/tsunami2proxy
```
## 添加网络访问权限

开放服务端（OPENC3的机器）的51038 TCP端口，允许需要加速的代理机访问。

开放代理机的51038-51058 UDP端口，允许OPENC3机器访问（服务端）。
