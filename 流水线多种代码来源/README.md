
# 介绍

在通过流水线进行CI/CD配置时，代码地址和代码依赖可以使用本文描述的多种代码来源。

![代码地址填写处](/流水线多种代码来源/images/代码地址.png)

# 多种代码来源

## git

如果地址中包含 “git@” 或者 ‘.git’ 被认为是git代码。

git的票据可以使用SSH Key类型。

## openc3fileserver

如果地址是“openc3://*”，表示使用的是，OPEN-C3本服务树节点的数据文件。

此处不需要票据。

文件可以通过前端页面上传，也可以通过命令行上传。

文件格式： tar.gz ,但是上传的时候建议不要保留后缀，比如可以把文件命名为：release-001。

例，把/tmp/foo 目录打包成版本release-001进行上传：
```
cd /tmp/foo
tar -zcvf release-001 *
```

打完包后上传到业务管理中的[文件管理](/文件管理/README.md)处，可以通过页面上传，也可以通过命令上传。

## harbor

如果地址是“/tags”结尾，说明是harbor的镜像地址。

例：
```
http://harbor-china.openc3.com/api/repositories/linkfoo/linkfoo-api/tags
https://registry.hub.docker.com/v1/repositories/nginx/tags
```

接口返回样式：
![harbor](/流水线多种代码来源/images/harbor.png)

该链接可以在harbor页面中查看,需要有name字段,如存在下图中的“detail=1”等参数需要去掉：
![harbortag](/流水线多种代码来源/images/harbortag.png)

票据使用“用户名密码”方式，就是harbor登录的用户名密码。

拉取镜像后会自动生成一个Dockerfile文件，可以直接用[构建触发脚本](/构建触发脚本/README.md)直接上传到其他仓库。

## 阿里云镜像仓库

如果地址是以“aliyuncr://”开头，说明是阿里云镜像仓库地址。
例：
```
aliyuncr://registry.cn-hangzhou.aliyuncs.com/foo/foo-core
```

注：
```
使用这个功能需要如下操作：
1.安装阿里云linux客户端工具
wget https://aliyuncli.alicdn.com/aliyun-cli-linux-latest-amd64.tgz
tar -xf aliyun-cli-linux-latest-amd64.tgz
cp aliyun /usr/local/bin
2.使用RAM进行子账号权限管理
创建RAM子账号，并对该子账号授权，记录账号的AccessKey ID等信息
权限名称: AliyunContainerRegistryFullAccess,AliyunContainerRegistryReadOnlyAccess
3.配置客户端工具
aliyun configure

一个OPEN-C3系统目前只支持一个阿里云账号，并且配置到机器中。
```

票据使用“用户名密码”方式，就是docker登录的用户名密码。

拉取镜像后会自动生成一个Dockerfile文件，可以直接用[构建触发脚本](/构建触发脚本/README.md)直接上传到其他仓库。

## svn

如果不匹配上面描述的方式，就被认为是svn代码。

票据使用“用户名密码”方式。

# 特殊使用场景

## 需要管理配置文件

可以配置一个openc3fileserver方式的地址作为依赖，然后把配置文件放到OPEN-C3的文件管理中。
README.md
比如业务代码中没有dockerfile文件，运维配置过程中可以把dockerfile文件放在[文件管理](/文件管理/README.md)中。

## 构建代码工作已经在它处完成

这样就可以不需要把编译好的代码从新放到git或者svn中打tag来触发OPEN-C3系统。

可以配置成openc3fileserver的方式，让构建完成的代码直接上传到OPEN-C3中等待发布。

## 手写版本发布

代码地址处写'null'时说明没有代码来源，进行手写版本发布。

流水线中如果配置了作业和机器分组，可以看到手写版本发布的提交按钮。
