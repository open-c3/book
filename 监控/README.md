# 简介

OPEN-C3 监控系统。

![监控](/监控/images/监控1.jpg)
![监控](/监控/images/监控2.jpg)

## 通用的规则

基础监控
```
---
alert: Node节点内存使用率大于90%
expr: ceil( (node_memory_MemTotal_bytes - (node_memory_MemFree_bytes + node_memory_Buffers_bytes + node_memory_Cached_bytes)) / node_memory_MemTotal_bytes * 100 ) > 90
summary: "内存报警"
description: "Node节点 {{$labels.instance}} 内存使用超过90%\n当前Node节点内存使用率: {{ $value }}%"
value: '{{ $value }}%'
---
alert: Node节点CPU使用率大于90%
expr:  ceil( (1-(sum(increase(node_cpu_seconds_total{mode="idle"}[5m]))by(instance))/(sum(increase(node_cpu_seconds_total[5m]))by(instance))) * 100 ) > 90
summary: "CPU报警"
description: "Node节点 {{$labels.instance}} 内存使用超过90%\n当前Node节点CPU使用率: {{ $value }}%"
value: '{{ $value }}%'
---
alert: 根盘/使用百分比大于85%
expr: ceil( max by(instance) ((node_filesystem_size_bytes {mountpoint ="/"} - node_filesystem_free_bytes{mountpoint ="/"}) / node_filesystem_size_bytes {mountpoint ="/"} * 100 ) ) > 85
summary: "磁盘报警"
description: "磁盘使用超过85%\n当前主机根盘使用百分比: {{ $value }}%"
value: '{{ $value }}%'
---
alert: 数据盘/data使用百分比大于85%
expr: ceil( max by(instance) ((node_filesystem_size_bytes {mountpoint ="/data"} - node_filesystem_free_bytes{mountpoint ="/data"}) / node_filesystem_size_bytes {mountpoint ="/data"} * 100 ) ) > 85
summary: "磁盘报警"
description: "磁盘使用超过85%\n当前主机数据盘使用百分比: {{ $value }}%"
value: '{{ $value }}%'
---
alert: 服务器宕机
expr: 'up == 0'
summary: "服务器宕机"
description: " 服务器宕机"
value: '{{ $value }}'
---
alert: 服务器重启了
expr: 'node_system_uptime < 300'
summary: "服务器重启"
description: "服务器在5分钟内被重启过"
value: '{{ $value }}'

---
alert: 服务器负载过高
sum(count(node_cpu_seconds_total{ mode="system"}) by (cpu,instance)) by(instance) < sum(node_load1) by(instance)
summary: 服务器load过高
description: "服务器负载过高, load 大于 CPU核数，当前load是: {{ $value }}"
value: '{{ $value }}'
```

应用监控
```
---
alert: 进程挂了
expr: node_process_count < 1
expr: node_process_count{cmdline="mydan.tcpserver.65111"} < 1
summary: "进程异常"
description: "应用 {{ $labels.app }} 进程{{ $labels.cmdline }}挂了"
value: '{{ $value }}'

---
alert: 进程被重启了
expr: node_process_etime < 300
expr: node_process_etime{cmdline="mydan.tcpserver.65111"} < 300
summary: "进程重启"
description: "应用 {{ $labels.app }} 进程{{ $labels.cmdline }} 5分钟内被重启过"
value: '{{ $value }}'

---
alert: 进程端口挂了
expr: node_port < 1
expr: node_port{port="65111",protocol="tcp"} < 1
summary: "端口异常"
description: "应用 {{ $labels.app }}端口{{$labels.protocol }} {{$labels.port }}挂了"
value: '{{ $value }}'


```
