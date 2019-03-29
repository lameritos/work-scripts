#Пути к изменяемым файлам
#include/hosts.inc.php
#hostsincphp=/home/ddf/work/razrab/hosts.inc.php
hostsincphp=/usr/share/zabbix/include/hosts.inc.php
#src/libs/zbxdbhigh/db.c
#dbc=/home/ddf/work/razrab/db.c
dbc=src/libs/zbxdbhigh/db.c
#/usr/share/zabbix/include/classes/import/CXmlImport18.php
#CXmlImport18php=/home/ddf/work/razrab/CXmlImport18.php
CXmlImport18php=/usr/share/zabbix/include/classes/import/CXmlImport18.php
#/usr/share/zabbix/locale/ru/LC_MESSAGES/frontend.po
#frontendpo=/home/ddf/work/razrab/frontend.po
frontendpo=/usr/share/zabbix/locale/ru/LC_MESSAGES/frontend.po
#include/schema.inc.php
#schemaincphp=/home/ddf/work/razrab/schema.inc.php
schemaincphp=/usr/share/zabbix/include/schema.inc.php
#src/libs/zbxserver/expression.c
#expressionc=/home/ddf/work/razrab/expression.c
expressionc=src/libs/zbxserver/expression.c

#mysql --user=$dbuser --password=$dbpass -A $dbname
echo "Введите имя пользователя к базе : "
read  dbuser
echo "Введите пароль к базе: "
read  dbpass
echo "Введите имя базы для zabbix: "
read  dbname

echo "Добавить или удалить поле? ответить a или d "
read  addordrop

if [[ $addordrop = "a" ]];then
#Добавляем поля #############################################################
echo "Введите имя поля вместо пробела тире итд ставить _ : "
read field1
echo "Введите отображаемое имя на Английском: "
read title1
echo "Введите отображаемое имя на Русском: "
read title2
echo "Введите тип поля в базе char или text: "
read dbtype
if [[ $dbtype = "char" ]];then
echo "Введите размер поля char в базе, хороший выбор 64, может быть 32 128 255 : "
read dblen
fi;
#номер поля инвентарных данных
a=`grep "[0-9] => array(" $hostsincphp |perl -e 'while(<>) { m/(\d+).+?(\w+)/;print "$1\n"; }'|tail -n1`;aa=$((a + 1));echo $aa;
#номер строки после которой нужно добавить блок для эого файла
b=`grep -n "[0-9] => array(" $hostsincphp |perl -e 'while(<>) { m/(\d+).+?(\w+)/;print "$1\n"; }'|tail -n1`;b=$((b + 3));echo $b;
#номер строки где удалять число количество полей src/libs/zbxdbhigh/db.c
d=`grep -n "define ZBX_MAX_INVENTORY_FIELDS" $dbc |perl -e 'while(<>) { m/(\d+).+?(\w+)/;print "$1\n"; }'` ;ddd=$((d - 1));echo $d;
# то что нужно допасать туда
dd=`echo "#define ZBX_MAX_INVENTORY_FIELDS        \t    $aa  "`
#удаляем сначала строку номер  $d
var2="$(echo "$d" | bc)d"
sed -i "$var2" $dbc
#sed "${d}d" /home/ddf/work/razrab/db.c
#затем пишем туда шаблон $dd
var1="$(echo "$ddd" | bc)a$dd"
sed -i "$var1" $dbc
#также добавляем имя поля в строку ниже =) ищем ее по шаблону =) по другому не придумал
sed -i   s/poc_2_notes.*/'&'", \"$field1\""/ $dbc
#/usr/share/zabbix/include/classes/import/CXmlImport18.php номер строки куда добавлять
e=`grep -n "poc_2_notes" $CXmlImport18php |perl -e 'while(<>) { m/(\d+).+?(\w+)/;print "$1\n"; }'` ;e=$((e - 1));echo $e;
ee=`echo  '\\\t                        '"'$field1' => '', "`
var3="$(echo "$e" | bc)a$ee"
sed -i "$var3" $CXmlImport18php

#блок
# hosts.inc.php 
c=`echo " #$aa \n\t\t  ),\n \
                $aa => array( \n \
                        'nr' => $aa, \n \
                        'db_field' => '$field1', \n \
                        'title' => _('$title1')"`

#добавляем блок в файл hosts.inc.php
var="$(echo "$b" | bc)a$c"
sed -i "$var" $hostsincphp

