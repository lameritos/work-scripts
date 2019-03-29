#! /usr/bin/perl -w
use strict;
use Getopt::Long;
use D7::Net::SS7::Config;

my $LINKSXML="$ENV{'confdir'}/links.xml";
my $NETXML="$ENV{'confdir'}/network.xml";
my $HARDXML="$ENV{'confdir'}/hardware.xml";
my $RUNAME=`hostname`; chomp $RUNAME;
my $OUTPUT='/tmp/falc_info';
my $MAX_DELTAT_TIME=15;
my $SAVE_DELTA_TIME=1;
my $help;

$|=1;
