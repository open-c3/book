# 简介

OPEN-C3提供的一个方式，支持在作业步骤中可以调用流水线进行流水线发布。

# 使用

## 学习流水线用法

学习[流水线](/流水线/README.md)的用法。

## 在作业中调用流水线

### 插件说明
![flowcaller编辑](/flowcaller/images/flowcaller编辑.png)


```
选择内建插件：flowcaller
插件内容：
#!flowcaller     # 插件名称
flowid: 70       # 流水线编号
envname: online  # 调用的环境，test为测试环境，online为线上环境
env:             # 环境变量，没有可以为空
  foo: ${foo}    # 具体的环境变量，其中${foo}格式的可以从脚本参数自动传递进去


脚本参数： $version $foo_version $foo_rollback_version foo=$foo $ip=$ip
参数格式说明:
    $version【固定内容】
    $foo_version【传递给流水线的发布版本】
    $foo_rollback_version【传递给流水线的回滚版本】
    foo=$foo【可以是多个，用于替换插件内容，用于替换流水线变量】
    $ip=$ip 【固定内容】
```

### 作业变量说明

![flowcaller变量](/flowcaller/images/flowcaller变量.png)

* > 在执行时变量的顺序会根据描述的文本进行排序。
* > 固定变量【点击查看OPEN-C3中的[作业变量](/作业变量/README.md)用法】：
    * > version: deploy
    * > _rollbackVersion_: rollback
    * > ip: group:val=openc3skipnode
* > 非固定变量属于自定义部分，根据实际情况进行配置，如应用群中的发布版本号都一样，就可以配置一样的变量名。

## 添加到轻应用


学习[轻应用](/轻应用/README.md)的用法，把配置的作业添加到轻应用。

## 执行

进到轻应用列表页：
![轻应用选择](/flowcaller/images/轻应用选择.png)

点击进入配置的应用群发布：
![轻应用执行](/flowcaller/images/轻应用执行.png)