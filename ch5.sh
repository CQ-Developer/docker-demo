# 查看默认网络
docker network ls

# 创建 user-network 网络
docker network create --driver bridge --label project=dockerinaction --label chapter=5 --attachable --scope local --subnet 10.0.42.0/24 --ip-range 10.0.42.128/25 user-network
# 运行 network-explorer 容器用以从容器内查看网络
docker run -it --name network-explorer --network user-network alpine:3.8 sh
# 使用 ip 命令查看容器的网络情况
ip -f inet -4 -o addr
# 将终端与连接的容器分离
<c-p>
<c-q>
# 创建 user-network2 网络
docker network create --driver bridge --label project=dockerinaction --label chapter=5 --attachable --scope local --subnet 10.0.43.0/24 --ip-range 10.0.43.128/25 user-network2
# 将 network-explorer 容器连接到 user-network2 网络
docker network connect user-network2 network-explorer
# 将终端连接到 network-explorer
docker attach network-explorer
# 使用 ip 命令查看容器的网络情况
ip -f inet -4 -o addr
# 在容器中安装 nmap 工具
apk update && apk add nmap
# 使用 nmap 扫描为桥接网络定义的 10.0.42.0/24 子网
nmap -sn 10.0.42.* -sn 10.0.43.* -oG /dev/stdout | grep Status
# 将终端与连接的容器分离
<c-p>
<c-q>
# 创建新容器 lighthouse 连接到 user-network2 网络
docker run -d --name lighthouse --network user-network2 alpine:3.8 sleep 1d
# 将终端连接到 network-explorer
docker attach network-explorer
# 使用 nmap 扫描为桥接网络定义的 10.0.42.0/24 子网
nmap -sn 10.0.42.* -sn 10.0.43.* -oG /dev/stdout | grep Status
# 可以根据名称发现网络
nslookup lighthouse

# 将容器连接到主机网络
docker run --rm --network host alpine:3.8 ip -o addr
# 将容器连接none网络
docker run --rm --network none alpine:3.8 ip -o addr
# 容器内运行的任何程序都无法访问容器外网络
docker run --rm --network none alpine:3.8 ping -w 2 1.1.1.1

# 从主机随机选取一个端口转发到容器的8080端口
docker run --rm -p 8080 alpine:3.8 echo "forward ephemeral TCP -> container TCP 8080"
# 将主机的UDP协议8080端口转发到容器的8080端口
docker run --rm -p 8080:8080/udp alpine:3.8 echo "host UDP 8080 -> container UDP 8080"
# 将主机的TCP协议的8080端口转发到容器的8080端口
docker run --rm -p 127.0.0.1:8080:8080/tcp -p 127.0.0.1:3000:3000/tcp alpine:3.8 echo "forward multiple TCP ports from localhost"
# 查看转发流量到给定容器的端口列表
docker run -d -p 8080 --name listener --rm alpine:3.8 sleep 300
docker port listener
docker run -d -p 8080 -p 3000 -p 7500 --name multi-listener --rm alpine:3.8 sleep 300
docker port listener 3000

# 设置容器的主机名并查看主机名对应的IP地址
docker run --rm --hostname barker alpine:3.8 nslookup barker
# 将容器的DNS服务器设置为Google的公共DNS服务
docker run --rm --dns 8.8.8.8 alpine:3.8 nslookup docker.com
# 指定搜索域名，会自动解析域名为hub.docker.com
docker run --rm --dns-search docker.com alpine:3.8 nslookup hub
# 查看DNS操作选项是如何修改/etc/resolv.conf文件的
docker run --rm --dns-search docker.com --dns 1.1.1.1 alpine:3.8 cat /etc/resolv.conf
# 使用DNS搜索域名构建环境敏感的软件
docker run --rm --dns-search dev.mycompany alpine:3.8 nslookup myservice
docker run --rm --dns-search test.mycompany alpine:3.8 nslookup myservice
# 直接添加主机和IP的映射关系
docker run --rm --add-host test:10.10.10.255 alpine:3.8 nslookup test
# 查看自定义主机条目是如何修改/etc/hosts文件的
docker run --rm --hostname mycontainer.com --add-host docker.com:127.0.0.1 --add-host test:10.10.10.2 alpine:3.8 cat /etc/hosts
