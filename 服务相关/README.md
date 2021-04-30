# 容器内bridge 不能上外网

```
$ sudo service docker stop
$ sudo pkill docker
$ sudo iptables -t nat -F
$ sudo ifconfig docker0 down
$ sudo brctl delbr docker0
$ sudo service docker start

```

# 安装集群模式后查看页面会获取机器信息报错

解决办法：重启服务


# 上传镜像文件太大失败


Nginx 添加这个配置(文件名： /etc/nginx/nginx.conf )
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

# 服务任务分配异常

集群机器时间不同步，运行下面命令启动时间同步服务。

/data/Software/mydan/dan/tools/ntpsync -d 

# 时区不正确

通过mysql命令查看时间：select curtime(); 如果时区不正确需要通过下面方式进行调整。

第一种方法：
这种方法，不需要重启mysql，但是重启mysql时需要重新设置
```
> set global time_zone = '+8:00';  ##修改mysql全局时区为北京时间
> set time_zone = '+8:00';  ##修改当前会话时区
> flush privileges;  #立即生效
```

第二种方法：这种方式需要重启mysql
```
# vim /etc/my.cnf  ##在[mysqld]区域中加上
default-time_zone = '+8:00'

# /etc/init.d/mysqld restart  ##重启mysql使新时区生效
```

# 通过机器进行构建，不下载密钥也能正常使用

OPENC3服务端需要安装最新的mydan才能进行构建机器的私钥分离。否则会引起权限问题，让不应该有权限的人访问到其他人的构建机。