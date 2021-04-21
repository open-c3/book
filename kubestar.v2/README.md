# 管理票据

在个人票据中管理自己的票据。票据类型选择作业内建插件。

![票据](/kubestar/images/票据.png)

票据内容示例如下：
```
kubestar-addr: https://cc.polymericcloud.com
access-key: kdAFXKXAjIJ16HZc
secret-key: 0Y2rBiVSGm3eLQMXgZeO0qcn3gNKrYOA
org: "krn::organization::e34f2cf4-6c15-4de9-9286-d018c3f8c612"
```

票据内容来源：

## kubestar-addr 
kubestar控制台的web地址。
![kubestar-addr](/kubestar/images/kubestar-addr.png)

## access-key 和 secret-key
进到kubestar用户列表页面，编辑个人信息中可以看到AK/SK。
![kubestar-key](/kubestar/images/kubestar-key.png)

## org
在kubestar用户列表中可以看到org信息。
![kubestar-org](/kubestar/images/kubestar-org.png)

【注：注意获取的是organization的而不是user的，正确格式如krn::organization::XXX】

# 配置作业流程

在流水线、作业、快速脚本中的用法都一致，如下。

## apply (应用)

发布应用，是一次发布的操作。

![kubestar-apply](/kubestar/images/kubestar-apply.png)

使用内建插件，点击选择kubestar类型。

脚本内容：
```
#!kubestar
vendor: ProviderKubeconfig
region: beijing
cluster-name: ht_k8s
resource-type: Deployment
namespace: c3test
resource-name: nginx
containers:
-
  image: nginx:${VERSION1}
  name: c3test-nginx
```
image中用到了变量${VERSION1}, 系统调用过程中会用脚本参数中的第二个参数开始依次替换${VERSION1},${VERSION2} ...

脚本中的字段来自kubestar控制台的应用列表页面，点击操作中的“KubeStarCtl信息”获取配置。
![kubestar-config](/kubestar.v2/images/kubestar-config.png)

票据：
选择上第一步创建的票据

脚本参数：
apply $version

在做CI/CD过程中$version就是代码仓库中打的tag。

如果一次发布多个容器，脚本参数可以写多个，如 apply $version $version2 $version3

## check （检查发布状态）

配置和apply基本一样，在脚本参数部分把 apply 改成 check。

系统会在超时时间内每10秒检查一下服务的状态，直到对应的服务当前检查的版本是Running状态后退出。

![kubestar-check](/kubestar/images/kubestar-check.png)

# 注

kubestarclt需要的参数是脚本和票据内容的总和，系统实现过程中使用了覆盖的方式。
脚本中的内容会覆盖票据中的内容。
如票据中定义了org，如果脚本中也定义了org，那么以脚本中为主。

只要保证脚本中和票据中的参数加起来没有遗漏，系统就可以获取到全的参数进行调用。

# 维护注意

需要手动维护openc3容器或者集群中有terraform命令 （待优化成自动）
```
wget https://github.com/open-c3/open-c3-install-cache/job-buildin/kubestarctl.v2 -O /bin/kubestarctl.v2
chmod +x /bin/kubestarctl.v2
```

注：如果https://github.com/open-c3没开放，wget可能下载不到文件