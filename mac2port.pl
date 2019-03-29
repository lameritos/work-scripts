#!/usr/bin/perl
our $community = "public";
our $switch = "169.254.100.100";
use Data::Dumper;

open(SNMP,"snmpwalk -Cc -On -OQ -v2c -c $community $switch .1.3.6.1.2.1.17.4.3.1.1|")
 or die "Can't run snmpwalk";
while (<SNMP>)
{
        chomp;
        s@.1.3.6.1.2.1.17.4.3.1.1@@;
        my ($oid, $mac) = split /=\s*/;

        $_=$mac;
        s@"@0@g; s@\s*$@@; s@ @:@g; s@(.)@\l$1@g; s@^0@@; s@:0@@g;
        $mac_table{$_}=$oid;
}
close(SNMP);

open(SNMP,"snmpwalk -Cc -On -OQ -v2c -c $community $switch .1.3.6.1.2.1.17.4.3.1.2|")
 or die "Can't run snmpwalk";
while (<SNMP>)
{
        chomp;
        s@.1.3.6.1.2.1.17.4.3.1.2@@;
        my ($oid, $port) = split /=/;
        $ports_table{$oid}=$port;
}                        
close(SNMP);

#print Dumper $oid;
for $oid (keys %mac_table) {
#print "$oid -> ".$ports_table{$mac_table{$oid}}."\n";
print  $ports_table{$mac_table{$oid}}. " ". $oid."\n";
}
#print Dumper $oid;
