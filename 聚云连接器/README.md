# 对接聚云立方

如果需要把OPEN-C3的登录和权限管理模块对接到聚云立方上进行管理，需要进行如下操作。

## 在聚云立方上添加appkey，appname

![聚云第三方应用管理](/聚云连接器/images/聚云第三方应用管理.png)

## 修改连接器配置

把 /data/open-c3/Connector/config.ini/juyun 文件中的 xxxxxx 更换成上一步在聚云中创建的appkey

（默认的appname为openc3，如果创建的appname不一样请自行更改。）

然后把更换好appkey和appname的文件替换到/data/open-c3/Connector/config.inix

单机版默认情况下，/data/open-c3/Connector/config.inix文件内容更改，服务会自动重启，

服务重启后对接完成。
