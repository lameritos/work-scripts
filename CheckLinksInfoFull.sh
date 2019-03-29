filepath=links.xml.test
#linenum=`cat $filepath |grep -n "LINK ID" |awk '{print $1}' |tr -d [=:=]`
#xmlbuf=`cat links.xml |grep LINK ID\|`
xmlbuf=`cat $filepath |grep "ID\|PROTOCOL\|CDR\|TRUNK_TYPE\|DEVICE\|BOARD"`
linenum=`echo "$xmlbuf" |grep -n "ID" |awk '{print $1}' |tr -d [=:=]`
cdrss7count=0
ss7count=0
cdrdsscount=0
dsscount=0
cascount=0
cdrcascount=0
sigtrancount=0
cdrsigtrancount=0
sipcount=0
cdrsipcount=0

e1count=0
stmcount=0
ethcount=0

echo "1"
#echo "$linenum"
declare -a array1
declare -a array1
declare -a array3
declare -a array4
declare -a array5
declare -a array6
#array1=( `echo $s1`)
#array2=( `echo $s2`)
> /tmp/arrline;
echo "2"
for i in $linenum
do
#i=0 
	x=$((i + 3))
	y=$((i + 4))
	z=$((i + 5))
	n=$((i + 1))
        k=$((i + 2))
#echo "2"
	s1=`echo "$xmlbuf"| sed "$i!d" |perl -e 'while(<>) { m/(\w+).+?(\w+).+?(\w+)/;print "$3\n"; }'` #|awk '{ FS = "["]"}{ print $1 }'`
#	echo "$xmlbuf" 
	s2=`echo "$xmlbuf"| sed "$x!d" |perl -e 'while(<>) { m/(\w+).+?(\w+)/;print "$2\n"; }'` # Протокол
	s3=`echo "$xmlbuf"| sed "$y!d" |perl -e 'while(<>) { m/(\w+).+?(\w+)/;print "$2\n"; }'` # CDR
	s4=`echo "$xmlbuf"| sed "$z!d" |perl -e 'while(<>) { m/(\w+).+?(\w+)/;print "$2\n"; }'` # Тип
	s5=`echo "$xmlbuf"| sed "$n!d" |perl -e 'while(<>) { m/(\d+).+?(\w+)/;print "$1\n"; }'` # Номер ру
        s6=`echo "$xmlbuf"| sed "$k!d" |perl -e 'while(<>) { m/(\d+).+?(\w+)/;print "$1\n"; }'` # Номер Агента
	echo $s1 "" $s2 "" $s3 "" $s4 "" $s5 "" $s6 >> /tmp/arrline
#echo "3"	
done
echo "3"
#       array1=( `cat /tmp/arrline |awk '{print $1}'`)
       array2=( `cat /tmp/arrline |awk '{print $2}'`)
       array3=( `cat /tmp/arrline |awk '{print $3}'`)
       array4=( `cat /tmp/arrline |awk '{print $4}'`)
       array5=( `cat /tmp/arrline |awk '{print $5}'`)
       array6=( `cat /tmp/arrline |awk '{print $6}'`)
echo "ARRAY SIZE:"${#array2[@]}
echo "4"
i=0
while [ $i -lt ${#array2[@]} ]
do
if [[ ${array5[i]} = "2" ]];then
	if [[ ${array2[i]} = "CSS7" ]];then
	ss7count=$[$ss7count+1]
		if [[ ${array3[i]} = "YES" ]];then
	cdrss7count=$[$cdrss7count+1]
		fi
	elif [[ ${array2[i]} = "DSS1" ]];then
	dsscount=$[$dsscount+1]
		if [[ ${array3[i]} = "YES" ]];then
        cdrdsscount=$[$cdrdsscount+1]
                fi
	elif [[ ${array2[i]} = "R1" ]];then
        cascount=$[$cascount+1]
                if [[ ${array3[i]} = "YES" ]];then
        cdrcascount=$[$cdrcascount+1]
                fi
	elif [[ ${array2[i]} = "SIGTRAN" ]];then
        sigtrancount=$[$sigtrancount+1]
                if [[ ${array3[i]} = "YES" ]];then
        cdrsigtrancount=$[$cdrsigtrancount+1]
                fi
	elif [[ ${array2[i]} = "SIP" ]];then
        sipcount=$[$sipcount+1]
                if [[ ${array3[i]} = "YES" ]];then
        cdrsipcount=$[$cdrsipcount+1]
                fi
	fi
	if [[ ${array4[i]} = "E1" ]];then
                if [[ ${array6[i]} -ge $e1count ]];then
                bu=${array6[i]}
                e1count=$((bu + 1))
                fi
        elif [[ ${array4[i]} = "STM1" ]];then
                if [[ ${array6[i]} -ge $stmcount ]];then
                bu=${array6[i]}
                stmcount=$((bu + 1))
                fi
         elif [[ ${array4[i]} = "Ethernet" ]];then
                if [[ ${array6[i]} -ge $ethcount ]];then
               # ethcount=${array6[i]}
                bu=${array6[i]}
                ethcount=$((bu + 1))
                fi
        fi	
fi
i=$[$i+1]
 done
echo SS7: $ss7count
echo CDRCSS7: $cdrss7count
echo DSS: $dsscount
echo CDRDSS: $cdrdsscount
echo CAS: $cascount
echo CDRCAS: $cdrcascount
echo SIGTRAN: $sigtrancount
echo CDRSIGTRAN: $cdrsigtrancount
echo SIP: $sipcount
echo CDRSIP: $cdrsipcount

echo E1: $e1count
echo STM: $stmcount
echo ETH: $ethcount







