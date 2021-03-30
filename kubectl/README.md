# 票据管理

在个人票据中管理自己的票据。票据类型选择作业内建插件。

票据内容为kubeconfig。

![票据管理](/kubectl/images/管理票据.png)


# 配置作业流程

在流水线、作业、快速脚本中的用法都一致，如下。

## apply (应用)

发布应用，是一次发布的操作。
![kubectl-apply](/kubectl/images/kubectl-apply.png)

使用内建插件，点击选择kubectl类型。

脚本内容：

```
#!kubectl
---
apiVersion: v1
kind: Pod
metadata:
  name: kube100-site
  labels:
    app: web
spec:
  containers:
    - name: front-end
      image: nginx:DEPLOYVERSION
      ports:
        - containerPort: 80
    - name: flaskapp-demo
      image: jcdemo/flaskapp
      ports:
        - containerPort: 5000
```

脚本中用到了关键字DEPLOYVERSION, 系统调用过程中会用脚本参数中的第二个参数替换DEPLOYVERSION。

票据： 选择上第一步创建的票据

脚本参数： apply $version

在做CI/CD过程中$version就是代码仓库中打的tag。

## check （检查发布状态）

检查应用的发布状态。
![kubectl-check](/kubectl/images/kubectl-check.png)

使用内建插件，点击选择kubectl类型。

脚本为如下固定内容：
```
#!kubectl
```

票据： 选择上第一步创建的票据

脚本参数：check deployment namespace desiredImage
