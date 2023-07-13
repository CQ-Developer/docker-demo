docker build -t dockerinaction/ch8_whoami .
docker run dockerinaction/ch8_whoami

# 查找具有SUID权限的文件
docker run --rm debian:stretch find / -perm /u=s -type f

# 查找具有SGID权限的文件
docker run --rm debian:stretch find / -perm /g=s -type f
