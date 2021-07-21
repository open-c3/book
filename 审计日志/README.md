# 简介

OPEN-C3的所有操作都会有审计日志。管理员可以进行查看。

页面路径：【管理员】->【审计日志】

# 审计日志

管理员可以在全局信息中看到如下的审计日志，包含了用户的所有操作。

![审计日志](/审计日志/images/审计日志.png)

```
查询方式：
时间： like str%, 即前缀匹配
用户: == str，即全匹配
标题: like %str% 即模糊匹配
内容: like %str% 即模糊匹配
```

# 审计日志说明
JOBX 分组作业

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| CREATE BATCH | TREEID:$id BATCHNAME:$name | 创建机器分批 |
| EDIT BATCH | TREEID:$id BATCHNAME:$name | 编辑机器分批 |
| DELETE BATCH | TREEID:$id BATCHNAME:$name | 删除机器分批 |
| START JOBX | TREEID:$id JOBNAME:$jobname BATCHNAME:$groupname | 启动分组作业任务 |
| JOBX TASK ROLLBACK | TREEID:$id UUID:$uuid ROLLBACK:[Yes/No] | 选择是否回滚分组作业 |
| KILL JOBX | TREEID:$id TASKUUID:$name | 停止分组作业任务 |

FLOWLINE 流水线

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| CREATE FLOWLINE | TREEID:$id FLOWLINEID:$flowid NAME:$name | 创建流水线 |
| EDIT FLOWLINE CI| TREEID:$id FLOWLINEID:$flowid NAME:$name | 编辑流水线 |
| DELETE FLOWLINE | TREEID:$id FLOWLINEID:$flowid NAME:$name | 删除流水线 |

FAVORITES 收藏夹

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| ADD FAVORITES | FLOWLINEID:$flowlineid NAME:$name | 添加收藏 |
| DEL FAVORITES | FLOWLINEID:$flowlineid NAME:$name | 删除收藏 |

IMAGE 镜像

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| CREATE IMAGE | NAME:$name | 创建镜像 |
| EDIT IMAGE | IMAGEID:$id NAME:$name | 编辑镜像 |
| DELETE IMAGE | IMAGEID:$id NAME:$name | 删除镜像 |
| UPLOAD IMAGE | IMAGEID:$id NAME:$name | 上传镜像文件 |

TICKET 镜像

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| CREATE TICKET | NAME:$name | 创建票据 |
| EDIT TICKET | TICKETID:$id NAME:$name | 编辑票据 |
| DELETE TICKET | TICKETID:$id NAME:$name | 删除票据 |

RELY 依赖

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| ADD RELY | FLOWLINEID:$id ADDR:$addr | 构建添加项目依赖 |
| DEL RELY | FLOWLINEID:$id ADDR:$addr | 删除依赖 |

FIND TAGS 依赖

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| FIND TAGS | TREEID:$id FLOWLINEID:$id | 触发find tags |
| KILL BUILD | FLOWLINEID:$id TAG:$tag | 停止某个版本的构建 |
| START BUILD | TREEID:$id FLOWLINEID:$id TAG:$tag | 触发一个构建任务 |
| STOP ALL BUIL | TREEID:$id FLOWLINEID:$id | 停止流水线中所有的构建 |

SUBNET 代理子网

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| ADD SUBNET | TREEID:$id REGIONID:$id SUBNET:$subnet | 添加子网 |
| DEL SUBNET | TREEID:$id SUBNET:$subnet | 删除子网 |

AGENT CHECK 检测agent状态

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| AGENT CHECK | TREEID:$id STATUS:[on/off] | 服务树定时检测agent状态开关 |

代理

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| USE REGION | TREEID:$id REGIONID:$id REGIONNAME:$name | 服务树节点下使用勾选了某区域 |
| OUT REGION | TREEID:$id REGIONID:$id REGIONNAME:$name | 服务树节点下使用不勾选某区域 |
| ADD PROXY | TREEID:$id REGIONID:$id PROXYIP:$ip | 添加代理 |
| DEL PROXY | TREEID:$id REGIONID:$id PROXYIP:$ip | 删除代理 |
| ADD REGION | TREEID:$id NAME:$name | 添加新区域 |
| DEL REGION | TREEID:$id NAME:$name | 删除区域 |

