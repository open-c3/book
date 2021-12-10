# 作业模块

url前缀： /api/job

## 审批 approval

### GET /approval

获取最后一百条审批数据。

### POST /approval

提交审批意见。

参数：
```
    uuid: 审批单号
    opinion： 审批意见，为“agree”或者“refuse”
```

### GET /approval/:uuid

获取审批详情。

参数：
```
    uuid: 审批单号。
```

### GET /approval/control/:uuid

不用登陆验证获取本任务相关审批列表。如当前需要步骤需要两个人审批，这里会返回两个人的列表。用于手机端审批。uuid为审批单据唯一编号。

用户手机审批时，可以看到是否只需要自己审批，如有其他人审批，其他人是谁，什么意见是什么。

### GET /approval/control/status/:uuid

不登录获取审批数据。

### POST /approval/control

不登录提交审批意见。

参数：
```
  uuid： 审批单号。
  opinion： 审批意见，为“agree”或者“refuse”
```

## 命令行终端 cmd

### GET /cmd/:treeid

打开虚拟终端。

参数：
```
  sudo：是否需要的用户名，如： root、worker
  node: 机器ip，多个需要用逗号分隔
  bash: 如bash为真，为进入单个机器。如果bash不存在，为打开批量操作。
  siteaddr： openc3网站地址，最后会根据这个地址进行跳转。
```

### GET /cmd/:treeid/log

获取虚拟终端操作日志。

参数：
```
  user： 通过user进行过滤，模糊匹配。
  node： 通过node进行过滤，模糊匹配。
  usr： 通过执行账户进行过滤，模糊匹配。
  cmd： 通过执行命令进行过滤，模糊匹配。
  time_start: 开始日期，格式为 0000-00-00
  time_end: 结束日期： 格式为 0000-00-00
```

## 定时任务 crontab

### GET /crontab/:treeid

获取定时任务列表。

参数：
```
  name: 定时任务名称，模糊匹配。
  create_user: 创建用户。
  edit_user: 最后编辑的用户。
  create_time_start: 创建开始时间，格式为 0000-00-00。
  create_time_end: 创建结束时间，格式为 0000-00-00。
  edit_time_start: 编辑开始时间，格式为 0000-00-00。
  edit_time_end: 编辑结束时间，格式为 0000-00-00。
```

### GET /crontab/:treeid/count

获取定时任务数量。

### GET /crontab/:treeid/:crontabid

通过定时任务id获取定时任务详情。

### POST /crontab/:treeid

创建定时任务。

参数：
```
  name: 定时任务名。
  jobuuid： 作业uuid。
  cron: 定时任务规则。
  mutex：互斥锁。
```

### POST /crontab/:treeid/:crontabid

修改定时任务配置。

参数：
```
  name: 定时任务名。
  jobuuid： 作业uuid。
  cron: 定时任务规则。
  mutex：互斥锁。
```

### POST /crontab/:treeid/:crontabid/status

修改定时任务状态。

参数：
```
  status: 定时任务的开关状态，为“available”或者“unavailable”。 默认新创建的为为启动状态。
```

### DEL /crontab/:treeid/:crontabid

删除定时任务。


## 环境变量配置 environment

### GET /environment

 获取平台变量。

### POST /environment

修改环境变量。

