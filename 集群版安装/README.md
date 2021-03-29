# OPEN-C3 集群版安装

集群模式可以根据实际情况进行灵活的调整。以下以四台服务器部署方式，集群名bar为例。

四台机器ip分别为 10.10.10.1，10.10.10.2，10.10.10.3，10.10.10.4。

注：其中10.10.10.4用于部署数据库服务，如果有高可用的数据库可以省去这台机器，直接把数据库配置的部分改成数据库真实的地址，OPEN-C3配置涉及到5个模块，如果不用OPEN-C3自动创建的数据库服务，需要在对应模块目录下找到schema.sql文件来对数据库进行初始化。

## 准备运行环境

四台服务器，配置如下：
* 操作系统：CentOS 7
* CPU: 4核
* 内存: 8G

## 安装单机版用于预发布环境

[单机版安装教程](/单机版安装/README.md)

## 添加集群配置

### 修改AGENT配置文件

```
[root@open-c3]#cat >> /data/open-c3/AGENT/config/Config <<EOF
bar:
  host:
    open-c3-c-1:
      inip: 10.10.10.1
    open-c3-c-2:
      inip: 10.10.10.2
    open-c3-c-3:
      inip: 10.10.10.3

  envinfo:
    domainname: open-c3.org
    appname: agent
    appkey: c3random

  mysql:
    host: 10.10.10.4
    username: root
    password: 'openc3123456^!'
    port: 3306
    database: agent

  port:
    api:
      from: 8001
      to: 8005
    api.slave:
      from: 8006
      to: 8010

EOF

```

### 修改JOB配置文件

```
[root@open-c3]#cat >> /data/open-c3/JOB/config/Config <<EOF

bar:
  host:
    open-c3-c-1:
      inip: 10.10.10.1
    open-c3-c-2:
      inip: 10.10.10.2
    open-c3-c-3:
      inip: 10.10.10.3

  envinfo:
    appname: job
    appkey: c3random
    domainname: open-c3.org
    cmdcount: 1

  c3-database: 10.10.10.4

  mysql:
    host: 10.10.10.4
    username: root
    password: 'openc3123456^!'
    port: 3306
    database: jobs

  port:
    api:
      from: 8011
      to: 8015
    api.slave:
      from: 8016
      to: 8020

EOF

```

注： 该配置中有一个 c3-database的配置，如果不需要部署脚本部署数据库服务并初始化，需要去掉这个配置。

### 修改JOBX配置文件

```
[root@open-c3]#cat >> /data/open-c3/JOBX/config/Config <<EOF

bar:
  host:
    open-c3-c-1:
      inip: 10.10.10.1
    open-c3-c-2:
      inip: 10.10.10.2
    open-c3-c-3:
      inip: 10.10.10.3

  envinfo:
    appname: jobx
    appkey: c3random
    domainname: open-c3.org

  mysql:
    host: 10.10.10.4
    username: root
    password: 'openc3123456^!'
    port: 3306
    database: jobx

  port:
    api:
      from: 8021
      to: 8025
    api.slave:
      from: 8026
      to: 8030
    
EOF
```

### 修改CI配置文件
```
[root@open-c3]#cat >> /data/open-c3/CI/config/Config <<EOF

bar:
  host:
    open-c3-c-1:
      inip: 10.10.10.1
    open-c3-c-2:
      inip: 10.10.10.2
    open-c3-c-3:
      inip: 10.10.10.3

  envinfo:
    appname: ci
    appkey: 'c3random'
    domainname: open-c3.org
    dockershellcount: 1
    'envname.job': test
    'envname.jobx': test
    'envname.flow': test

  mysql:
    host: 10.10.10.4
    username: root
    password: 'openc3123456^!'
    port: 3306
    database: ci

  port:
    api:
      from: 9011
      to: 9015
    api.slave:
      from: 9016
      to: 9020


EOF

```

### 修改Connector配置文件

```
[root@open-c3]#cat >> /data/open-c3/Connector/config/Config <<EOF

bar:
  host:
    open-c3-c-1:
      inip: 10.10.10.1
    open-c3-c-2:
      inip: 10.10.10.2
    open-c3-c-3:
      inip: 10.10.10.3

  envinfo:
    appname: jobx
    appkey: 8e8da85112d5c94f4a543f99fb451d88
    domainname: open-c3.org

  mysql:
    host: 10.10.10.4
    username: root
    password: 'openc3123456^!'
    port: 3306
    database: connector

  port:
    api:
      from: 8031
      to: 8040

EOF

```

### 修改密码配置文件

```
[root@open-c3]#cat >> /etc/open-c3.password <<EOF
bar:
  username: root
  password: PASSWORD123456

EOF

```
## 初始化环境

```
/data/open-c3/Installer/scripts/cluster.sh  init bar
```

## 初始化数据库

### 通过程序部署的数据库容器实例
```
1. 在job配置文件中添加c3-database字段，如上JOB的配置。
2. 执行初始化：/data/open-c3/Installer/cluster/deploy/c3-database.pl -e bar
3. 在部署数据库的机器上执行：/data/Software/mydan/Installer/cluster/init.sh
4. 在初始化一次：/data/open-c3/Installer/cluster/deploy/c3-database.pl -e bar

```

### 使用已有数据库实例

通过下面文件各种对数据库进行初始化
```
/data/open-c3/AGENT/schema.sql
/data/open-c3/CI/schema.sql
/data/open-c3/Connector/schema.sql
/data/open-c3/JOB/schema.sql
/data/open-c3/JOBX/schema.sql
```

## 部署应用

```
/data/open-c3/Installer/scripts/cluster.sh deploy  --envname bar --version 20210316
```

## 通过浏览器访问服务

### 直接访问
通过 http://10.10.10.1:88 http://10.10.10.2:88 http://10.10.10.3:88 访问集群

注： 可以申请个域名执行这三个地址

### 绑定域名访问

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

### 使用正式域名访问

通过自己绑定的域名访问服务。

### 登录页
![登录页面](/单机版安装/images/登录页面.png)

用户名: open-c3 密码：changeme

### 首页
![刚安装完的首页](/单机版安装/images/刚安装完的首页.png)

登录成功后跳转到如图首页