审批

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| USR APPROVAL | UUID:$approvaluuid OPINION:[agree/refuse] | 个人审批动作 |
| KEY APPROVAL | UUID:$approvaluuid OPINION:[agree/refuse] | 个人审批动作，通过API，不能确认操作人 |

crontat 定时任务

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| CREATE CRONTAB | TREEID:$id NAME:$name | 创建定时任务 |
| EDIT CRONTAB | TREEID:$id NAME:$name | 编辑定时任务 |
| SWITCH CRONTAB | TREEID:$id NAME:$name STATUS:[available/unavailable] | 修改定时任务开关 |
| DELETE CRONTAB | TREEID:$id NAME:$name | 删除定时任务 |

environment 编辑了通知管理和模版管理

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| EDIT ENVIRONMENT | _ | 编辑了通知管理或者模版管理 |

fileserver 文件上传

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| USER UPLOAD FILE | TREEID:$id FILENAME:$filename | 用户通过页面上传文件 |
| TOKEN UPLOAD FILE | TREEID:$id FILENAME:$filename | 脚本通过token上传文件 |
| DELETE FILE | TREEID:$id FILENAME:$filename | 脚本通过token上传文件 |

job 作业编辑

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| CREATE JOB | TREEID:$id NAME:$filename | 创建作业 |
| EDIT JOB | TREEID:$id NAME:$filename | 编辑作业 |
| DELETE JOB | TREEID:$id NAME:$filename | 删除作业 |

nodegroup 机器分组

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| CREATE NODEGROUP | TREEID:$id NAME:$name | 创建分组 |
| EDIT NODEGROUP | TREEID:$id NAME:$name | 编辑分组 |
| DELETE NODEGROUP | TREEID:$id NAME:$name | 删除分组 |

nodelist 机器管理，给服务树节点添加额外机器

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| ADD NODELIST | TREEID:$id NAME:$name | 添加机器 |
| DEL NODELIST | TREEID:$id NAME:$name | 删除机器 |

notify 报警通知人

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| ADD NOTIFY | TREEID:$id USER:$user | 添加报警接收人 |
| DEL NOTIFY | TREEID:$id USER:$user | 删除报警接收人 |

scripts 脚本管理

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| CREATE SCRIPTS | TREEID:$id USER:$name | 添加脚本 |
| EDIT SCRIPTS | TREEID:$id USER:$name | 编辑脚本 |
| DELETE SCRIPTS | TREEID:$id USER:$name | 删除脚本 |

job subtask 作业子任务控制

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| JOB SUBTASK CONTROL | TREEID:$id TASKUUID:$taskuuid SUBTASKUUID:$subtaskuuid CONTROL:[next/fail/running/ignore] | 添加脚本 |

job task 作业子任务控制

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| TASK REDO | TREEID:$id TASKUUID:$taskuuid | 从做任务 |
| START JOB TASK | TREEID:$id JOBUUID:$jobuuid | 启动任务 |
| START JOB CMD | TREEID:$id TASKNAME:$name TASKUUID:$uuid | 快速启动脚本 |
| START JOB SCP | TREEID:$id TASKNAME:$name TASKUUID:$uuid | 快速同步文件 |
| START JOB APPROVAL | TREEID:$id TASKNAME:$name TASKUUID:$uuid | 快速审批 |
| KILL JOB TASK | TREEID:$id TASKUUID:$uuid NAME:$name| 停止作业任务 |

job vv 变量管理

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| DELETE VV | TREEID:$id NODE:$node | 删除node相关的变量查看中的记录 |

connector 连接器

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| EDIT CONNECTOR CONFIG | _ | 修改连接器配置 |

sendfile 文件发送

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| UNLINK FILE | TREEID:$id SUDO:$sudo PATH:$host/$path | 删除线上机器文件 |


smallapplication 轻应用

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| CREATE SMALLAPPLICATION | NAME:$name | 创建轻应用 |
| EDIT SMALLAPPLICATION | NAME:$name | 编辑轻应用 |
| DELETE SMALLAPPLICATION | NAME:$name | 删除轻应用 |

useraddr 地址簿

| 标题  | 内容 | 解释 |
| ----  |---- | ---- |
| CREATE USERADDR | USER:$user EMAIL:$email PHONE:$phone | 添加地址簿 |
| DELETE USERADDR | USER:$user EMAIL:$email PHONE:$phone | 删除地址簿 |