参数：
```
| isCiSuccessSms         | true  |  构建成功是否发送短信。
| isCiFailSms            | true  |  构建失败是否发送短信。
| isCrontabWaitingSms    | true  |  定时执行任务卡住是否发送短信。
| isPageFailSms          | true  |  页面执行任务失败是否发送短信。
| isPageWaitingEmail     | true  |  页面执行卡住是否发送邮件。
| isCiSuccessEmail       | true  |  构建成功是否发送邮件。
| isApiSuccessEmail      | false |  api方式执行作业成功是否发送邮件。
| isApiFailEmail         | true  |  api方式执行作业失败是否发送邮件。
| isPageWaitingSms       | true  |  页面执行卡住是否发送短信。
| isPageSuccessEmail     | false |  页面执行成功是否发送邮件。
| isApprovalSuccessSms   | true  |  审批事件是否发送短信。
| isCrontabFailEmail     | true  |  定时任务执行失败是否发送邮件。
| isCrontabWaitingEmail  | true  |  定时任务卡住是否发送邮件。
| isCiFailEmail          | true  |  构建失败是否发送邮件。
| isPageFailEmail        | true  |  页面执行任务失败是否发送邮件。
| isApiWaitingSms        | true  |  通过api执行任务卡住是否发送短信。
| isCrontabSuccessEmail  | false |  定时任务执行成功是否发送邮件。
| isApiWaitingEmail      | true  |  通过api调用执行任务卡住是否发送邮件。
| isPageSuccessSms       | false |  通过页面执行作业成功是否发送短信。
| isApiFailSms           | true  |  通过api调用执行作业失败是否发送短信。
| isCrontabFailSms       | true  |  通过定时任务执行作业失败是否发送短信。
| isApprovalSuccessEmail | true  |  审批事件是否发送邮件。
| isCrontabSuccessSms    | false |  定时任务执行任务成功是否发送短信。
| isApiSuccessSms        | false |  api执行任务成功是否发送短信。

| notifyTemplateEmailContent   |  通知邮件内容模版。
| notifyTemplateEmailTitle     |  通知邮件标题模版。
| ciTemplateEmailContent       |  构建通知邮件内容模版。
| ciTemplateEmailTitle         |  构建通知邮件标题模版。
| approvalTemplateEmailContent |  审批邮件内容模版。
| approvalTemplateEmailTitle   |  审批邮件标题模版。
| ciTemplateSmsContent         |  构建短信消息短信模版。
| notifyTemplateSmsContent     |  通知消息短信模版。
| approvalTemplateSmsContent   |  审批消息短信模版。

```

## 文件管理 fileserver

### GET /fileserver/:treeid

获取文件列表。

### POST /fileserver/:treeid

上传文件到文件管理中。

### GET /fileserver/:treeid/download

下载文件。

参数:
```
name: 下载的文件名。
```

### POST /fileserver/:treeid/upload

通过命令行上传文件。

### DEL /fileserver/treeid/:fileid

删除文件。

## 作业 jobs

### GET /jobs/:treeid

获取作业列表。

参数：
```
  name: 作业名称，模糊匹配。
  create_user: 创建用户名。
  edit_user: 编辑用户名。
  create_time_start: 创建开始时间，格式：0000-00-00。
  create_time_end: 创建结束时间，格式：0000-00-00。
  edit_time_start: 创建开始时间，格式：0000-00-00。
  edit_time_end: 编辑结束时间，格式：0000-00-00。
```

### GET /jobs/:treeid/count

查看作业数量。

### GET /jobs/:treeid/:jobuuid

获取作业详情。

### POST  /jobs/:treeid/copy/byname

复制作业。

参数：
```
fromprojectid: 源服务树节点id，可以为空，默认为当前服务树id。
toprojectid: 目标服务树id，可以为空。默认为当前服务树id。
fromname：源作业名称。
toname: 目标作业名称。
```


### POST /jobs/:treeid

创建作业。

参数：
```
name: 作业名称。
data: 作业步骤数据。数组格式。
  timeout: 步骤超时，缺省情况下为60秒。
  pause: 作业暂停。
  plugin_type: 插件类型，目前有三种类型【cmd、scp、approval】，每中类型需要不一样的数据。

    plugin_type 为 cmd时需要如下参数：
      name： 步骤名称。
      user： 命令执行用户。
      node_type: 机器类型【buildin、group、variable】
        node_type 为 buildin时，需要参数node_cont 为用逗号分隔的机器列表。
        node_type 为 group时，需要参数node_cont 为本服务节点下的机器分组id。
        node_type 为variable时，需要参数node_cont 为变量名称，如 $ip
      scripts_type: 脚本类型【cite、content】。
         scripts_type 为 cite时，需要参数scripts_cont为本节点脚本管理中的脚本id。
         scripts_type 为 content时，需要参数scripts_cont为脚本内容。
      scripts_argv：脚本参数。

    plugin_type 为scp时需要如下参数。
      name： 步骤名称。
      user: 执行用户
      src_type: 源机器类型
      src:
      dst_type: 目标机器类型
      dst：
      sp: 源路径
      dp: 目标路径
      chown: 文件最后的chown。
      chmod: 文件最后的chmod。

    plugin_type 为approval时需要如下参数。
      name： 步骤名称。
      cont： 审批内容。
      approver：审批人，多个用逗号分隔。
      deployenv：发布环境【test、online、always】。
      action： 动作。[deploy、rollback、always]。
      batches: 分批【firsttime、thelasttime、always】。
      everyone: 是否每个人都需要审批。【on、off】

```

