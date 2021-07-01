# 简介

系统提供了两个方式让用户往服务树节点上“上传文件”。

文件上传后系统会进行保存，用户可以用这些文件进行流水线发布，或者把文件上传到远程服务器上。

# 通过页面上传

页面路径:【业务管理】->【文件管理】

通过页面进行文件上传，相同服务树节点下，同名文件上传会进行覆盖。

![文件管理](/文件管理/images/文件管理.png)

# 通过命令行上传

OPEN-C3提供了一个方式可以通过命令行的方式上传文件。

```
格式：
curl -X POST http://OPEN-C3地址/api/job/fileserver/服务树节点ID/upload -F "filename=@/tmp/xxx.txt" -H 'token: 申请的TOKEN'
例子：
curl -X POST http://10.10.0.1/api/job/fileserver/10/upload -F "filename=@/tmp/xxx.txt" -H 'token: 3415eddd7412589b167620ce8f7c0a48'
```

注：在创建token的时候，可以配置成文件上传后触发一个作业。

![token管理](/文件管理/images/token管理.png)