## 通过Dockerfile构建ubuntu-git镜像
##
##

## 编写Dockerfile内容如下
## Dockerfile的唯一规则：第一条指定必须式FROM
##
##
# 告诉Docker从最近的ubuntu镜像开始
FROM ubuntu:latest
# 设置镜像的源信息，比如这里设置了维护人员
LABEL maintainer="dia@allingeek.com"
# 告诉构建器执行提供的命令以安装Git
RUN apt-get update && apt-get install -y git
# 将镜像的入口点设置为git
ENTRYPOINT ["git"]

# 通过Dockerfile构建镜像
docker build --tag ubuntu-git:auto .

# 查看镜像
docker images --filter reference=ubuntu-git

# 使用镜像执行git命令
docker run --rm ubuntu-git:auto version
