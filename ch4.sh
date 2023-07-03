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