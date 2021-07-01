# OPEN-C3 单机版安装

## 准备运行环境

准备一台服务器，配置如下：
* 操作系统：CentOS 7
* CPU: 4核
* 内存: 8G

## 下载代码

```
[root@open-c3]#mkdir -p /data
[root@open-c3]#cd /data
[root@open-c3]#git clone https://github.com/open-c3/open-c3
```
注：服务启动后数据会存放在/data/open-c3-data目录下【包括数据库数据，日志等】

## 安装

```
[root@open-c3]#./open-c3.sh  install 10.10.10.10 #(机器的ip地址,如果需要通过公网访问，请填写公网ip)

....

[SUCC]openc-c3 installed successfully.
=================================================================
Web page: http://10.10.10.10
User: open-c3
Password: changeme
[INFO]Run command to start service: ./open-c3.sh start
```

## 启动服务

```
[root@open-c3]# ./open-c3.sh start

....

Creating openc3-mysql ... done
Creating c3_openc3-server_1 ... done
[SUCC]started.


```

## 通过浏览器访问服务

通过 http://10.10.10.10 访问服务

### 登录页
![登录页面](/单机版安装/images/登录页面.png)

用户名: open-c3 密码：changeme

### 首页
![刚安装完的首页](/单机版安装/images/刚安装完的首页.png)

登录成功后跳转到如图首页

## 升级

建议安装后查看[维护升级手册](/维护升级/README.md)把服务更新到最新。

```
为了缩短安装的时间，安装的时候用了部分预先构建的数据，建议安装结束后进行一次升级操作。
```