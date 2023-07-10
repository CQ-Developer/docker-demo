# 查看文件系统的添加是如何被记录的
docker run --name mod_ubuntu ubuntu:latest touch /mychange
docker diff mod_ubuntu

# 查看文件系统的删除是如何被记录的
docker run --name mod_busybox_delete busybox:latest rm /etc/passwd
docker diff mod_busybox_delete

# 查看文件系统的更改是如何被记录的
docker run --name mod_busybox_change busybox:latest touch /etc/passwd
docker diff mod_busybox_change
