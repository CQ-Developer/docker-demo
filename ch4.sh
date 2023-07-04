# 绑定挂载
# 使用家目录下的配置文件替换容器中的默认配置文件
# 使用家目录下的日志文件替换容器中的默认日志文件
docker run -d --name diaweb \
--mount type=bind,src=/home/chen/example.conf,dst=/etc/nginx/conf.d/default.conf \
--mount type=bind,src=/home/chen/example.log,dst=/var/log/nginx/custom.host.access.log \
-p 80:80 \
nginx:latest
# 清理
docker rm -f diaweb

# 创建只读挂载
# 防止容器内的任何进程修改卷的内容
docker run -d --name diaweb \
--mount type=bind,src=/home/chen/example.conf,dst=/etc/nginx/conf.d/default.conf,readonly=true \
--mount type=bind,src=/home/chen/example.log,dst=/var/log/nginx/custom.host.access.log \
-p 80:80 \
nginx:latest
# 测试只读
docker exec diaweb sed "s/listen 80/listen 8080/" /etc/nginx/conf.d/default.conf
# 清理
docker rm -f diaweb

# 将基于内存的文件系统挂载到容器文件树
# 创建空的tmpfs设备，并附加到容器文件树的/tmp位置
docker run --rm --mount type=tmpfs,dst=/tmp --entrypoint mount alpine:latest -v
# 默认情况下tmpfs设备没有大小限制并且可以写入
# 通过参数tmpfs-size和tmpfs-mode进行更改
# 改命令可以将/tmp位置安装的tmpfs设备大小限制在16k，并且容器中其他用户无法访问
docker run --rm --mount type=tmpfs,dst=/tmp,tmpfs-size=16k,tmpfs-mode=1770 --entrypoint mount alpine:latest -v

# 创建卷
docker volume create --driver local --label example=location location-example
# 检查卷
docker volume inspect --format "{{json .Mountpoint}}" location-example
