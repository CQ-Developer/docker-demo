# 假设要创建一个不同版本
docker tag ubuntu-git:latest ubuntu-git:2.7

# 删除git
docker run --name image-dev2 --entrypoint /bin/bash ubuntu-git:latest -c "apt-get remove -y git"

# 提交镜像
docker commit image-dev2 ubuntu-git:removed

# 重新分配latest标签
docker tag ubuntu-git:removed ubuntu-git:latest

# 检查镜像大小
# 注意镜像尺寸变大了
docker images
