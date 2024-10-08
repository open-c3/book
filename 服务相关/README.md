# 容器内不能上外网【通信方式：bridge】

```
$ sudo service docker stop
$ sudo pkill docker
$ sudo iptables -t nat -F
$ sudo ifconfig docker0 down
$ sudo brctl delbr docker0
$ sudo service docker start

```

# 安装OPEN-C3集群后，页面获取机器信息报错

解决办法：重启服务

# 上传镜像因文件太大而失败

修改Nginx配置文件，添加如下配置【文件名：/etc/nginx/nginx.conf 】
client_max_body_size 2048m;

如：
```
http {
    include       /etc/nginx/mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    client_max_body_size 2048m;

    access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    keepalive_timeout  65;

    #gzip  on;

    include /etc/nginx/conf.d/*.conf;
}
```

# 单机版中第一次拉取新git仓库代码出错
```
把容器中mydan的版本更新到最新，新的/data/Software/mydan/dan/tools/git中
会处理StrictHostKeyChecking=no。

集群版的没有这个问题。
```

# OPEN-C3中提交的服务任务分配异常

集群机器时间不同步，运行下面命令启动时间同步服务。

/data/Software/mydan/dan/tools/ntpsync -d 

# 显示的任务时间不对

时区不正确，通过mysql命令查看时间：select curtime(); 如果时区不正确需要通过下面方式进行调整。

第一种方法：
这种方法，不需要重启mysql，但是重启mysql时需要重新设置。
```
> set global time_zone = '+8:00';  ##修改mysql全局时区为北京时间
> set time_zone = '+8:00';  ##修改当前会话时区
> flush privileges;  #立即生效
```

第二种方法：这种方式需要重启mysql。
```
# vim /etc/my.cnf  ##在[mysqld]区域中加上
default-time_zone = '+8:00'

# /etc/init.d/mysqld restart  ##重启mysql使新时区生效
```

# 通过机器进行构建，不下载密钥也能正常使用

OPEN-C3服务端需要安装最新的mydan才能进行构建机器的私钥分离。否则会引起权限问题，

让不应该有权限的人访问到其他人的构建机。

# 运行环境：centos8+docker20+ 安装报错

运行环境：centos8+docker20+

错误描述：

在服务器安装docker后生成容器时出现出如下错误

runc: symbol lookup error: runc: undefined symbol: seccomp_api_get

错误原因：

这是缺少头文件或者相关的库之类的问题，是缺少了依赖包，于是安装依赖包

解决办法：

yum install libseccomp-devel


# 集群版制定域名【可以不做该操作，直接域名指向即可】

【注：在新版本中已经做了80端口的默认配置，不在需要指定域名】
```
在集群版安装步骤“部署应用”中，可以通过添加环境变量来进行域名绑定，只需要第一次部署的时候添加即可。
也可以随时在发布的时候通过这个变量来切换域名。
```
命令如：
```
C3_DOMAIN=myopenc3.myopenc3.org /data/open-c3/Installer/scripts/cluster.sh deploy  --envname bar --version 20210316

# myopenc3.myopenc3.org 即想绑定的域名
```

添加环境变量C3_DOMAIN逻辑上做了以下配置文件的修改操作

```
cd /etc/nginx/conf.d && cp open-c3.conf open-c3.pri.conf
cat open-c3.pri.conf
server {
    listen       80;
    server_name  myopenc3.myopenc3.org; #这里改成自己的域名

    location / {
        proxy_pass http://127.0.0.1:88;

        proxy_redirect    off;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header Host $host:$server_port;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}

```
