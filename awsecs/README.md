# 介绍

awsecs为作业内建插件，用于发布aws的ecs服务。使用方式如下

# 票据

在流水线使用过程中需要用[awsecr_push_image.pl](/构建触发脚本/README.md)把构建的包build成镜像上传到aws的ecr服务中，它们使用的是同一个票据。请参考脚本的票据。

# 配置作业流程

## apply （应用）

发布应用，是一次发布的操作。

![apply](/awsecs/images/apply.png)

使用内建插件，点击awsecs类型。

脚本内容：
```
#!awsecs
task-definition: test-front-service
region: cn-northwest-1
cluster: testfoo
service: test-front-service
```

脚本参数： apply $version

## check（检查发布状态）

配置和apply基本一样，在脚本参数改成 check 即可。

系统会在超时时间内每10秒检查一下服务的状态，直到对应的服务当前检查的版本是Running状态后退出。

![check](/awsecs/images/check.png)

# 维护注意

使用该插件需要安装aws命令，安装方式[awsecr_push_image.pl](/构建触发脚本/README.md) 处查看。