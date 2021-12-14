# 版本说明

OPEN-C3根据git中的branch来进行版本管理，OPEN-C3版本包含三个数字。

版本格式为：v.第一个组数字.第二组数字.第三组数字 如：v1.0.0

数字含义：
```
第一个组数字：目前发布的主版本。有比较大的更改。
第二个组数字：偶数表示稳定版本；奇数表示开发中的版本。
第三个组数字：错误修补或者子功能升级的次数。
```

每一次版本的变化可能涉及到数据库表结构的更改或者操作，除了切换到分支外，需要对应做相应的操作。

注： 只能按照下面顺序依次升级，不可以跳过版本升级。

# v1.0.0 -> v.2.0.0

本次升级，所以的数据库名都会加上前缀。需要重新生产数据库表，导数据，清理旧数据。

## 停服务

停止OPEN-C3服务。

## 切换分支

切换分支到v.2.0.0

## 导入新的数据库表结构

注：【不能多次升级，否则可能会丢失数据】
```
./Installer/upgrade/v2.0.0/update.sh
```

## 启服务

重新启动OPEN-C3服务。

## 清理旧数据

为了保证当前正在执行的任务能正常执行，观察7天后再清理旧数据。

```
./Installer/upgrade/v2.0.0/clean.sh
```

# v2.0.0 -> v.2.1.0

* > 影响代理的继承功能。
* > 服务树名称内部缓存。
* > 支持用户地址簿管理。

```
use agent;
ALTER TABLE openc3_agent_inherit  MODIFY COLUMN inheritid VARCHAR(100) COMMENT 'inheritid';

#2021年 05月 25日 星期二 19:50:44 CST
ALTER TABLE openc3_agent_inherit  ADD `fullname` VARCHAR(300) comment 'fullname';
alter table openc3_agent_inherit modify `fullname` varchar(300) DEFAULT NULL COMMENT 'fullname' AFTER inheritid;

#2021年 05月 27日 星期四 15:07:40 CST
use connector;
create table `openc3_connector_useraddr`(
`id`            int(16) unsigned not null primary key auto_increment comment 'id',
`user` VARCHAR(100) comment 'user',
`email` VARCHAR(100) comment 'email',
`phone` VARCHAR(100) comment 'phone',
`edit_time` TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP comment 'time',
`edit_user` VARCHAR(100) comment 'edit_user',
UNIQUE KEY `uniq_user` (`user`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='useraddr';
```

# v2.1.0 -> v.2.1.1

* > 支持private服务树节点。
* > 支持git报告和流水线报告。

```
use connector;

create table `openc3_connector_private`(
`id`            int(16) unsigned not null primary key auto_increment comment 'id',
`user` VARCHAR(100) comment 'user',
`edit_time` TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP comment 'time',
`edit_user` VARCHAR(100) comment 'edit_user',
UNIQUE KEY `uniq_user` (`user`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 comment='private';

insert into openc3_connector_private(id,user)values('4000000001','open-c3');
delete from openc3_connector_private;
```

```
wget http://opensource.wandisco.com/centos/7/git/x86_64/wandisco-git-release-7-1.noarch.rpm && rpm -ivh wandisco-git-release-7-1.noarch.rpm
yum install git -y
git --version
 
git version 2.31.1
```

```
mysql从5.5升级到5.7,mysql字段变化如下:
https://github.com/open-c3/open-c3/commit/415a199408ea302d785f27447cfa69c244e395a9

=====================================================================
单机版升级步骤如下：

I.先执行一次普通升级：【升级后服务正常】
/data/open-c3/Installer/scripts/upgrade.sh

II.检查一下mysql的备份文件：/data/open-c3-data/backup/mysql

III.可以做一次备份： /data/open-c3/Installer/scripts/datactrl.sh backup

IV.把/data/open-c3/Installer/C3/docker-compose.yml  中的mysql:5.5 改成mysql:5.6
V.执行升级命令 ： /data/open-c3/open-c3.sh reborn

VI.把/data/open-c3/Installer/C3/docker-compose.yml  中的mysql:5.6 改成mysql:5.7
VII.执行升级命令 ： /data/open-c3/open-c3.sh reborn

注： 如果升级过程中失败，多升级几次。在liehu环境中从5.6升到5.7得时候服务没启动失败，多试几次后成功了。

尝试备份数据库： 报错
VIII.[root@localhost scripts]# /data/open-c3/Installer/scripts/databasectrl.sh backup
[INFO]backup to 20210731.182746 ...
mysqldump: [Warning] Using a password on the command line interface can be insecure.
mysqldump: Couldn't execute 'SHOW VARIABLES LIKE 'gtid\_mode'': Table 'performance_schema.session_variables' doesn't exist (1146)
[SUCC]backup done.

处理办法：
1.到数据库容器中执行升级
mysql_upgrade -u root -p123 --force
2.重启数据库
docker restart openc3-mysql
3.重启服务
/data/open-c3/open-c3.sh restart
4.备份数据库
/data/open-c3/Installer/scripts/databasectrl.sh backup

=====================================================================
集群版可以不做数据库版本升级,升级过程中不影响数据库。

```