#echo "$d";
#для файла переводов ищем номер строки где записан тайтл 
per=`grep -n "[0-9] => array(" $hostsincphp |perl -e 'while(<>) { m/(\d+).+?(\w+)/;print "$1\n"; }'|tail -n1`;per=$((per + 3));echo $per;
pertitle2=`echo " #: include/hosts.inc.php:$per\n\
msgid \"$title1\"\n\
msgstr \"$title2\"\n"`
var4="$(echo "16" | bc)a$pertitle2"
sed -i "$var4" $frontendpo   #Временный
echo "Обновляем файл перевода"
/usr/share/zabbix/locale/make_mo.sh ru
dbt=`grep -n "poc_2_notes" $schemaincphp |perl -e 'while(<>) { m/(\d+).+?(\w+)/;print "$1\n"; }'`;dbt=$((dbt + 4));echo $dbt;
if [[ $dbtype = "char" ]];then

dbin=`echo  "	#$field1 \n\t\t	'$field1' => array( \n \
                                'null' => false, \n \
                                'type' => DB::FIELD_TYPE_CHAR, \n \
                                'length' => $dblen, \n \
                                'default' => '', \n \
                        ), "`
else

dbin=`echo  " 	#$field1 \n\t\t	'$field1' => array( \n \
                                'null' => false, \n \
                                'type' => DB::FIELD_TYPE_TEXT, \n \
                                'default' => '', \n \
                        ), "`


fi;


var5="$(echo "$dbt" | bc)a$dbin"
sed -i "$var5" $schemaincphp

#MACROS
macrosnum=`grep -n "define MVAR_INVENTORY_POC_SECONDARY_NOTES" $expressionc |perl -e 'while(<>) { m/(\d+).+?(\w+)/;print "$1\n"; }'` ;macrosnum1=$((macrosnum - 1));echo $macrosnum1;
# то что нужно допасать туда
field1dotbig=`echo $field1 |sed "s/_/./g"| tr '[a-z]' '[A-Z]'`
field1big=`echo $field1 | tr '[a-z]' '[A-Z]'`
macrosstring=`echo "#define MVAR_INVENTORY_$field1big \t     MVAR_INVENTORY \"$field1dotbig}\""`
#удаляем сначала строку номер  $macrosnum1
#var7="$(echo "$macrosnum1" | bc)d"
#sed -i "$var7" $expressionc
#sed "${d}d" /home/ddf/work/razrab/db.c
#затем пишем туда шаблон $dd
var7="$(echo "$macrosnum" | bc)a$macrosstring"
sed -i "$var7" $expressionc
#MVAR_INVENTORY_POC_SECONDARY_NOTES,

snum=`grep -n "MVAR_INVENTORY_POC_SECONDARY_NOTES," $expressionc |perl -e 'while(<>) { m/(\d+).+?(\w+)/;print "$1\n"; }'` ;snum1=$((snum + 1));echo $snum1;
sstring=`echo "MVAR_INVENTORY_$field1big, "`
var8="$(echo "$snum" | bc)a$sstring"
sed -i "$var8" $expressionc






#src/libs/zbxserver/expression.c
sert=`grep -n "poc_2_notes" $expressionc |perl -e 'while(<>) { m/(\d+).+?(\w+)/;print "$1\n"; }'`;echo $ser;

sertin=`echo  " "//"  $field1 \n\t else if (0 == strcmp(macro, MVAR_INVENTORY_$field1big)) \n \
                return DBget_host_inventory_value(trigger, replace_to, N_functionid, \"$field1\"); "`
var6="$(echo "$sert" | bc)a$sertin"
sed -i "$var6" $expressionc





#Создание поля $field1 в базе данных Удаление позже ALTER TABLE `tab_name` DROP `pole_name`
echo "Добавляем поле в базу"
if [[ $dbtype = "char" ]];then
#echo "Введите размер поля char в базе, хороший выбор 64, может быть 32 128 255 : "

echo "ALTER TABLE host_inventory ADD $field1 VARCHAR($dblen) NOT NULL;" | mysql --user=$dbuser --password=$dbpass -A $dbname

else

echo "ALTER TABLE host_inventory ADD $field1 TEXT;" | mysql --user=$dbuser --password=$dbpass -A $dbname
fi;

#И последнее прийдется компилить пакет =)))
echo "Все записано делаем конфигурирование пакета"
./configure --enable-server --with-mysql --sysconfdir=/etc/zabbix/ 1>/dev/null
echo "Инсталим исходники"
make install 1>/dev/null
echo "Видимо все ништяк =)) проверяем поле"
######################################################################################
else
#Удаляем поля ########################################################################

echo "Введите имя поля для удаления (имя из интерфейса, желательно просто скопировать) : "
read title2
echo "А вот хер =))) удаление для поля $title2 не реализовано :)"



#####################################################################################
fi;