### POST /jobs/:treeid/:jobuuid

更新作业的内容。

参数：和上一个接口的创建作业一致。

### DEL /jobs/:treeid/:jobuuid

删除作业。

### DEL /jobs/:treeid/:jobname/byname

通过作业名称删除作业。

## 模块监控信息 monitor

### GET /monitor/metrics/mysql

获取mysql的监控信息。

### GET /monitor/metrics/app

获取作业模块的监控信息。

## 机器组 noedgroup

### GET /nodegroup/:treeid

获取机器组列表。

参数:
```
name: 机器组名称，模糊匹配。
plugin: 插件名称。
create_user: 创建用户名。
edit_user: 编辑用户。
create_time_start: 创建开始时间，格式 0000-00-00。
create_time_end: 创建结束时间, 格式 0000-00-00。
edit_time_start: 编辑开始时间，格式 0000-00-00。
edit_time_end: 编辑结束时间，格式 0000-00-00。
```

### GET /nodegroup/:treeid/:id

获取机器组的详情。

### GET /nodegroup/:treeid/:id/nodelist

获取机器组的机器列表。

### POST /nodegroup/:treeid

创建机器组。

参数：
```
name: 机器组名称。
plugin: 参数名称。【node、type】
params: 当plugin为node时，params为机器列表，多个机器用逗号分隔。 当plugin为type时，params为类型列表，多个类型用逗号分隔。
```

### POST /nodegroup/:treeid/:id

更新机器组内容。

参数： 和创建机器组一致。

### DEL /nodegroup/:treeid/:id

删除机器组。

## 节点机器信息 nodeinfo

### GET /nodeinfo/:treeid

获取机器列表信息。

### GET /nodeinfo/:treeid/check

检查节点是否属于该服务树节点。

参数：
```
node: 机器列表，ip列表，多个ip用逗号分隔。
```

### GET /nodeinfo/:treeid/count

获取机器数量。

## 机器管理 nodelist

### GET /nodelist/:treeid

获取机器管理中的机器列表。

参数：
```
name: 机器名，模糊匹配。
inip：机器内网ip，模糊匹配。
exip：机器外网ip，模糊匹配。
create_user: 创建用户。
edit_user: 编辑用户。
create_time_start: 创建开始时间，格式 0000-00-00。
create_time_end: 创建结束时间，格式 0000-00-00。
```

### POST /nodelist/:treeid

往机器管理中添加机器。

参数：
```
name: 两种格式 “ip” 或者“机器名::内网ip::外网ip”
```

### DEL /nodelist/:treeid/:id

删除机器管理中的机器。

## 报警通知 notify

### GET /notify/:treeid

获取报警通知人列表。

### POST /notify/:treeid

添加通知人到报警通知列表。

参数:
```
user: 用户名。一般情况下是邮箱地址。
```

### DEL /notify/:treeid/:id

删除报警通知中的通知人。

## 服务树状态 project

忽略。

## 释放 release

### GET /release

判断服务树下的资源释放已经释放。

参数：
```
id： 要判断的服务树id，多个id用逗号分隔。
```

## 脚本管理

### GET /scripts/:treeid

获取脚本列表。

参数：
```
name: 脚本名称，模糊匹配。
create_user: 创建用户。
edit_user: 编辑用户。
create_time_start: 创建开始时间，格式 0000-00-00。
create_time_end: 创建结束时间，格式 0000-00-00。
edit_time_start: 编辑开始时间，格式 0000-00-00。
edit_time_end: 编辑结束时间， 格式 。0000-00-00。
```

### GET /scripts/:treeid/:scriptsid

获取脚本详情。

### POST /scripts/:treeid

创建脚本。

参数:
```
name: 脚本名称。
type: 脚本类型【shell、perl、python、php、buildin、auto】。
cont: 脚本的内容。
```

### POST /scripts/:treeid/:scriptsid

更新脚本。

参数： 参数和创建脚本一致。

### DEL /scripts/:treeid/:scriptsid

删除脚本。


