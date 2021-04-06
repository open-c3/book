# harbor_push_image.pl

```
用于构建docker镜像，同时上传到harbor中。使用过程中需要选择票据，
票据类型为“用户名密码”，即harbor的登录用户名密码。

```
```
使用格式如下：

harbor_push_image.pl --repository reg.harbordemo.com/c3test/app1 --dockerfile  foo/Dockerfile

参数：
 --repository ： 要上传的仓库项目地址，上传的版本为构建出的代码版本，比如git中的tag。
 --dockerfile ： dockerfile的路径，如果不指定，默认为代码构建包根目录中的Dockerfile文件。

```
