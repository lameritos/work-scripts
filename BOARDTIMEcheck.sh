. /etc/danss/d7.conf
. /etc/danss/d7.env

echo "server date" >> /tmp/BOARDTIME.check.log;
date  +%H:%M:%S >> /tmp/BOARDTIME.check.log;
echo "agent date" >> /tmp/BOARDTIME.check.log;
. /etc/danss/d7.conf; a=`d7agentget -m 00:92:FF:FF:FD:18 |grep "#BOARDTIME" |awk 'BEGIN{ FS = "[ ]|[=]"}{ print strtonum($2)}'`;b=$((a / 8 / 1000 ));hour=$((b / 3600 )); min=$(( (b - hour * 3600) / 60 )); sec=$(( (b - ((hour * 3600) + min * 60)  )  ));echo $hour":"$min":"$sec >> /tmp/BOARDTIME.check.log;
echo "trace date" >> /tmp/BOARDTIME.check.log;
tail -c0 -f /var/spool/danss/trace/ss7-00.out |d7dcd |head -n3 |tail -n1  |awk 'BEGIN{ FS = "[ ]|[.]"}{ print $1}' >> /tmp/BOARDTIME.check.log;
echo " " >> /tmp/BOARDTIME.check.log;
echo "smotri: /tmp/BOARDTIME.check.log "
