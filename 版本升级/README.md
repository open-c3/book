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