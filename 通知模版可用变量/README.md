# 通知模版可用变量

## 作业任务通知模版

```
作业名称:${name}
任务编号:${uuid}
作业状态:${status}
服务树名称:${projectname}

可以通过下面链接访问作业：http://域名/#/history/jobdetail/${projectid}/${uuid}

```

## 构建通知模版
```
状态: ${status}
服务树:${treename}
项目名称: ${projectname}
代码仓库地址: ${addr}
版本: ${version}
触发测试环境发布: ${calltestenv}
触发线上环境发布: ${callonlineenv}
错误信息: ${errormsg}
构建日志: ${buildlog}

通过下面链接可以访问流水线:http://域名/#/quickentry/flowlinedetail/${treeid}/${projectid}

```

## 审批通知模版

```
审批内容: ${cont}

审批链接:http://域名/#/quickapproval/${uuid}
极速审批【访问速度快】:http://域名/api/job/approval/fast/${uuid}

```
[cont具体内容变量](/发起审批/README.md)

## 监控系统告警通知模版

```
告警名称: ${labels.alertname}
状态中文状态：${statusZH}
状态英文状态：${status}
告警时间中国时区: ${startsAtZH}
告警时间世界时间: ${startsAt}
监控对象: ${labels.instance}
告警名称: ${labels.alertname}
告警概要: ${annotations.summary}
服务树名称: ${treename}
别名【主机监控事是机器的hostname，mysql监控是别名】: ${hostname}

故障描述：${annotations.descriptions}
```

## 邮件系统邮件内容监控通知模版

```
账号名称：${labels.account}
邮件标题: ${labels.subject}
邮件内容：${labels.content}

```
