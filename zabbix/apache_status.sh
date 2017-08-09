#!/bin/bash

result=$(curl -s http://192.168.7.227:89/server-status?auto)
case $1 in
ReqPerSec)
        echo $result|awk '{print $12}'
        ;;
BytesPerSec)
        echo $result|awk '{print $14}'
        ;;
BusyWorkers)
        echo $result|awk '{print $18}'
        ;;
IdleWorkers)
        echo $result|awk '{print $20}'
        ;;
ping)
        /usr/sbin/pidof httpd|wc -l
        ;;
esac
