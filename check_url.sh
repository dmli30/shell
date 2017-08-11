#!/bin/bash
#auther: dmli
#description: 如果checkURL不能访问，则绑定hosts到联通ip
#             如果checkURL可以访问，则绑定hosts到电信ip 

DX_ip=114.114.114.114
LT_ip=8.8.8.8
checkURL=https://www.baidu.com

function change_to_dx()
{
    sed -i '/www.muzifei.com/d' /etc/hosts
    echo "$DX_ip www.muzifei.com" >> /etc/hosts
}

function change_to_lt()
{
    sed -i '/www.muzifei.com/d' /etc/hosts
    echo "$LT_ip www.muzifei.com" >> /etc/hosts
}

rspCode=$(curl -s -k -I -m 5 -o /dev/null -w %{http_code} $checkURL)    #设置获取状态码的总超时时间为5秒
isDX=$(cat /tmp/isDX.txt)
counter=$(cat /tmp/counter.txt)
if [ $rspCode -eq 200 ] && [ $isDX -eq 1 ]; then
        echo "$(date "+%Y-%m-%d %H:%M:%S") 电信线路正常"
elif [ $rspCode -eq 200 ] && [ $isDX -eq 0 ]; then
    if [ $counter -eq 5 ]; then    #线路恢复时，并不马上恢复，而是等5次计数后再切回，避免网络波动导致频繁切换
        echo "$(date "+%Y-%m-%d %H:%M:%S") 电信线路恢复，切回电信线路"
        change_to_dx
        echo "1" > /tmp/isDX.txt
        echo "1" > /tmp/counter.txt
    else
        echo  "$(date "+%Y-%m-%d %H:%M:%S") 电信线路恢复，第"$counter"次检查"
        let counter++
        echo $counter > /tmp/counter.txt
    fi
elif [ $rspCode -ne 200 ] && [ $isDX -eq 1 ]; then
    echo "$(date "+%Y-%m-%d %H:%M:%S") 电信线路故障，正在切换至联通线路"
    change_to_lt
    echo "0" > /tmp/isDX.txt
else
    echo "$(date "+%Y-%m-%d %H:%M:%S") 已切换至联通线路，请检查电信线路"
fi
