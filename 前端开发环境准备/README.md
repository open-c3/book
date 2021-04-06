# 简介

OPEN-C3是通过angularjs进行开发。下面提供了两个方式来准备开发环境。
```
如果是前端工程师，建议使用“纯前端工程师”的方式。
如果是前后端都进行开发的工程师，建议使用“全栈开发的方式”。
```

# 纯前端工程师

```
1. OPEN-C3代码中的c3-front为前端代码，根据c3-front/README.md中的描述准备开发环境。
2. 绑定本地hosts文件，把域名open-c3.org指向后端服务器地址，如：10.10.10.1 open-c3.org
```

# 全栈开发


1. 在本地安装OPEN-C3单机版，[点击查看安装教程](/单机版安装/README.md)

2. 

```
运行下面命令启动前端开发环境

/data/open-c3/Installer/scripts/dev.sh start 10.10.10.10(open-c3 api IP)

启动后会多一个docker实例openc3/gulp。通过访问 3000端口来进行访问。直接修改c3-front目录中的文件即可。
```