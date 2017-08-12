#!/bin/bash
#auther: dmli
#description: 检测服务端口，如果端口不存在，则重启服务或进行其他操作

sshd=(22)
nginx=(80 443)
apache=(8080 8090)

for i in {sshd,nginx,apache};do
    eval port_list="$"{$i[@]}
    for j in $port_list; do
        if [[ `lsof -i:$j` ]];then
            echo `date "+%F %T"` $i service port $j is OK
        else
            echo `date "+%F %T"` $i service port $j is down,please check!
#           Commands when service down,such as restart
            break
        fi
    done
done
