#!/usr/bin/perl


##perl -p -i -e "s/\r\n/\n/g" 123.csv
use strict;
use warnings;
use Data::Dumper;
use Text::CSV;
use Time::Local;
use Lingua::Translit;
#my $field = $csv->getline( $data );      

my $tr = new Lingua::Translit("GOST 7.79 RUS");

my @rows; #сам csv
#OPC uniq
my @opchasharr;
#my $index1 = 0;
#my @opchasharr = $rows[$index1]{"OPC"};
my @opcarr;
my @opcuniq =();

#DPC uniq
my @dpchasharr;
#my @dpchasharr = $rows[$index1]{"DPC"};
my @dpcarr;
my @dpcuniq =();
# Obrabotka
my $dlitold = "00:00:00";
 
#my $file = $ARGV[0] or die "Need to get CSV file on the command line\n";
#my $file = '/home/ddf/0919-cdr.csv';
my $file = '123.csv';
 
my $csv = Text::CSV->new ({
  binary    => 0,
  auto_diag => 1,
  sep_char  => ';'    # not really needed as this is the default
});
 
my $sum = 0;
open(my $data, '<:encoding(cp1251)', $file) or die "Could not open '$file' $!\n";

my $datestring = gmtime();
print "debug ", "date open $datestring\n";

my $header = $csv->getline( $data );
#print Dumper $header;
while (my $field = $csv->getline( $data )) {
    my %hash;

# Translate

my $res;
my $header1;
for (my $index1 = 0; $index1 < @$header; $index1++)
      	{
if ($tr->can_reverse()) {
$res = $tr->translit(@$header[$index1]);
push @$header1, $res;
			}
	}	
#print  Dumper @$header1;
#

    @hash{@$header1} = @$field;
    push @rows, \%hash;
}
if (not $csv->eof) {
  $csv->error_diag();
}
close $data;
$datestring = gmtime();
print "debug ", "date translate $datestring\n";

#print "date opc $datestring\n";
#print  Dumper @rows;


#OPC uniq
#my $scalrows = scalar(@rows);
for (my $index1 = 0; $index1 < @rows; $index1++)
#for (my $index1 = 0; $index1 < $scalrows; $index1++)
      {
@opchasharr = $rows[$index1]{"OPC"};
push @opcarr, @opchasharr; 
}

my %seenopc = ();
foreach my $itemopc (@opcarr) {
  unless ($seenopc{$itemopc}) {
    # Если мы попали сюда, значит, элемент не встречался ранее
    $seenopc{$itemopc} = 1;
    push(@opcuniq, $itemopc);
  }
}

#DPC uniq


#my $datestring = gmtime();
$datestring = gmtime();
print "debug ", "date dpc $datestring\n";

for (my $index1 = 0; $index1 < @rows; $index1++)
#for (my $index1 = 0; $index1 < $scalrows; $index1++)
      {
@dpchasharr = $rows[$index1]{"DPC"};
push @dpcarr, @dpchasharr;
}

my %seendpc = ();
foreach my $itemdpc (@dpcarr) {
  unless ($seendpc{$itemdpc}) {
    # Если мы попали сюда, значит, элемент не встречался ранее
    $seendpc{$itemdpc} = 1;
    push(@dpcuniq, $itemdpc);
  }
}
#print  @opcuniq,"\n",  "and", "\n", @dpcuniq, "\n" ;
my $nomeraold = 0;
my $nomerbold = 0;
my $rowsdpcold = 0;
my $zvenold = 0;
#my $scalh = scalar(@linksarr);
for (my $opcindex = 0; $opcindex < @opcuniq; $opcindex++)
      {
	for (my $dpcindex = 0; $dpcindex < @dpcuniq; $dpcindex++)
      		{
		#print $opcuniq[$opcindex], " and ", $dpcuniq[$dpcindex], "\n"	;
		for (my $index1 = 0; $index1 < @rows; $index1++)
		{
			my $rowsopc = $rows[$index1]{"OPC"};
			my $rowsdpc = $rows[$index1]{"DPC"};
			my $dlitrow = $rows[$index1]{'Dlit-t`'};
			my $rownomerb = $rows[$index1]{'B Nomer'};
			my $rownomera = $rows[$index1]{'A Nomer'};
			my $zven = $rows[$index1]{'Zven`ya soobshhenij'};
			if ($rownomera eq "")
			{
			$rownomera = "net";
			}
			#print "\n NOMERA ", $rownomera, " == ", $nomeraold, "\n";
			#print  "debug ", $opcuniq[$opcindex], " and ",$rowsopc, " or ", $dpcuniq[$dpcindex], " and ", $rowsdpc, " rowsdpcold ", $rowsdpcold, "\n";
			if ($rowsopc eq $opcuniq[$opcindex] or $rowsdpc eq $dpcuniq[$dpcindex])
			{
#			print  "debug 1 ", $rowsopc , " eq ", $opcuniq[$opcindex] , " and ", $dpcuniq[$dpcindex], " eq ", $rowsdpc, " rowsdpcold ", $rowsdpcold, "\n";
#			print  "debug 1 ",$rowsopc, " -> ", $rowsdpc , $zven, " == ", $zvenold, $rowsdpc,"\n";
			if ($rownomera eq $nomeraold and $rownomerb eq $nomerbold and $rowsopc eq $rowsdpcold)
                        {
#print "debug ", $opcuniq[$opcindex], " and ", $dpcuniq[$dpcindex], "\n"  ;
                        
#my $t2 = $dlitrow ;

# Преобразуем время в число секунд с начала эпохи
my $time1 = timelocal((reverse split(':', $dlitold)), (localtime(time))[3..5]);
my $time2 = timelocal((reverse split(':', $dlitrow)), (localtime(time))[3..5]);

# Теперь с переменными $time1 и $time2 можно производить сравнение
my $timediff = $time1 - $time2;
if ($timediff gt 1) 	{

print "debug PIZDEC", "\n";
print  "debug 2 ", $opcuniq[$opcindex], " and ",$rowsopc, " or ", $dpcuniq[$dpcindex], " and ", $rowsdpc, " rowsdpcold ", $rowsdpcold, "\n";
print  $time1," gt ", $time2, " dlit ", $dlitrow," dlit2 ", $dlitold," noma ", $rownomera," nomaold ", $nomeraold," nomb ", $rownomerb," nombold ", $nomerbold, "\n";
print  $zven, " == ", $zvenold, $rowsdpc,"\n";
#$t1 = $dlitrow;
			}
#$dlitold = $t2;
#else {
#}
#print "yes"
                 	}
$nomeraold = $rownomera;
$nomerbold = $rownomerb;
$dlitold = $dlitrow;
$rowsdpcold = $rowsdpc;
$zvenold = $zven;
		}
#else {
#$nomeraold = $rownomera;
#$nomerbold = $rownomerb;
#$dlitold = $dlitrow;
#$rowsdpcold = $rowsdpc;
#print  "debug ", $opcuniq[$opcindex], " eq ",$rowsopc, " and ", $dpcuniq[$dpcindex], " eq ", $rowsdpc, " rowsdpcold ", $rowsdpcold, "\n";
		}
	
		}
	}


#my $datestring = gmtime();
$datestring = gmtime();
print "debug end $datestring\n";