## 文件发送 sendfile

### GET /sendile/list/:treeid

获取远程服务器目录下文件列表。

参数：
```
path: 查询路径。格式如“10.10.10.10/tmp”。
sudo: 执行用户名。
```

### POST /sendfile/unlink/:treeid

删除远程服务器目录下文件。

参数:
```
paht: 删除路径，格式如“10.10.10.10/tmp/abc.txt”
sudo: 执行用户名。
```

## slave

### DEL /slave/:slavename/killtask/:uuid

终止任务。

### ws://example.com/slave/:slavename/ws?uuid=xxx

查看任务实时日志。

## 轻应用 smallapplication

### GET /smallapplication

获取轻应用列表。

### GET /smallapplication/:id

获取单个轻应用详情。

### POST /smallapplication

添加轻应用。

参数:
```
jobid: 作业id。
type：类型。随意的字符串。
title: 轻应用标题。
describe： 描述。
parameter：参数。可以为空。
```

### POST /smallapplication/:id

编辑轻应用。

参数： 和创建参数一致。

### DEL /smallapplication/:id

删除轻应用。

## 子任务 subtask

### GET /subtask/:treeid/:taskuuid

获取任务的子任务列表。

### GET /subtask/:treeid/:taskuuid/:subtaskuuid

获取子任务详情。

### POST /subtask/:treeid

操作作业任务。

参数：
```
taskuuid: 任务uuid。
subtaskuuid: 子任务uuid。
subtasktype: 子任务类型。
control： 操作类型。【next、fail、running、ignore】
```

### PUT /subtask/:treeid

操作作业任务。

参数:
```
taskuuid: 任务uuid。
subtaskuuid：子任务uuid。
subtasktype: 子任务类型。
control: 操作类型。【next、running】
```

## 任务 task

### GET /task/:treeid

获取任务列表。

参数：
```
name： 任务名称，模糊匹配。
user： 执行用户。
status： 状态。
taskuuid： 任务uuid。
time_start: 开始时间，格式 0000-00-00。
time_end: 结束时间：格式 0000-00-00。
```

### GET /task/:treeid/count

获取任务执行个数。

###  GET /task/:treeid/total_count

按照时段统计。

参数：
```
time_start: 开始日期。格式 0000-00-00。
time_end: 结束日期，格式 0000-00-00。
```

### GET /task/:treeid/:uuid

获取任务详情。

### POST /task/:treeid/redo

任务重做。

参数：
```
taskuuid: 任务的uuid。
```

### GET /task/:treeid/authorization/:group/:jobname

验证作业是否授权给研发执行。

参数：
```
jobname: 作业名称。
group： 机器分组名称。
```

### POST /task/:treeid/job

执行作业任务。

参数：
```
jobuuid: 作业的uuid。
variable：变量。HASH结构的k、v对。
```

### GET /task/:treeid/job/bymon

忽略。

### POST /task/:treeid/job/byname

通过作业名启动任务。

参数：
```
jobname: 作业名称。
uuid： 任务uuid，如果存在uuid，以这个uuid为准，如果没有会自动生成，页面调用一般不传uuid。给系统之间调用使用。
variable：变量。HASH结构的k、v对。
```

### POST /task/:treeid/plugin_cmd

执行命令插件。

参数：
```
name: 任务名称。
user： 执行账号。
node_type: 节点类型。【buildin、group】
node_cont: 当node_type 为buildin时，node_cont为机器ip列表列表，多个用逗号分隔。当node_type 为group时，node_cont 为机器组id。
scripts_type: 脚本类型。【cite、shell、perl、python、php、buildin、auto】
scripts_cont: 脚本内容，当scripts_type 为cite时候，scripts_cont为脚本管理中的脚本id，其他情况下为脚本的内容。
scripts_argv: 脚本参数。
timeout： 超时时间，单位为秒。
variable：变量。HASH结构的k、v对。
```

### POST /task/:treeid/plugin_scp

执行文件同步插件。

