#!/bin/bash
# Use: "script.sh" "full path to dir"
LOG=/tmp/remakedir.log

if [ "x$1" = "x" ]
then
    echo "Use: remakedir.sh <full path to dir>"
    exit 0
fi

cd $1

movedir()
{
	s=`echo $1 | sed 's/----/ /g'`
	echo "movedir "$s"" >> $LOG
	cd "$s"
#	echo "CD" "$s"
	mkdir ../"$s".bakupre
#	echo "mkdir ../"$s".bakupre"
	mv * ../"$s".bakupre  2>>$LOG
	mv .[!.]* ../"$s".bakupre  2>>$LOG
#	echo "mvdir * ../"$s".bakupre"
	rmdir ../"$s"
#	echo "rmdir "$s""
	mv  ../"$s".bakupre ../"$s"
#	echo "mvdir ../"$s".bakupre ../"$s""
	cd ..
}

recsearch()
{
	for f in `ls -d1 */ 2>>$LOG | sed 's/\///g' | sed 's/[ ]/----/g' `
	do
#	echo "Going into directory $f"
	d=`echo $f | sed 's/----/ /g'`
#	echo "Going into directory $d"
	    movedir "$f"
    	    cd "$d"
	    echo "CD DIRNAME "$d"" >> $LOG
	    recsearch
	    cd ..
	done
}

echo "`date` Start remake dir $1" > $LOG
recsearch
echo "`date` done." >> $LOG
