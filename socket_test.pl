#!/usr/bin/perl -w
use strict;
use IO::Socket;

#Задаем адрес сервера
my $host = "10.54.12.39";
my $port = 7805;
# Конвертирует имя сервера в бинарную последовательность.
my $paddr = sockaddr_in($port, inet_aton($host));

# Создаем сокет
socket(SOCK, # Указатель сокета
       PF_INET, # коммуникационный домен
       SOCK_STREAM, # тип сокета
       getprotobyname('tcp') # протокол
      )
or die "Couldn't connect to $host:$port : $@\n";

print "connecting with $host\n";
# Соединяемся с сервером
connect(SOCK, $paddr);
# Посылаем запрос на мониторинг состояний изменения сети
my $request = "LSStatesMon\x00";

print "send request to $host\n";

# Отправляем запрос
send(SOCK, $request, 0);


print "reseive data from $host\n";

# Принимаем данные

my @data = <SOCK>;
open (FILE, ">>test.txt");
print FILE @data;
close (FILE);
print "close socket\n";
# Закрываем сокет
close(SOCK);
