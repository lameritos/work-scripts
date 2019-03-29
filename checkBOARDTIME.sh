. /etc/danss/d7.conf
. /etc/danss/d7.env

#echo "trace date" >> /tmp/BOARDTIME.check.log;
#tail -c0 -f /var/spool/danss/trace/ss7-00.out |d7dcd |head -n3 |tail -n1  |awk 'BEGIN{ FS = "[ ]|[.]"}{ print $1}' >> /tmp/BOARDTIME.check.log;

#echo "agent date" >> /tmp/BOARDTIME.check.log;
#. /etc/danss/d7.conf; a=`d7agentget -m 00:92:FF:FF:FD:18 |grep "#BOARDTIME" |awk 'BEGIN{ FS = "[ ]|[=]"}{ print strtonum($2)}'`;b=$((a / 8 / 1000 ));hour=$((b / 3600 )); min=$(( (b - hour * 3600) / 60 )); sec=$(( (b - ((hour * 3600) + min * 60)  )  ));echo $hour":"$min":"$sec >> /tmp/BOARDTIME.check.log;

#echo "server date" >> /tmp/BOARDTIME.check.log;
#date  +%H:%M:%S >> /tmp/BOARDTIME.check.log;

#echo " " >> /tmp/BOARDTIME.check.log;
#echo "smotri: /tmp/BOARDTIME.check.log "

#agent get
#for i in `/usr/local/danss/bin/d7agentsearch`;do a=`echo "$i" |awk 'BEGIN{ FS = "[:]"}{ print $5}'`;if [ "$a" = "DF" ];then hostname;/usr/local/danss/bin/d7agentstmget -m $i |grep "MAC_ADDR\|ATMEL_VERS\|ALTERA_VERS";echo " ";else hostname;/usr/local/danss/bin/d7agentget -m $i |grep "BOARDMAC\|ATMEL_VERS\|ALTERA_VERS";echo " ";fi;done;

#zapusk agent get  
#for server in `seq 0 8`; do echo danss-ru-$server; ssh -q -o "BatchMode yes" danss-ru-$server 'bash 2>&1' < ./checkBOARDTIME.sh ; done | grep -v ^$ > agentversions.txt

#a=0 ;for i in `tail -f -c0 /var/spool/danss/trace/ss7-00.out |d7dcd |grep " 44 <-- " |awk '{ print $1}' |tr -d [=:=] |tr -d [=.=] `;do if [ $a -gt $i ];then echo "xernja" $a ">" $i;fi;a=$i;done;




if [ -z $1 ];
then echo "usage $0 tracefile";
else
cat $1 |d7dcd > /tmp/ss7-00.out.tmp.2014
#cat /var/spool/danss/trace/ss7-00.out |d7dcd > /tmp/ss7-00.out.tmp.2014 
trace="/tmp/ss7-00.out.tmp.2014"
#echo "1"
for li in `cat /etc/danss/d7agentlinker.links |awk 'BEGIN{ FS = "[:]"}{ print $2}' |grep -v link |sort -u|sort -n |sed -e 's/^[0-9]$/0&/' |sed '/^$/d'`; 
        do 
#       echo "2";
        a=0 ;
        echo $li;
                for i in `cat $trace |grep " $li  <-- " |awk '{ print $1}' |tr -d [=:=] |tr -d [=.=] `;
                do 
        #       echo $li " " $a ">" $i
                if [ $a -gt $i ];
                then echo "xernja in link" $li " <-- ; " `echo $a |sed 's/^\(..\)\(..\)\(..\)/\1:\2:\3:/'` ">" `echo $i |sed 's/^\(..\)\(..\)\(..\)/\1:\2:\3:/'`;
                #else echo "ok in link" $li " <-- ; " $a ">" $i;
                fi;a=$i;
                done;
        a=0 ;for i in `cat $trace |grep " $li  --> " |awk '{ print $1}' |tr -d [=:=] |tr -d [=.=] `;
                do
                if [ $a -gt $i ];
                then echo "xernja in link " $li " --> ; " `echo $a |sed 's/^\(..\)\(..\)\(..\)/\1:\2:\3:/'` ">" `echo $i |sed 's/^\(..\)\(..\)\(..\)/\1:\2:\3:/'`;
                #else echo "ok in link" $li " <-- ; " $a ">" $i;
                fi;a=$i;
                done;
        done;
rm $trace
fi;
