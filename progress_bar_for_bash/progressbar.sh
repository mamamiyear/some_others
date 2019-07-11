#!/bin/bash

#usage:
#	You should import this script at head of your own script,
#	then you can use the follow function to show your progress.
#	
#	flush <progress percent> [message [message color]]
#		
#		progress percent: your progress has been finished ratio, effective value [0, 100].
#		message:          show current progress step info.
#		message color:    red | green | yellow | blue | carmine | white, default: white.
#	
#	Notice: At the end of your progress, you should use "echo " to change to next line.
#	Notice: Only support bash, not support basic shell or dash.

# config
_pb_config_speed=0.03
# config finished

# main function
_pb_bar=''
_pb_rate=0

flush()
{
	upon=$1
	msg=$2
	color=$3
	# Only
	if [ -z ${msg} ]; then
		msg="..."
	elif [ ${#msg} -gt 30 ]; then
		msg=${msg:0:27}...
	else
		msg=${msg:0:30}
	fi
	
	speed=${_pb_config_speed}
	
	# set color
	cformat="37"  # default color
	if   [ "red"     == "$color" ];then
		cformat="1;31"
	elif [ "green"   == "$color" ];then
		cformat="1;32"
	elif [ "yellow"  == "$color" ];then
		cformat="1;33"
	elif [ "blue"    == "$color" ];then
		cformat="1;34"
	elif [ "carmine" == "$color" ];then
		cformat="1;35"
	elif [ "cyan"    == "$color" ];then
		cformat="1;36"
	elif [ "white"   == "$color" ];then
		cformat="1;37"
	fi
	
	# clean line for different msg length
	printf "%150s\r" ""
	
	# expection handle
	if [ $upon -gt 100 ]; then
		upon=100
	elif [ $upon -lt 0 ]; then
		upon=0
	fi
	if [ $_pb_rate -gt $upon ];then
		_pb_rate=$upon
		_pb_bar=${_pb_bar:0:$upon}
	fi
	
	# flush progress bar
	for((_pb_rage;_pb_rate<=$upon;_pb_rate++));
	do
		if [ -z "$_pb_bar" ];then
			printf "progress:[%-100s][%d%%][\033[${cformat}m%s\033[0m]\r" "" $_pb_rate "$msg"
		else
			printf "progress:[%-100s][%d%%][\033[${cformat}m%s\033[0m]\r" $_pb_bar $_pb_rate "$msg"
		fi
		sleep $speed
		_pb_bar=#$_pb_bar
	done
}
# main function finished

# use example
_pb_example()
{
	for((i=0;i<=100;i++))
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
}
# example finished

# usage
_pb_usage()
{
	echo ' usage:
	You should import this script at head of your own script,
	then you can use the follow function to show your progress.
	
	flush <progress percent> [message [message color]]
		
		progress percent: your progress has been finished ratio, effective value [0, 100].
		message:          show current progress step info.
		message color:    red | green | yellow | blue | carmine | white, default: white.
	
	Notice: At the end of your progress, you should use "echo " to change to next line.
	Notice: Only support bash, not support basic shell or dash.
'
}
# usage finished

# main
_pd_shell_name=${0##*/}
if [ "$_pd_shell_name" = "progressbar.sh" ]; then
	if [ "$1" = "--help" -o "$1" = "-h" ]; then
		_pb_usage
		exit 0
	elif [ "$1" = "--show" -o "$1" = "-s" ]; then
		_pb_example
		exit 0
	fi
fi
# main finished
