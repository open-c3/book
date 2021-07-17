# 简介

为了让用户快速体验OPEN-C3的功能，OPEN-C3提供了体验版。

注：如果希望把登录和权限管理托管到聚云立方平台，请使用“结合聚云立方”的方式。

体验版不支持通过镜像来做持续构建。

# 独立使用

通过Docker命令启动服务，当前使用8080端口，根据自己的情况修改。
```
docker run -p 8080:88 openc3/allinone:latest
```

访问服务：http://localhost:8080 。
![openc3登录](/体验版安装/images/openc3-登录.png)

用默认账号登录【用户名： open-c3 密码：changeme】。
![openc3首页](/体验版安装/images/openc3-首页.png)

成功登录后根据操作手册试试吧【[OPEN-C3核心功能](/核心功能/README.md)】。

# 结合聚云立方

登录[聚云立方](https://www.polymericcloud.com)创建一个第三方应用。
![juyun第三方应用](/体验版安装/images/juyun-第三方应用.png)

使用刚才在聚云立方上创建的appkey和appname启动服务。
```
docker run --env JUYUN_APPNAME=openc3 --env JUYUN_APPKEY=82bb208d12bb48fcab5103325dc36acc -p 8080:88 openc3/allinone:latest
```

访问服务：http://localhost:8080 ，会跳转到聚云立方的登录页面进行登录验证。
![juyun登录](/体验版安装/images/juyun-登录.png)

登录成功后自动跳转回OPEN-C3首页。
![juyun首页](/体验版安装/images/juyun-首页.png)

成功登录后根据操作手册试试吧【[OPEN-C3核心功能](/核心功能/README.md)】。