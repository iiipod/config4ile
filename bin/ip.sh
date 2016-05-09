#!/bin/sh
#wget -q -O - checkip.dyndns.org | sed -e 's/[^[:digit:]\|.]//g'
#curl -s  http://iframe.ip138.com/ic.asp  | grep -o "\[.*]"|sed -e 's/\[//' -e 's/\]//'
wget -q -O - http://www.myip.cn |grep -o "\[.*]"|sed -e 's/\[//' -e 's/\]//' -e 's/[^[:digit:]\|.]//g'
