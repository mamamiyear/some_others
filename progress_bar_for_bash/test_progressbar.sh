#!/bin/bash

. ./progressbar.sh

for((i=0;i<=105;i++))
do
	color=white
	if [ $i -lt 20 ];then
		color=red
	elif [ $i -lt 40 ];then
		color=yellow
	elif [ $i -lt 60 ];then
		color=blue
	elif [ $i -lt 80 ];then
		color=carmine
	elif [ $i -lt 100 ];then
		color=cyan
	fi
	flush ${i} "processing..." ${color}
done
flush 100 "finished" green
echo

