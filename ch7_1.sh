# 启动容器hw_container
# 在容器中创建文件HelloWorld
docker run --name hw_container ubuntu:latest touch /HelloWorld

# 提交容器的修改
# 创建新的镜像hw_image
docker commit hw_container hw_image

# 删除被修改的容器
docker rm -fv hw_container

# 从新镜像hw_image中拉起容器
# 检查容器的中是否存在文件HelloWorld
docker run --rm hw_image ls -l /HelloWorld
