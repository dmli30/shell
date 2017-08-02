#!/bin/bash

URL="http://192.168.7.227:88/ngx_status"
FILE="/tmp/ngx_status.txt"

function active(){
/usr/bin/curl -s $URL |grep Active|awk '{print $3}'
}

function reading(){
/usr/bin/curl -s $URL |grep Reading|awk '{print $2}'
}

function writing(){
/usr/bin/curl -s $URL |grep Writing|awk '{print $4}'
}

function waiting(){
/usr/bin/curl -s $URL |grep Waiting|awk '{print $6}'
}

function requests(){
/usr/bin/curl -s $URL |awk '{if(NR==3) print $3}'
}

function dropped(){
/usr/bin/curl -s $URL > $FILE
accepts=`awk '{if(NR==3) print $1}' $FILE`
handled=`awk '{if(NR==3) print $2}' $FILE`
drop=`expr $accepts - $handled`
echo "$drop"
}

function ping(){
/usr/sbin/pidof nginx|wc -l
}

#根据脚本参数执行对应函数
$1
