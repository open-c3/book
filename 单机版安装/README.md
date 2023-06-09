# OPEN-C3 单机版安装

## 准备运行环境

准备一台服务器，配置如下：
* 操作系统：CentOS 7
* CPU: 4核
* 内存: 8G

## 一键安装

注：一般情况下使用以下安装方式即可，如果有网络问题，请使用[C3安装器](https://github.com/open-c3/open-c3-installer)进行安装。
```

curl https://raw.githubusercontent.com/open-c3/open-c3/v2.6.1/Installer/scripts/single.sh | OPENC3VERSION=v2.6.1 bash -s install 10.10.10.10
#(机器的ip地址,如果需要通过公网访问，请填写公网ip)

#访问不了github的用户可以使用下面命令进行安装【以gitee作为数据源】：
#curl https://gitee.com/open-c3/open-c3/raw/v2.6.1/Installer/scripts/single.sh | OPENC3VERSION=v2.6.1 OPENC3_ZONE=CN bash -s install 10.10.10.10
....

[SUCC]openc-c3 installed successfully.
=================================================================
Web page: http://10.10.10.10
User: open-c3
Password: changeme
[INFO]Run command to start service: /data/open-c3/open-c3.sh start

...

Creating openc3-mysql ... done
Creating c3_openc3-server_1 ... done
[SUCC]started.

```
注：程序安装后会产生两个目录，/data/open-c3用于存放代码，/data/open-c3-data用于存放数据【包括数据库数据，日志等】。

## 通过浏览器访问服务

通过 http://10.10.10.10 访问服务

### 登录页
![登录页面](/单机版安装/images/登录页面.png)

用户名: open-c3 密码：changeme

### 首页
![刚安装完的首页](/单机版安装/images/刚安装完的首页.png)

登录成功后跳转到如图首页
