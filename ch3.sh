# 从备用注册表拉取镜像
docker pull quay.io/dockerinaction/ch3_hello_registry:latest
docker images -a

# 删除镜像
docker rmi quay.io/dockerinaction/ch3_hello_registry:latest

# 将镜像导出未文件
docker pull busybox:latest
docker save -o myfile.tar busybox:latest

# 从文件中加载镜像
docker rmi busybox:latest
docker load -i myfile.tar

# 清理
docker rmi busybox:latest
rm myfile.tar

# 从Dockerfile构建镜像
git clone https://github.com/dockerinaction/ch3_dockerfile.git
docker build -t dia_ch3/dockerfile:lastest ch3_dockerfile

# 清理
docker rmi dia_ch3/dockerfile:lastest
rm -rf ch3_dockerfile

# 查看拉取镜像的过程
docker pull dockerinaction/ch3_myapp
docker pull dockerinaction/ch3_myotherapp

# 清理
docker rmi dockerinaction/ch3_myapp:latest dockerinaction/ch3_myotherapp:latest
