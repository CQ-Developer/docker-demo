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
