# 场景

先部署了单机版进行测试，如果单机版测试满足需要，可能单机版直接转换成生产使用。

涉及到3个部分的信息：

1. 数据库 ： 可以进行同步
2. 构建包和存储 ： 备份同步数据即可
3. 安装在线上集群上的agent的key。 下面详细讲一下key的解决方案


下面以以后线上集群的名称abc为例：


在容器中执行如下命令【把abc改成以后集群的名称】： 
```
echo abc > /etc/openc3.agent.extendenvname

cd /data/Software/mydan/etc/agent/auth && \
ssh-keygen -f c3_abc -P "" && \
mv c3_abc c3_abc.key && \
echo success
```

重启openc3服务。