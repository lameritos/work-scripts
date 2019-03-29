#!/bin/sh

STATE_OK=0
STATE_WARNING=1
STATE_CRITICAL=2
STATE_UNKNOWN=3
STATE_DEPENDENT=4


touch /tmp/nline
touch /tmp/errors.log
lf='/home/ddf/work/razrab/links.xml'
nf='/tmp/nline'
ef='/tmp/errors.log'
msg=crashed
#linenum=`cat links.xml |grep -n "LINK ID" |awk '{print $1}' |tr -d [=:=]`
cc=`cat $ef | wc -l`;					# считаем количество строк с ошибками
x=$((cc + 1))
a=`sed -n $(cat "$nf")',$p' "$lf" | grep "$msg"`	# поиск слова $msg в файле лога $lf начиная со строки $nf
b=`wc -l "$lf" | sed -r 's/(^[0-9]+).*/\1/'`		# посчитал на какой строке был закончен лог на момент прохода
ii=`cat "$nf"`
						
if [ "$b" -lt "$ii" ];					# если  на этом проходе увидили что прошлая позиция лога меньше текущей то скорее всего лог отротейтился
	then echo -n "1" > "$nf";			# то обнуляем счетчик строки и пишем туда еденицу (начасть в след раз с 1 строки)
		echo "$STATE_OK#No errors found, log is rotated";exit $STATE_OK;
	else echo "$b" >  "$nf";			# иначе пишем номер строки где мы закончили в счетчик
		echo -n "$a" > "$ef"				# пишем строки с ошибкой в файл ошибок
	if [ -s $ef ];
		then echo "1" > "$nf" ;			# если в файл ошибок что-то записалось то объеденичим счетчик строк
							# и будем гонять до посинения скрипт пока база не починится и лог не обнулится и писать что есть ошибка

		cat $ef;				# меняем на скрипт починки базы и логротейт
		echo "$STATE_CRITICAL#"$x" ""errors found";exit $STATE_CRITICAL;
		else echo "$STATE_OK#No errors found";exit $STATE_OK;
	fi;
fi;
