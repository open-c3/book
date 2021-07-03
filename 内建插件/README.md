# 简介

系统内置了如下内建插件：

* [kubectl](/kubectl/README.md) : 用于发布kubernetes服务，支持原生kubectl的所有命令。
* [terraform](/terraform/README.md) ：用于资源编排。
* [kubestar.v2](/kubestar.v2/README.md)(推荐) ： 用于通过kubestar发布kubernetes服务。
* [kubestar](/kubestar/README.md)(不推荐)：  同上。
* [awsecs](/awsecs/README.md) ： 用于发布AWS中ECS服务。
* [sendemail](/sendemail/README.md) ：用于发送邮件。
* [sendmesg](/sendmesg/README.md) ： 用于发送消息，根据连接器配置而定，可能是短信也可能是im消息。
* [flowcaller](/flowcaller/README.md) ： 用于调用流水线进行应用群发布。
* [cdnrefresh](/cdnrefresh/README.md) ： 对各CDN厂商的CDN进行刷新。

#说明

```
为了扩展作业步骤所能完成的处理逻辑，OPEN-C3定义了一个内建插件的功能。

内建插件是一个可执行的二进制程序或者脚本，执行过程会在OPEN-C3所部署的服务器中执行。

可以根据需要开发，如需要添加新的内建插件，请提交插件到如下地址：

https://github.com/open-c3/open-c3/tree/v2.1.1/JOB/buildin/  # 其中v2.1.1 是您使用的OPEN-C3版本。
```

#开发

通过环境变量往插件中传递参数，参数如下：

* > $ENV{CONFIGPATH}: 配置文件,也就是脚本内容文本文件路径
* > $ENV{JOBUUID} : 运行该任务的作业的UUID，如不是作业该变量为空
* > $ENV{NODE} ： 机器列表，用逗号分隔
* > $ENV{TICKETFILE} : 票据文件路径
* > $ENV{TIMEOUT} ： 超时时间
* > $ENV{TREEID} ： 服务树ID
* > $ENV{TASKUUID} ： 任务UUID

返回：
插件需要在标准输出中输出“机器ip:ok”，每个操作对象一行，表示该操作对象操作成功。
