
# 自动更新

```
# 1. 把本项目clone到路径 /data/open-c3-change
# 2. 添加权限，主机可以git push
# 3. 添加定时任务
5 5 * * * /data/open-c3-book/run > /tmp/open-c3-book.log 2>/tmp/open-c3-book.err
```
