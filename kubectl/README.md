# 简介

kubectl 插件支持原生的kubectl命令，需要两个部分配置。

先在票据管理中配置好kubeconfig，在作业步骤中选择上票据后在脚本参数中写上kubectl命令的参数。

其中kubectl可能需要文件，如apply -f app.yaml，文件来源可以有如下两种
```
情况1: 文件来源于代码仓库

如果是在流水线中使用的kubectl插件，kubectl运行的当前目录下有构建当前版本的文件，可以直接使用。
如代码中有abc.yaml文件，可以直接通过“apply -f abc.yaml”来使用文件。

情况二: 文件来源于当前步骤的配置

可以把需要的文件内容写到“脚本内容”中，然后可以通过关键字CONFIGFILE来指定，如：apply -f CONFIGFILE。

```

# 票据管理

在个人票据中管理自己的票据。票据类型选择“作业内建插件”。

票据内容为kubeconfig的内容。

![票据管理](/kubectl/images/管理票据.png)

# 步骤配置例子

## 镜像更新

脚本参数：set image deployment/nginx c3test-nginx=nginx:$version -n c3test

## 发布检查

脚本参数：check c3test deployment/nginx c3test-nginx=nginx:$version

注：check是OPEN-C3扩展的参数。

## 应用发布

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

脚本中用到了关键字${VERSION}, 系统调用过程如果存在构建版本$version,会用$version变量的内容替换${VERSION}。

脚本参数：apply -f CONFIGFILE -n c3test

## 引用代码仓库中的文件

脚本参数：apply -f pod-app.yaml -n c3test

# 维护注意

需要手动维护OPEN-C3服务所在机器的kubectl命令【单机版更新的是容器中的kubectl】。
```
wget https://github.com/open-c3/open-c3-install-cache/job-buildin/kubectl -O /bin/kubectl
chmod +x /bin/kubectl
```