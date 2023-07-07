# 运行ubuntu容器并进入容器的虚拟终端
docker run -it --name image-dev ubuntu:latest /bin/bash

# 在容器中安装git
apt update
apt install -y git

# 确认git安装
git version

# 退出容器的虚拟终端
exit

# 查看安装git时对文件系统做出的修改
# A 开头表示新增
# C 开头表示修改
# D 开头表示删除
docker diff image-dev

# 从容器image-dev的更改中创建新的镜像
docker commit -a "@dockerinaction" -m "added git" image-dev ubuntu-git

# 查看镜像列表
docker images

# 从新建的镜像ubuntu-git中拉起容器
# 并测试git是否能正常运行
docker run --rm ubuntu-git git version

# 设置容器的入口点为git
# 也就是说容器启动时会直接执行git命令
docker run --name cmd-git --entrypoint git ubuntu-git

# 基于cmd-git容器创建新的镜像ubuntu-git
docker commit -a "@dockerinaction" -m "set cmd git" cmd-git ubuntu-git

# 清理容器
docker rm -fv cmd-git

# 测试
# 提交version命令给git命令
docker run --name cmd-git ubuntu-git version
