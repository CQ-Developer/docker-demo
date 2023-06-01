<!-- TOC -->
* [Docker CLI](#docker-cli)
  * [1.help](#1help)
  * [2.ps](#2ps)
  * [3.stop](#3stop)
  * [4.start](#4start)
  * [5.restart](#5restart)
  * [6.logs](#6logs)
  * [7.run](#7run)
  * [8.exec](#8exec)
<!-- TOC -->

# Docker CLI
docker-cli是用户操作docker的基本工具，通过docker-cli可以对镜像、容器进行管理。
本文对一些常用命令进行说明和解释。

## 1.help
`help`命令用于显示docker-cli的帮助信息，语法：  
> *docker help [command]*
```shell
# 概览docker的所有命令
$ docker help
# 查看cp命令的具体用法
$ docker help cp
```

## 2.ps
`ps`命令用于查看当前有哪些容器在运行，语法：
> *docker ps [options]*
```shell
# 查看当前运行中的容器
$ docker ps
# 查看所有的容器(包含已停止运行的容器)
$ docker ps -a
```

## 3.stop
`stop`命令用于停止容器，语法：
> *docker stop [options] container [container...]*
```shell
# 停止hello容器
$ docker stop hello
```

## 4.start
`start`命令用于启动容器，语法：
> *docker start [options] container [container...]*
```text
[option]
-a --attach        连接到容器的STDOUT/STDERR
                   也就是让容器中的标准输出和标准错误输出连接到当前的虚拟终端上
                   这样就能在当前虚拟终端上看到容器中程序运行过程中的输出
-i --interactive   连接到容器的STDIN
                   也就是让容器中的标准输入连接到当前的虚拟终端上
                   这样就能在当前虚拟终端上输入指令和容器中运行的程序进行交互
```
```shell
# 启动hello容器
$ docker start hello
# 启动hello容器并查看程序的输出
# docker start -a hello
```

## 5.restart
`restart`命令用于重启容器，语法：
> *docker restart [options] container [container...]*
```shell
# 重启hello容器
$ docker restart hello
```

## 6.logs
`logs`命令用于查看容器内程序的运行日志，语法：
> *docker logs [options] container*
```text
[options]
   --detail       显示额外的相信信息
-f --follow       持续跟踪日志的输出
-t --timestamps   在日志前显示时间戳
```
```shell
# 持续追踪hello容器内程序的运行日志
$ docker logs -f hello
```

## 7.run
`run`命令用于从一个镜像中运行一个新容器，语法：
> *docker run [options] image [command] [arg...]*
```text
[options]
   --name <string>            为启动的容器分配一个名称
-d --detach                   让容器在后台运行
                              也就是说容器内部的标准输入输出不会链接到当前的虚拟终端
-i --interactive              打开STDIN(即使没有连接虚拟终端)
-t --tty                      为容器分配一个虚拟终端
   --link <name|id>[:alias]   添加一个到其他容器的连接并可以为该连接指定一个别名
   --pid <string>             为容器指定一个PID命名空间
```
```shell
# 在后台启动一个nginx
$ docker run --name nginx-service -d nginx:lastest
# 启动一个busybox并绑定标准输入
$ dcker run --name nginx-test -it --link nginx-service:web busybox:1.29 /bin/sh
# 启动一个新的容器并执行ps命令列出当前计算器上的所有进程
$ docker run --pid host busybox:1.29 ps
```

## 8.exec
`exec`在一个运行的容器中执行一个命令，语法：
> *docker exec [options] container command [arg...]*
```text
[options]
-d --detach             分离模式，也即是在后台运行命令
-i --interactive        打开STDIN(即使没有连接虚拟终端)
-t --tty                分配一个虚拟终端
-w --workdir <string>   指定在容器中的工作目录
```
```shell
# 在hello容器中执行ps命令
$ docker exec hello ps
# 在hello容器中打开一个shell并分配一个伪终端
$ docker exec -it hello sh
```