# v2.1.1 -> v2.2.0

```
#直接更新
/data/open-c3/open-c3.sh upgrade
```

# v2.2.0 -> v2.2.1

```

###数据库发布

use ci;
ALTER TABLE openc3_ci_project ADD `ci_type` VARCHAR(100) DEFAULT 'default' comment 'citype';
ALTER TABLE openc3_ci_project ADD `ci_type_ticketid` VARCHAR(20) comment 'k8sticketid';
ALTER TABLE openc3_ci_project ADD `ci_type_kind` VARCHAR(200) comment 'k8s.kind';
ALTER TABLE openc3_ci_project ADD `ci_type_namespace` VARCHAR(200) comment 'k8snamespace';
ALTER TABLE openc3_ci_project ADD `ci_type_name` VARCHAR(200) comment 'name';
ALTER TABLE openc3_ci_project ADD `ci_type_container` VARCHAR(200) comment 'container';
ALTER TABLE openc3_ci_project ADD `ci_type_repository` VARCHAR(200) comment 'repository';
ALTER TABLE openc3_ci_project ADD `ci_type_dockerfile` VARCHAR(200) comment 'dockerfile';
ALTER TABLE openc3_ci_project ADD `ci_type_dockerfile_content` VARCHAR(3000) comment 'dockerfile_content';

alter table openc3_ci_ticket modify `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP; #如果这条报错请忽略,mysql版本不一样
alter table openc3_ci_ticket modify column `share` VARCHAR(5000);


### 数据库回滚

use ci;
ALTER TABLE openc3_ci_project drop column `ci_type`;
ALTER TABLE openc3_ci_project drop column `ci_type_ticketid`;
ALTER TABLE openc3_ci_project drop column `ci_type_kind`;
ALTER TABLE openc3_ci_project drop column `ci_type_namespace`;
ALTER TABLE openc3_ci_project drop column `ci_type_name`;
ALTER TABLE openc3_ci_project drop column `ci_type_container`;
ALTER TABLE openc3_ci_project drop column `ci_type_repository`;
ALTER TABLE openc3_ci_project drop column `ci_type_dockerfile`;
ALTER TABLE openc3_ci_project drop column `ci_type_dockerfile_content`;

alter table openc3_ci_ticket modify column `share` VARCHAR(100);

#安装依赖

/data/open-c3/Installer/scripts/single/v2.2.1.sh 

```

# v2.2.0 -> v2.3.1

```
#调整数据库
/data/open-c3/Installer/scripts/single/v2.3.1.sql

#安装依赖
/data/open-c3/Installer/scripts/single/v2.3.1.sh 
```


# v2.3.1 -> v2.3.2

##升级
```
#登录数据库, 如下使用默认账号
docker exec -it openc3-mysql mysql -uroot -popenc3123456^!

#更新数据库

use ci;
ALTER TABLE openc3_ci_project ADD `ci_type_open` VARCHAR(20) comment 'open';
ALTER TABLE openc3_ci_project ADD `ci_type_concurrent` VARCHAR(20) comment 'concurrent';
ALTER TABLE openc3_ci_project ADD `ci_type_approver1` VARCHAR(200) comment 'approver1';
ALTER TABLE openc3_ci_project ADD `ci_type_approver2` VARCHAR(200) comment 'approver2';

#切换版本
/data/open-c3/Installer/scripts/versionctrl.sh list
/data/open-c3/Installer/scripts/versionctrl.sh switch v2.3.2

```

##回滚
```
#登录数据库, 如下使用默认账号
docker exec -it openc3-mysql mysql -uroot -popenc3123456^!


#回滚数据库
use ci;
ALTER TABLE openc3_ci_project drop column `ci_type_open`;
ALTER TABLE openc3_ci_project drop column `ci_type_concurrent`;
ALTER TABLE openc3_ci_project drop column `ci_type_approver1`;
ALTER TABLE openc3_ci_project drop column `ci_type_approver2`;

#切回版本
/data/open-c3/Installer/scripts/versionctrl.sh list
/data/open-c3/Installer/scripts/versionctrl.sh switch v2.3.1

```

