# 简介

sendemail插件用于发送邮件。发送的邮件标题默认会添加“OPEN-C3:”的前缀。

# 使用方式

脚本内容第一行为邮件标题，其他脚本内容为邮件内容

脚本参数为邮件接收人列表，多个人用逗号或者空格分隔。

例：

脚本内容：
```
#!sendemail
邮件测试
邮件内容第一行
邮件内容第二行 abc
```

脚本参数：
```
foo@abc.com,bar@gmail.com
```