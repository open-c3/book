# 说明

在开发内建插件kubectl时可能需要一个k8s集群的环境，可以通过下面方式部署一个单机版。

# 脚本
```
#!/bin/sh
 
# ----------------------------------------
# k8s单机版一键安装脚本
# author wangll
# date 2019-08-11
# 执行本脚本时如果报错：找不到解释器，执行：sed -i 's/\r$//' install-k8s.sh
# 参考：https://www.missshi.cn/api/view/blog/5b0e8af013d85b22bc000001
# ----------------------------------------
 
# 1 关闭防火墙
 
systemctl disable firewalld
systemctl stop firewalld
 
# 2 禁用SELINUX
setenforce 0
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
 
# 3 升级yum
yum -y update
 
# 4 安装etcd和Kubernetes（自动附带安装Docker）
yum install -y etcd kubernetes
 
# 5 修改/etc/sysconfig/docker文件。修改OPTIONS的内容为：
sed -i "s/--selinux-enabled --log-driver=journald --signature-verification=false/--selinux-enabled=false --insecure-registry gcr.io/g" /etc/sysconfig/docker
 
# 6 修改/etc/kubernetes/apiserver文件。修改KUBE_ADMISSION_CONTROL的内容为：
sed -i "s/--admission-control=NamespaceLifecycle,NamespaceExists,LimitRanger,SecurityContextDeny,ServiceAccount,ResourceQuota/--admission-control=NamespaceLifecycle,NamespaceExists,LimitRanger,SecurityContextDeny,ResourceQuota/g" /etc/kubernetes/apiserver
 
# 7 依次启动下列服务：
systemctl start etcd
systemctl start docker
systemctl start kube-apiserver
systemctl start kube-controller-manager
systemctl start kube-scheduler
systemctl start kubelet
systemctl start kube-proxy
 
# 8 解决创建的pod一直是ContainerCreating状态，ready数一直为0的问题。参考：https://blog.csdn.net/qq_38695182/article/details/82971114
yum install -y *rhsm*
yum install -y wget
wget http://mirror.centos.org/centos/7/os/x86_64/Packages/python-rhsm-certificates-1.19.10-1.el7_4.x86_64.rpm
rpm2cpio python-rhsm-certificates-1.19.10-1.el7_4.x86_64.rpm | cpio -iv --to-stdout ./etc/rhsm/ca/redhat-uep.pem | tee /etc/rhsm/ca/redhat-uep.pem
rm -rf python-rhsm-certificates-1.19.10-1.el7_4.x86_64.rpm
docker pull registry.access.redhat.com/rhel7/pod-infrastructure:latest
 
 
# 9 设置允许转发，否则会造成“服务都已经启动好了，但是外界无法访问”。参考https://blog.csdn.net/weixin_38698322/article/details/91155594
iptables -P FORWARD ACCEPT
```