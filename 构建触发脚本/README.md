# 上传docker镜像

## harbor_push_image.pl

```
用于构建docker镜像，同时上传到harbor中。使用过程中需要选择票据，
票据类型为“用户名密码”，即harbor的登录用户名密码。

```
```
使用格式如下：

harbor_push_image.pl --repository reg.harbordemo.com/c3test/app1 --dockerfile  foo/Dockerfile

参数：
 --repository : 要上传的仓库项目地址，上传的版本为构建出的代码版本，比如git中的tag。
 --dockerfile :【可缺省】dockerfile的路径，如果不指定，默认为代码构建包根目录中的Dockerfile文件。

```

## awsecr_push_image.pl

```
用于构建docker镜像，同时上传到aws ecr中，使用过程中需要选择票据，
票据类型为“作业内建插件”，即aws 命令行使用的aws config。

格式如下：
[default]
aws_access_key_id = XXX
aws_secret_access_key = XXX
```
```
使用格式如下：
harbor_push_image.pl --repository 706039051001.dkr.ecr.us-east-1.amazonaws.com/xxx  --dockerfile Dockerfile --registry 706909001001,720909001001

参数： 
--repository : 要上传的仓库项目地址，上传的版本为构建出的代码版本，比如git中的tag。
--dockerfile :【可缺省】dockerfile的路径，如果不指定，默认为代码构建包根目录中的Dockerfile文件。
--registry   :【可缺省】同时注册多个id
```
