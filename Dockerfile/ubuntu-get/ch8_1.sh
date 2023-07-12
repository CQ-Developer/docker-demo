## 通过Dockerfile构建ubuntu-git镜像
##
##

# 通过Dockerfile构建镜像
docker build --tag ubuntu-git:auto .

# 查看镜像
docker images --filter reference=ubuntu-git

# 使用镜像执行git命令
docker run --rm ubuntu-git:auto version
