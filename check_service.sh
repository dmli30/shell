#!/bin/bash

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
