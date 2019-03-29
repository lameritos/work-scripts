#!/usr/bin/perl -w

use D7::Net::SS7::Config;
use Data::Dumper;
use Encode;


my $LINKSXML="/etc/danss/links.xml";
my $NETXML="/etc/danss/network.xml";
my $HARDXML="/etc/danss/hardware.xml";
my $RUNAME=`hostname`; chomp $RUNAME;
my $cfg = new D7::Net::SS7::Config;
$cfg->load($NETXML,$LINKSXML,undef,$HARDXML);
my $locationkoi = $cfg->Devices()->{"$RUNAME"}->{"LOCATION"};
my $locationutf8;
#$cfg->load($NETXML,$LINKSXML,undef,$HARDXML);

open(FIL,"/etc/danss/links.xml");
chomp;
$string_1 = <FIL>;
@fields = split (/"/,$string_1);
close FIL;
#print "'",$fields[3],"'";
if(("$fields[3]") eq "KOI8-R")
	{
		$locationutf8 = decode( "koi8-r", $locationkoi );
		print $locationutf8;

	}
else
	{
	print $locationkoi;
	}

