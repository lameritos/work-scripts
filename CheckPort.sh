if=`ifconfig eth1:1 |grep 169.254.100.88`

if [[ -z $if ]]
then
{
ifconfig eth1:1 169.254.100.88
}
else
{

oldportconf=/etc/zabbix/portmac.conf
#oldportconfnew=/etc/zabbix/portmac.conf.new
if [ ! -f $oldportconf  ]
	then
	{
		#ifconfig eth1:1 169.254.100.88
		echo "switchport macadress" > /etc/zabbix/portmac.conf
		/var/zabbix/mac2port.pl |sort -n |grep 00:92 >> /etc/zabbix/portmac.conf
	}
	else
	{	declare -a array1  # original
#		declare -a array2  # svezihiy
#		portmacold=`cat $oldportconf |grep 00:92`
		portmacnew=`/var/zabbix/mac2port.pl | sort -n |grep 00:92`
		#portmacnew=`cat $oldportconfnew |grep 00:92`
#		arrayold1=( `echo "$portmacold" | awk '{print $1}' | tr '\n' ' '`)
#		arrayold2=( `echo "$portmacold" | awk '{print $2}' | tr '\n' ' '`)
		arraynew1=( `echo "$portmacnew" | awk '{print $1}' | tr '\n' ' '`)
		arraynew2=( `echo "$portmacnew" | awk '{print $2}' | tr '\n' ' '`)

        i=0
        while [ $i -lt ${#arraynew1[@]} ]
                do
		#echo "reload DO !!!!!!!!!!!!!!!!!!!!!!!!!"
			grmac=`grep -n "${arraynew2[i]}" $oldportconf |perl -e 'while(<>) { m/(\d+).+?(\w+)/;print "$1\n"; }' |head -n1`;grmacdel=$((grmac - 1));#if [[ $grmac != 0 ]];then grmacdel=$((grmac - 1));else grmacdel=$grmac;fi;
#			a=`grep -n "${arraynew2[i]}" $oldportconf`;
			#echo "grmac: " $grmac
			if [[ -n $grmac ]]
			   then
			   {
			   		   #echo "ENTER IF !!!!!!!!!!!!!!!!!!!!!!!!!!"
					   var2="$(echo "$grmac" | bc)d"
					   sed -i "$var2" $oldportconf
					   #echo "dell: " $grmac
					   #cat /etc/zabbix/portmac.conf
					   updateport="${arraynew1[i]} ${arraynew2[i]}"
					   var1="$(echo "$grmacdel" | bc)a$updateport"
					   sed -i "$var1" $oldportconf
					   #echo "update: " $grmac
					   #cat /etc/zabbix/portmac.conf
					   #echo "EXIT IF !!!!!!!!!!!!!!!!!!!!!!!!!!"
			   }
			   else
			   {
			   	echo "${arraynew1[i]} ""${arraynew2[i]}" >> $oldportconf;
				#echo "add !!!!!!!!!!!!!!!!!!!!!!!!"
			   }
      

			fi
                        i=$[$i+1]

                        #echo "EXIT  DO !!!!!!!!!!!!!!!!!!!!!!!!!"
                done
#fi
	}
fi
}
fi
. /etc/danss/d7.conf;. /etc/danss/d7.env;exec 2>&1;grep "00:92" $confdir/agent_list |awk '{print $$1}'| tr A-Z a-z |sort -n|uniq >/tmp/agentconf;d7agentsearch | tr A-Z a-z |sort -n|uniq >/tmp/agentsearch;>/tmp/agentnotavailable;
for i in `cat /tmp/agentconf`;do grep -q "$i" /tmp/agentsearch;[ $? -ne 0 ] && echo "$i" | tr -d [=:=] >> /tmp/agentnotavailable;done;>/tmp/agentfailed;for i in `cat /tmp/agentnotavailable`;
do grep -iq "$i" $confdir/d7agentlinker.links;[ $? -eq 0 ] && echo "$i"| sed 's/\(..\)/\1:/g' |sed 's/.$//' >> /tmp/agentfailed;done;
if [ -s /tmp/agentfailed ];then for i in `cat /tmp/agentfailed`;do a=`grep "$i" /etc/zabbix/portmac.conf |sed -e 's/^/SWITCHPORT:/g'|sed -e 's/[ \t]/ MAC:/g' ;`;if [[ -ne $a ]];then echo $a;else echo $i;fi;done;else echo "0";fi;










