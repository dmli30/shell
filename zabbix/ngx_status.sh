#!/bin/bash

result=$(curl -s http://192.168.7.227:88/ngx_status)
case $1 in
active)
        echo $result|awk '{print $3}'
        ;;
reading)
        echo $result|awk '{print $12}'
        ;;
writing)
        echo $result|awk '{print $14}'
        ;;
waiting)
        echo $result|awk '{print $16}'
        ;;
requests)
        echo $result|awk '{print $10}'
        ;;
dropped)
        accepts=$(echo $result|awk '{print $8}')
        handled=$(echo $result|awk '{print $9}')
        echo $(( $accepts - $handled ))
        ;;
ping)
        /usr/sbin/pidof nginx|wc -l
        ;;
esac
