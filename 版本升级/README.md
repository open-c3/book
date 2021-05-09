# 版本说明

open-c3根据git中的branch进行管理版本，C3版本包含三个数字。

版本格式为：v.第一个组数字.第二组数字.第三组数字 如：v1.0.0

数字含义：
```
第一个组数字：目前发布的主版本。有比较打的更改。
第二个组数字：偶数表示稳定版本；奇数表示开发中版本。
第三个组数字：错误修补的次数。
```

每一次版本的变化可能涉及到数据库表结构的更改或者操作，除了切换到分支外，需要对应做相应的操作。

注： 只能按照下面持续进行依次升级，不可以跳过版本升级。

# v1.0.0 -> v.2.0.0

本次升级，所以的数据库名都会加上前缀。需要重新生产数据库表，导数据，清理旧数据。

## 停服务

停止c3服务。

## 切换分支

切换分支到v.2.0.0

## 导入新的数据库表结构
```
cat */schema.sql |grep -v 'create database' |docker exec -i openc3-mysql mysql -uroot -popenc3123456^!
```

## 数据复制
```
use ci;
insert into openc3_ci_favorites select * from `favorites`;
insert into openc3_ci_images select * from `images`;
insert into openc3_ci_keepalive select * from `keepalive`;
insert into openc3_ci_project select * from `project`;
insert into openc3_ci_rely select * from `rely`;
insert into openc3_ci_repository select * from `repository`;
insert into openc3_ci_ticket select * from `ticket`;
insert into openc3_ci_version select * from `version`;

use jobs;
insert into openc3_job_approval select * from `approval`;
insert into openc3_job_cmdlog select * from `cmdlog`;
insert into openc3_job_crontab select * from `crontab`;
insert into openc3_job_crontablock select * from `crontablock`;
insert into openc3_job_environment select * from `environment`;
insert into openc3_job_fileserver select * from `fileserver`;
insert into openc3_job_jobs select * from `jobs`;
insert into openc3_job_keepalive select * from `keepalive`;
insert into openc3_job_nodegroup select * from `nodegroup`;
insert into openc3_job_nodelist select * from `nodelist`;
insert into openc3_job_notify select * from `notify`;
insert into openc3_job_pause select * from `pause`;
insert into openc3_job_plugin_approval select * from `plugin_approval`;
insert into openc3_job_plugin_cmd select * from `plugin_cmd`;
insert into openc3_job_plugin_scp select * from `plugin_scp`;
insert into openc3_job_project select * from `project`;
insert into openc3_job_scripts select * from `scripts`;
insert into openc3_job_smallapplication select * from `smallapplication`;
insert into openc3_job_subtask select * from `subtask`;
insert into openc3_job_task select * from `task`;
insert into openc3_job_token select * from `token`;
insert into openc3_job_userlist select * from `userlist`;
insert into openc3_job_variable select * from `variable`;
insert into openc3_job_vv select * from `vv`;

use jobx;
insert into openc3_jobx_flowline_version select * from `flowline_version`;
insert into openc3_jobx_group select * from `group`;
insert into openc3_jobx_group_type_list select * from `group_type_list`;
insert into openc3_jobx_group_type_percent select * from `group_type_percent`;
insert into openc3_jobx_keepalive select * from `keepalive`;
insert into openc3_jobx_monitor select * from `monitor`;
insert into openc3_jobx_subtask select * from `subtask`;
insert into openc3_jobx_task select * from `task`;

use agent;
insert into openc3_agent_agent select * from agent;
insert into openc3_agent_check select * from check;
insert into openc3_agent_inherit select * from inherit;
insert into openc3_agent_install select * from install;
insert into openc3_agent_install_detail select * from install_detail;
insert into openc3_agent_keepalive select * from keepalive;
insert into openc3_agent_monitor select * from monitor;
insert into openc3_agent_project_region_relation select * from project_region_relation;
insert into openc3_agent_proxy select * from proxy;
insert into openc3_agent_region select * from region;

use connector;
insert into openc3_connector_auditlog select * from `auditlog`;
insert into openc3_connector_group select * from `group`;
insert into openc3_connector_group_type_list select * from `group_type_list`;
insert into openc3_connector_group_type_percent select * from `group_type_percent`;
insert into openc3_connector_keepalive select * from `keepalive`;
insert into openc3_connector_log select * from `log`;
insert into openc3_connector_nodelist select * from `nodelist`;
insert into openc3_connector_subtask select * from `subtask`;
insert into openc3_connector_task select * from `task`;
insert into openc3_connector_tree select * from `tree`;
insert into openc3_connector_userauth select * from `userauth`;
insert into openc3_connector_userinfo select * from `userinfo`;
insert into openc3_connector_usermail select * from `usermail`;
insert into openc3_connector_usermesg select * from `usermesg`;

```

## 启服务

重新启动c3服务。

## 观察7天后没问题清理旧数据

为了保证当前正在执行的任务能正常执行，请延后清理旧数据。

```
use ci;

drop table favorites;
drop table images;
drop table keepalive;
drop table project;
drop table rely;
drop table repository;
drop table ticket;
drop table version;

use jobs;
drop table `approval`;
drop table `cmdlog`;
drop table `crontab`;
drop table `crontablock`;
drop table `environment`;
drop table `fileserver`;
drop table `jobs`;
drop table `keepalive`;
drop table `nodegroup`;
drop table `nodelist`;
drop table `notify`;
drop table `pause`;
drop table `plugin_approval`;
drop table `plugin_cmd`;
drop table `plugin_scp`;
drop table `project`;
drop table `scripts`;
drop table `smallapplication`;
drop table `subtask`;
drop table `task`;
drop table `token`;
drop table `userlist`;
drop table `variable`;
drop table `vv`;

use jobx;

drop table `flowline_version`;
drop table `group`;
drop table `group_type_list`;
drop table `group_type_percent`;
drop table `keepalive`;
drop table `monitor`;
drop table `subtask`;
drop table `task`;


use agent;
drop table `agent`;
drop table `check`;
drop table `inherit`;
drop table `install`;
drop table `install_detail`;
drop table `keepalive`;
drop table `monitor`;
drop table `project_region_relation`;
drop table `proxy`;
drop table `region`;

use connector;
drop table `auditlog`;
drop table `group`;
drop table `group_type_list`;
drop table `group_type_percent`;
drop table `keepalive`;
drop table `log`;
drop table `nodelist`;
drop table `subtask`;
drop table `task`;
drop table `tree`;
drop table `userauth`;
drop table `userinfo`;
drop table `usermail`;
drop table `usermesg`;
```
