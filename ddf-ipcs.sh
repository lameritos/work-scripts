#!/bin/bash

declare -a array3
declare -a array2
declare -a array5
ipc=`ipcs -q | perl -e 'while(<STDIN>) { print if(/0x(\w+)\s+(\d+)\s+(\w+)\s+(\d+)\s+(\d+)\s+(\d+)/); }'`
array2=( `echo "$ipc" | awk '{print $2}' | tr '\n' ' '`)
array3=( `echo "$ipc" | awk '{print $3}' | tr '\n' ' '`)
array5=( `echo "$ipc" | awk '{print $5}' | tr '\n' ' '`)
maxqueue=`if [ -f /proc/sys/kernel/msgmax ];then cat /proc/sys/kernel/msgmax;else echo "file /proc/sys/kernel/msgmax not exist";exit 1;fi;`
queuelimit=$(($maxqueue / 100 * 80))



if [ -z "$1" ];then
	echo  "usage: script.sh <message queues owner> ";
elif [ -z  "${array2[0]}" ];then
	echo "voobshe net ochredei"
#elif [[ ${array3[i]} != $1 && ${array5[i]} -le $queuelimit ]];then
#	echo "net zavisshix ocheredei dlja polzovatelja $1"
else
	i=0
	while [ $i -lt ${#array5[@]} ]
		do
			if [[ ${array3[i]} = $1 && ${array5[i]} -ge $queuelimit ]];then
			echo "msqid= "${array2[i]} "owner=" ${array3[i]} "used-bytes=" ${array5[i]}
			echo "ipcrm ${array2[i]}"

		#	i=$[$i+1]
			else echo "net zavisshix ocheredei dlja polzovatelja $1"
			fi
			i=$[$i+1]
			
		done
fi

