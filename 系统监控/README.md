# 简介

openc3自带监控可以查看当前open-c3系统的状态。同时可以结合Prometheus进行监控。


# 自监控
```
管理员进入监控信息页面（如下图）。 第一行的监控指标openc3_system_error为当前系统错误，正常情况下是0。
如果系统出现异常，openc3_system_error显示的是异常的个数，然后在该表格中找到对应的错误具体是哪个。
```
![监控信息](/系统监控/images/监控信息.png)

# 通过Prometheus监控

```
openc3系统提供了访问地址可以获取到系统的监控指标。它符合Prometheus采集数据的接口的要求。
访问地址：（http://my-openc3.domain.org/api/jobx/monitor/metrics）
```
![监控指标](/系统监控/images/监控指标.png)

Prometheus中添加如下配置进行数据采集：

```
  - job_name: 'openc3'
    metrics_path: '/api/jobx/monitor/metrics'
    static_configs:
    - targets: ['my-openc3.domain.org']
```

[点击下载json配置](/系统监控/OPEN-C3-grafana-dashboard.json)文件导入grafana得到下面的监控图。


## 系统错误监控
```
可能存在多个openc3系统，可以通过Grafana变量的方式切换查看不同的openc3集群情况。

其中系统错误有两种：
第一种： 整体的系统错误，如不为0需要立刻进行查看处理
第二种： 日志种的错误，系统通过$log->err() 或者$log->die()打在日志中的错误。
```

![流量监控](/系统监控/images/流量监控.png)

## 系统请求监控
```
每个模块nginx的状态，可以通过这个可以看到每个模块处理的请求的情况。
reading： 正在读取的请求连接
writing： 正在往回写数据的连接
waiting： 等待处理的连接
接受请求/每分钟： 每分钟处理的请求数
nginx状态： nginx的存活状态
```
![流量监控](/系统监控/images/流量监控.png)


## 任务监控
```
通过这部分查看OPENC3系统任务的运行情况：

CI项目数量： 可以查看构建项目中流水线的配置条数，流水线是可以进行关闭的，这里还可以通过有效项目查看生效流水线的数量。
CI运行中：正在执行构建的项目数量
CI构建失败总数： 构建失败的总数
CI构建情况： CI发现tag后不一定都会进行构建，这里显示发现的tag总数和构建成功的总数。

JOBX任务总量： 分批任务执行的总量
JOBX 运行中： 正在运行的分批任务
JOBX 失败总数： 分批任务执行失败的总量
JOBX 子任务总量： 分批任务执行的所有子任务总和

JOB 任务总量： 作业执行的总量
JOB 运行中： 正在执行的作业
JOB 失败总量： 作业失败的总量
JOB 子任务总数： 作业所有执行的步骤的总和

AGENT & PROXY 总量： 系统中AGENT（开启自动检测状态的才进行计算）的总和，系统中代理的总和
AGENT & PROXY 失败数量： 系统中AGENT（只计算开启自动状态检测的）失败的总量，系统中代理失败总量（如果有代理失败要进行处理）。
AGENT 检测状态的项目数： 有多少个项目开启了自动检测AGENT状态的功能
```
![任务监控](/系统监控/images/任务监控.png)

## 系统进程监控

```
显示了各个模块的系统进程数，如果进程数量不对，在最上面的系统错误数中会有体现。
```
![进程监控](/系统监控/images/进程监控.png)

## 操作系统监控

监控系统的了磁盘和负载：
磁盘： 主要监控了三个磁盘（分别是 /、 /data /data/glusterfs）的使用百分比。如果没有对应的盘会显示0.
    使用率 > 90% 时会提示系统错误体现在openc3_system_error指标上。
负载： 最近一分钟的平均负载,load > 20时会提示系统错误体现在openc3_system_error指标上。
![进程监控](/系统监控/images/进程监控.png)


## 数据库监控

```
监控了数据库的几个重要指标：
Mysql 读/秒： Mysql每秒的读取次数
Mysql 写/秒： Mysql 每秒执行 insert + update + delete 的总和
Mysql 慢查询总量： Mysql出现的慢查询次数
Mysql 连接数：  Mysql的连接数
Mysql 连接池使用率： Mysql连接池的使用率，100 * ( Innodb_buffer_pool_pages_total - Innodb_buffer_pool_pages_free ) / Innodb_buffer_pool_pages_total
```
![数据库监控](/系统监控/images/数据库监控.png)