#!/bin/bash

URL="http://192.168.7.227:89/server-status?auto"

function ReqPerSec(){
/usr/bin/curl -s $URL |grep ReqPerSec|awk '{print $2}'
}

function BytesPerSec(){
/usr/bin/curl -s $URL |grep BytesPerSec|awk '{print $2}'
}

function BusyWorkers(){
/usr/bin/curl -s $URL |grep BusyWorkers|awk '{print $2}'
}

function IdleWorkers(){
/usr/bin/curl -s $URL |grep IdleWorkers|awk '{print $2}'
}

function ping(){
/usr/sbin/pidof httpd|wc -l
}

#根据脚本参数执行对应应函数
$1
