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