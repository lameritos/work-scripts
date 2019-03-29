#. /etc/danss/d7.conf
#. /etc/danss/d7.env

#exec 2>&1
#touch /home/ddf/work/razrab/testfile/checketh1.tmp
touch /tmp/checketh1.tmp
trace=/var/spool/danss/trace/ss7-00.out
#trace=/home/ddf/work/razrab/testfile/trace.test
#tempfile=/home/ddf/work/razrab/testfile/checketh1.tmp
tempfile=/tmp/checketh1.tmp
timeout=30	#задержка трейса
logfile=/var/log/danss/checketh1.log
#echo "ДО:"
#cat $tempfile
catt=`cat $tempfile`
if [ -z $catt ]
then echo "0" > $tempfile
fi;
curtime=`date +%s`
if [ -f $trace ]
then

#if [ $catt = "" ]
#then echo "0" > $tempfile
#fi
  mtime=`stat -c %Y $trace`
  diff=$(($curtime - $mtime)) 
  if [ $diff -gt $timeout ]
  then
#	echo "error"
	if [ "$catt" = "0" ]
	then
	echo "1" > $tempfile;
	fi;
	catt=`cat $tempfile`;
	if [ "$catt" = "1" ]
	then
	echo "need to restart eth1" > $logfile;
	/sbin/ifdown eth1;
	sleep 3;
	/sbin/ifup eth1;
	sleep 3;
	echo "2" >  $tempfile
	fi;

  else
	echo "0" >  $tempfile

  fi;
else

echo "NO trace $trace for checketh1"

fi;
#echo "ПОСЛЕ:"
#cat $tempfile
