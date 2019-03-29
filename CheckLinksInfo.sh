filepath=links.xml.test
linenum=`cat $filepath |grep -n "LINK ID" |awk '{print $1}' |tr -d [=:=]`
#xmlbuf=`cat links.xml |grep LINK ID\|`
#xmlbuf=`cat links.xml |grep "ID\|PROTOCOL\|CDR\|TRUNK_TYPE"`
#linenum=`echo "$xmlbuf" |grep -n "LINK ID" |awk '{print $1}' |tr -d [=:=]`
cdrss7count=0
ss7count=0
cdrdsscount=0
dsscount=0

declare -a array1
declare -a array1
declare -a array3
declare -a array4
declare -a array5
#array1=( `echo $s1`)
#array2=( `echo $s2`)
> /tmp/arrline;
for i in $linenum
do
#i=0 
	x=$((i + 6))
	y=$((i + 7))
	z=$((i + 8))
	n=$((i + 3))
	s1=`sed "$i!d" $filepath |perl -e 'while(<>) { m/(\w+).+?(\w+).+?(\w+)/;print "$3\n"; }'` #|awk '{ FS = "["]"}{ print $1 }'`
#	echo "$s1" 
	s2=`sed "$x!d" $filepath |perl -e 'while(<>) { m/(\w+).+?(\w+)/;print "$2\n"; }'`
	s3=`sed "$y!d" $filepath |perl -e 'while(<>) { m/(\w+).+?(\w+)/;print "$2\n"; }'`
	s4=`sed "$z!d" $filepath |perl -e 'while(<>) { m/(\w+).+?(\w+)/;print "$2\n"; }'`
	s5=`sed "$n!d" $filepath |perl -e 'while(<>) { m/(\d+).+?(\w+)/;print "$1\n"; }'`
#	array1=( `echo $s1`)
#	array2=( `echo $s2`)
#	array3=( `echo $s3`)
#	array4=( `echo $s4`)
	echo $s1 "" $s2 "" $s3 "" $s4 "" $s5 >> /tmp/arrline
#	echo "arr1:" ${array1[0]}
#        echo "arr2:" ${array2[0]}
#	i=0
#        while [ $i -lt ${#array1[@]} ]
#                do
#                        if [[ ${array2[i]} = $1 && ${array5[i]} -ge $queuelimit ]];then
                       # echo "msqid= "${array2[i]} "owner=" ${array3[i]} "used-bytes=" ${array5[i]}
                        #echo "ipcrm ${array2[i]}"

                #       i=$[$i+1]
                        #else echo "net zavisshix ocheredei dlja polzovatelja $1"
#                        fi
 #                       i=$[$i+1]

  #              done
	
done
       array1=( `cat /tmp/arrline |awk '{print $1}'`)
       array2=( `cat /tmp/arrline |awk '{print $2}'`)
       array3=( `cat /tmp/arrline |awk '{print $3}'`)
       array4=( `cat /tmp/arrline |awk '{print $4}'`)
       array5=( `cat /tmp/arrline |awk '{print $5}'`)
echo "ARRAY SIZE:"${#array1[@]}
#echo ${array2[6]}

i=0
while [ $i -lt ${#array1[@]} ]
do
#echo ${#array1[@]}
if [[ ${array2[i]} = "CSS7" ]];then
	ss7count=$[$ss7count+1]
#	echo $ss7count
		if [[ ${array3[i]} = "YES" ]];then
	cdrss7count=$[$cdrss7count+1]
#	echo $cdrcount
		fi
elif [[ ${array2[i]} = "DSS1" ]];then
	dsscount=$[$dsscount+1]
	if [[ ${array3[i]} = "YES" ]];then
        cdrdsscount=$[$cdrdsscount+1]
#       echo $cdrcount
                fi

       #echo "arr1:" ${array1[i]}
       # echo "arr2:" ${array2[i]}
fi

i=$[$i+1]
 done
echo SS7: $ss7count
echo CDRCSS7: $cdrss7count
echo DSS: $dsscount
echo CDRDSS: $cdrdsscount
#x=$((cc + 7))
#y=$((cc + 8))








