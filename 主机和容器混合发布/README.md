# 简介

OPEN-C3提供了发布主机服务和发布容器服务的功能，本文描述怎么在一个流水线中同时发布主机服务和容器服务。

# 使用

同时发布主机服务和容器服务需要下面几个步骤：

* > 学习[流水线](/流水线/README.md)的用法。
* > 学习怎么通过OPEN-C3进行[容器发布](/容器发布/README.md)。
* > 流水线的特殊配置：

![作业配置分批](/主机和容器混合发布/images/作业配置分批.png)

```
流水线和作业中有控制开关，可以配置某个步骤在仅第一个分组执行。

机器分批的时候我们按照主机发布的方式进行机器分批管理。

构建过程中，我们即构建主机发布包，也上传镜像到镜像仓库。

发布步骤中，我们把容器发布和主机发布同时配置在一个流程中，
然后通过“分批”开关把容器发布的步骤配置成“仅第一个分组”执行。
```

发布过程如下：
![作业配置分批](/主机和容器混合发布/images/发布历史.png)