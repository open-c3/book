# 关于内建插件

```
OPEN-C3的作业中只有三个插件，分别是“执行脚本”、“同步文件”、“审批”。

但是我们依然有很多的功能需要在作业步骤中进行。比如发布kubernetes服务，对资源进行编排、或者服务更新后调用测试服务。

当然我们可以通过“执行脚本”的方式把这部分操作指定到某一个机器中执行。这样也能满足要求，
但是给非管理员使用OPEN-C3带来了操作负担。因为每个人的实现方式可能都不一样，所以也不能很好的进行规范化。

为了支持这部分功能，OPEN-C3在执行脚本处添加了内建插件的方式。

考虑到内建插件是专门用于做某一件事情，所以插件的提供者可能使用任何开发语言。
```

**设计理念：**

```
允许在步骤中添加插件，插件允许使用不同的开发语言进行开发，
插件的加入和删除不能影响核心功能，同时不要修改数据库表结构。
```