参数:
```
name: 任务名称。
user: 执行用户。
src_type: 源类型【buildin、group、fileserver、ci】。
src：源机器。当src_type为buildin时候，src为机器ip列表，多个ip用逗号分隔。当src_type为group时，src为机器组id。当src_type为ci时。src为ci变量。当src_type为fileserver时，src为空。
dst_type: 目标类型【buildin、group】。
dst： 目标机器。当dst_type为buildin时，dst为机器ip列表，多个ip用逗号分隔。当dst_type为group时，dst为机器组id。
sp：源路径。
dp：目标路径。
chown：修改最终文件的属主。
chmod：修改最终文件的权限。
timeout：超时。
scp_delete： 是否同步目录时候删除多出来的文件。默认情况下为0。
variable：变量。HASH结构的k、v对。
```

### POST /task/:treeid/plugin_approval

执行审批插件。

参数:
```
name: 审批名称。
cont: 审批内容。
approver: 审批人，多个审批人用逗号分隔。
deployenv: 审批生效环境。【test、online、always】
action: 审批生效的动作。【deploy、rollback、always】
batches: 审批生效的分批。【firsttime、thelasttime、always】
everyone: 是否需要所有人审批。【on、off】
timeout: 超时。单位：秒。
```

### GET /task/:treeid/analysis/last

获取最后几条任务数据。

参数:
```
count: 获取的条数，默认为10。
```

### GET /task/:treeid/analysis/date

获取最近30天的任务按照日期的趋势图数据。

### GET /task/:treeid/analysis/hour

获取最近30天的任务按照小时的趋势图数据。

### /task/:treeid/analysis/runtime

获取最近30天运行任务时长的统计。

### GET /task/:treeid/analysis/statistics

获取最近30天执行任务次数统计。

## 第三方调用API third

## 文件管理中TOKEN管理 token

### POST /token/:treeid/info

获取token列表信息。[应该换成GET方式]

参数:
```
create_user: 创建用户。
edit_user: 编辑用户。
create_time_start: 创建开始日期。格式： 0000-00-00。
create_time_end: 结束日期。格式： 0000-00-00。
```

### POST /token/:treeid

创建token。

参数：
```
token: token的字符串。
describe: 描述。
isjob：bool值，是否调用作业。
jobname: 作业名称，当isjob为true时，需要作业名称参数。
```

### DEL /token/:treeid/:id

删除token。

## 账户管理 userlist

### GET /userlist/:treeid

获取账户管理中用户列表。

参数：
```
name: 用户名称，模糊匹配。
create_user: 创建用户。
edit_user: 编辑用户。
create_time_start: 创建开始时间。格式 0000-00-00。
create_time_end: 创建结束时间。格式 0000-00-00。
```

### POST /userlist/:treeid

创建账户。

参数：
```
username: 创建的账户名。
```

### DEL /userlist/:treeid/:id

删除账户。

## 变量管理 variable

### GET /varuable/:treeid/:jobuuid

获取作业的变量。

参数：
```
empty: 如果存在该变量，只返回值为空的变量。
exclude：排查变量名，多个变量名用逗号分隔。
```

### POST /variable/:treeid

提交变量。

参数:
```
jobuuid: 作业uuid。
name: 变量名。
value： 变量的值。
describe：变量的描述。
```

### POST /variable/:treeid/update

更新作业变量。

参数：
```
jobuuid: 作业uuid。
data: 变量数据。格式 [ +{ name => '', value => '', describe => '' } ]
```

### DEL /variable/:treeid

删除变量。

参数：
```
jobuuid: 作业的uuid。
name： 变量名称。
```

## 变量 vv

### GET /vv/:treeid

获取变量汇总。

参数：
```
node: 匹配的node。
name：匹配的变量名。
time_start: 更新开始时间，格式：0000-00-00。
time_end: 更新结束时间，格式 0000-00-00。
```

### GET /vv/:treeid/table

表格形式查询变量。

参数：同上。

### GET /vv/:treeid/list

忽略。

### DEL /vv/:treeid/:node

删除某个node的所以变量。

## GET /vv/:treeid/analysis/version

获取一年内的版本统计。

# AGENT模块

url前缀： /api/agent

## AGENT agent

### GET /agent/:treeid

获取agent的状态。

### GET /agent/:treeid/:regionid

获取区域详情。

### POST /agent/:treeid/:regionid/subnet

添加子网。

参数：
```
subname: 子网描述，如 10.10.10.10/24
```

### DEL /agent/:treeid/:agentid

删除agent信息。

## 检查状态开关

### GET /check/:treeid

获取开关信息。

### POST /check/:treeid

