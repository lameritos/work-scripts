if [ -f /usr/bin/curl ]
then



echo -e -n "Select Server type:\n[1]-HP-180-G6\n[2]-HP-160-G6\n[3]-HP-120-G6\n[4]-HP-160-G5\n[5]-HP-360-G7\n[6]-HP-360p-G8\n[7]-HP-180-G5\n : "
    RaidNum=`head -1`;

	if [ "x${RaidNum}" == "x1" ]
	then
	a=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p1924197875/ 2>/dev/null |tail -1`;echo  "************************************";echo -n  "Latest BIOS Release Date: ";echo  "$a" |awk '{ print $6 " " $7 " " $8 }';echo  "************************************";b=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p1924197875/ 2>/dev/null |tail -1 |awk '{ print $9 }'`;c=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p1924197875/$b/ 2>/dev/null |tail -1 |awk '{ print $9 }'`;echo ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p1924197875/$b/$c;echo  "************************************";	

	fi

	if [ "x${RaidNum}" == "x2" ]
	then

#ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p2077289924/
a=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p2077289924/ 2>/dev/null |tail -1`;echo  "************************************";echo -n  "Latest BIOS Release Date: ";echo  "$a" |awk '{ print $6 " " $7 " " $8 }';echo  "************************************";b=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p2077289924/ 2>/dev/null |tail -1 |awk '{ print $9 }'`;c=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p2077289924/$b/ 2>/dev/null |tail -1 |awk '{ print $9 }'`;echo ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p2077289924/$b/$c;echo  "************************************";


	fi
	if [ "x${RaidNum}" == "x3" ]
	then
#p1582149157

a=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p1582149157/ 2>/dev/null |tail -1`;echo  "************************************";echo -n  "Latest BIOS Release Date: ";echo  "$a" |awk '{ print $6 " " $7 " " $8 }';echo  "************************************";b=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p1582149157/ 2>/dev/null |tail -1 |awk '{ print $9 }'`;c=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p1582149157/$b/ 2>/dev/null |tail -1 |awk '{ print $9 }'`;echo ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p1582149157/$b/$c;echo  "************************************";

	fi
	if [ "x${RaidNum}" == "x4" ]
	then
#p303200197

a=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p303200197/ 2>/dev/null |tail -1`;echo  "************************************";echo -n  "Latest BIOS Release Date: ";echo  "$a" |awk '{ print $6 " " $7 " " $8 }';echo  "************************************";b=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p303200197/ 2>/dev/null |tail -1 |awk '{ print $9 }'`;c=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p303200197/$b/ 2>/dev/null |tail -1 |awk '{ print $9 }'`;echo ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p303200197/$b/$c;echo  "************************************";



	fi
	if [ "x${RaidNum}" == "x5" ]
	then
#p532773976
a=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p532773976/ 2>/dev/null |tail -1`;echo  "************************************";echo -n  "Latest BIOS Release Date: ";echo  "$a" |awk '{ print $6 " " $7 " " $8 }';echo  "************************************";b=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p532773976/ 2>/dev/null |tail -1 |awk '{ print $9 }'`;c=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p532773976/$b/ 2>/dev/null |tail -1 |awk '{ print $9 }'`;echo ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p532773976/$b/$c;echo  "************************************";


	fi

	if [ "x${RaidNum}" == "x6" ]
	then
#p1050827925
a=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p1050827925/ 2>/dev/null |tail -1`;echo  "************************************";echo -n  "Latest BIOS Release Date: ";echo  "$a" |awk '{ print $6 " "$7 " " $8 }';echo  "************************************";b=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p1050827925/ 2>/dev/null |tail -1 |awk '{ print $9 }'`;c=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p1050827925/$b/ 2>/dev/null |tail -1 |awk '{ print $9 }'`;echo ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p1050827925/$b/$c;echo  "************************************";


	fi

	if [ "x${RaidNum}" == "x7" ]
	then
			#p1418305621
			a=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p1418305621/ 2>/dev/null |tail -1`;echo  "************************************";echo -n  "Latest BIOS Release Date: ";echo  "$a" |awk '{ print $6 " "$7 " " $8 }';echo  "************************************";b=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p1418305621/ 2>/dev/null |tail -1 |awk '{ print $9 }'`;c=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p1418305621/$b/ 2>/dev/null |tail -1 |awk '{ print $9 }'`;echo ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p1418305621/$b/$c;echo  "************************************";


			        fi



else 
	echo "run apt-get install curl"
fi




#a=`curl ftp://ftp.hp.com/pub/softlib2/software1/pubsw-windows/p532773976/ 2>/dev/null |tail -1`;echo  "************************************";echo -n  "Latest BIOS Release Date: ";echo  "$a" |awk '{ print $6 " " $7 " " $8 }';echo  "************************************";