修改状态开关信息。

参数：
```
status: 新状态，【on、off】
```

## 继承关系 inherit

### GET /inherit/:treeid

查看继承关系。

## 安装 install

忽略。

## 自监控 monitor

### GET /monitor/metrics/mysql

查看agent的mysql状态。

### GET /monitor/metrics/app

查看agent应用状态。

## nodeinfo

### GET /nodeinfo/:treeid

获取节点下机器节点。

### GET /nodeinfo/:treeid/check

检查节点是否在节点下合法。

参数:
```
node: 要检查的ip列表，用逗号分隔。
```

### GET /nodeinfo/:treeid/count

机器的数量。

## 服务树节点和区域关联 project_region_relation

### GET /project_region_relation/:treeid

获取服务树节点关联的区域。

### POST /project_region_relation/:treeid

绑定区域关联到服务树节点上。

### DEL /project_region_relation/:treeid/:regionid

删除关联。

## 代理

### GET /proxy/:treeid

获取代理情况。

### GET /proxy/:treeid/:regionid

获取服务树节点某个区域的代理列表。

### DEL /proxy/:treeid/:proxyid

删除代理。

### POST /proxy/:treeid/:region

添加代理机器。

参数：
```
ip:代理ip，多个用逗号分隔。
```

## 区域 region

### GET /region/:treeid

获取服务树节点下区域。

### POST /region/:treeid

创建区域。

参数：
```
name: 区域名称。
```

### DEL /region/:treeid/:regionid

根据区域id删除区域。

### GET /region/:treeid/active

获取服务树节点下活跃的区域。

## slave

忽略。

# 连机器模块

url前缀： /api/connector

## 配置 config

### GET /config

获取配置信息。

### POST /config

更新配置。

### GET /config/list

获取配置列表。

## connectorx

### GET /connectorx/nodeinfo/:treeid

获取服务树下资源列表。

### GET /connectorx/usertree

获取用户服务树信息。

### GET /connectorx/usertree/treemap

获取用户服务树列表。

### GET /connectorx/treemap

获取全量服务树列表。

### GET /connectorx/point

权限点检查。

### GET /connectorx/username

内部连接器查询用户名称。

### GET /connectorx/cookiekey

cookie的key名称。

### GET /connectorx/sso/userinfo

获取用户信息，前端使用。

### GET /connectorx/sso/loginredirect

前端跳转登录。

参数：
```
siteaddr: open-c3地址。
callback: 回调地址。
```

### GET /connectorx/sso/chpasswdredirect

前端跳转修改密码页面。

### GET /connectorx/ssologout

登出页面。清除cookie。

### POST /connectorx/notify

消息发送接口。

### POST /connectorx/approval

发起审批。

参数：
```
content: 审批内容。
submitter：提交人。
approver： 审批人。
```
### GET /connectorx/approval

获取审批状态。

参数:
```
uuid: 审批uuid。
```

### POST /connectorx/auditlog

提交审计日志。

参数：
```
user: 用户。
title： 标题&分类。
content： 审计日志内容。
```

### GET /connectorx/auditlog

获取审计日志。

参数:
```
time: 时间，模糊前缀匹配。
user：用户，模糊前缀匹配。
title：标题模糊前缀匹配。
content：内容模糊前缀匹配。
```

### GET /connectorx/setcookie

设置cookie

参数：
```
cookie: cookie的内容。
c3redirect: c3跳转地址。
```

## default

缺省的内部连接器，忽略。

## 私有节点 private

### GET /private

获取私有节点列表。

### POST /private

创建私有节点。

参数：
```
user: 用户名，一般情况下使用邮箱。
```

## release

### GET /release

判断open-c3平台下节点是否可以释放。

参数:
```
id: 服务树id，多个id用逗号分隔。
```

## 地址簿 useraddr

### GET /useraddr

获取地址簿列表

### POST /useraddr

往地址簿中添加用户地址。

参数：
```
user: 用户名，一般情况下为邮箱地址。
email: 用户的邮箱地址。
phone： 用户的手机号，如果是用的飞书等其他im工具做出口，写对应的唯一标示。
```

### DEL /useraddr/:id

地址簿中删除用户地址。

## 版本 version

### GET /version/log

当前版本更新情况。

### GET /version/name

当前版本名称。