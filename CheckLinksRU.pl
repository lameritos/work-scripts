#!/usr/bin/perl -w

use D7::Net::SS7::Config;
use Data::Dumper;
my $LINKSXML="/etc/danss/links.xml";
my $NETXML="/etc/danss/network.xml";
my $HARDXML="/etc/danss/hardware.xml";
#my $RUNAME="danss-ru-1"; chomp $RUNAME;
my $RUNAME=`hostname`; chomp $RUNAME;
my $lincount=0;


my $e1count=0;
my $stmcount=0;
my $ethcount=0;

my $cfg = new D7::Net::SS7::Config;
$cfg->load($NETXML,$LINKSXML,"/tmp/checklinksru.tmp",$HARDXML);
my $links = $cfg->Links();

my $boardss = $cfg->Devices()->{$RUNAME}->{"boards"};
my $boards = $cfg->Devices()->{"$RUNAME"};
my $boardsss = $cfg->Devices()->{"$RUNAME"}->{"links"};

my @linksarr = @{$boardsss};
my $scalh = scalar(@linksarr);
my %b = %{ $boards };

         foreach my $boardsnum (keys  %$boardss)
                {

                 my $devicestype = $boardss->{$boardsnum}->{"TYPE"};
                 if(lc($devicestype) eq "agent-e1-t")
                   {
                     $e1count=($e1count+1);
                   }
                 elsif(lc($devicestype) eq "agent-stm1")
                   {
                     $stmcount=($stmcount+1);
                   }
                 elsif(lc($devicestype) eq "ethernet")
                   {
                     $ethcount=($ethcount+1);
                   }
           

                }

#for ($index1 = 0; $index1 < $scalh; $index1++)
#      {
#        print Dumper $b{"links"}[$index1]{"PROTOCOL"};
#      foreach my $linksall (keys % $links) 
#        {
#        my $linktypes = $b{"links"}[$index1]{"PROTOCOL"};
#        my $cdr = $b{"links"}[$index1]{"CDR"};
#                  if(lc($linktypes) eq "css7")
#                     {
#                        $ss7count=($ss7count+1);
#                        if(lc($cdr) eq "yes")
#                        {
#                        $cdrss7count=($cdrss7count+1);
#                        }
#                     } 
#                elsif(lc($linktypes) eq "dss1")
#                     {
#                        $dsscount=($dsscount+1);
#                        if(lc($cdr) eq "yes")
#                        {
#                        $cdrdsscount=($cdrdsscount+1);
#                        }
#                     }       
#                elsif(lc($linktypes) eq "r1.5/r2")
#                     {
#                        $r15count=($r15count+1);
#                        if(lc($cdr) eq "yes")
#                        {
#                        $cdrr15count=($cdrr15count+1);
#                        } 
#                     }       
#                elsif(lc($linktypes) eq "sigtran")
#                     {
#                        $sigtrancount=($sigtrancount+1);
#                        if(lc($cdr) eq "yes")
#                        {
#                        $cdrsigtrancount=($cdrsigtrancount+1);
#                        }
#                     }
#                elsif(lc($linktypes) eq "sip")
#                     {
#                        $sipcount=($sipcount+1);
#                        if(lc($cdr) eq "yes")
#                        {
#                        $cdrsipcount=($cdrsipcount+1);
#                        }
#                     }
#                elsif(lc($linktypes) eq "v5")
#                     {
#                        $v5count=($v5count+1);
#                        if(lc($cdr) eq "yes")
#                        {
#                        $cdrv5count=($cdrv5count+1);
#                        }
#                     }       
#                elsif(lc($linktypes) eq "h323")
#                     {
#                        $h323count=($h323count+1);
#                        if(lc($cdr) eq "yes")
#                        {
#                        $cdrh323count=($cdrh323count+1);
#                        }
#                     }  
#                elsif(lc($linktypes) eq "a-bis")
#                     {  
#                        $abiscount=($abiscount+1);
#                        if(lc($cdr) eq "yes")
#                        {
#                        $cdrabiscount=($cdrabiscount+1);
#                        }
#                     }
#                      #                }
#               }         

                 ###PRINT###
#   if($ss7count != 0)
#  {
#    print "CSS7:",$ss7count,"\t";
#    print "CDRCSS7:",$cdrss7count,"\t";
#  }
#   if($dsscount != 0)
#  {
#    print "DSS:",$dsscount,"\t";
#    print "CDRDSS:",$cdrdsscount,"\t";
#  }           
#   if($r15count != 0)
#  {
#    print "R1.5:",$r15count,"\t";
#    print "CDRR1.5:",$cdrr15count,"\t";
#  } 
#   if($sigtrancount != 0)
#  {
#     print "SIGTRAN:",$sigtrancount,"\t";
#     print "CDRSIGTRAN:",$cdrsigtrancount,"\t";
#  } 
#   if($sipcount != 0)  
#  {
#     print "SIP:",$sipcount,"\t";
#     print "CDRSIP:",$cdrsipcount,"\t";
#  }
#  if($v5count != 0)
#    {
#     print "V5:",$v5count,"\t";
#     print "CDRV5:",$cdrv5count,"\t";
#    } 
#  if($h323count != 0)
#    {
#     print "H323:",$sigtrancount,"\t";
#     print "CDRH323:",$cdrsigtrancount,"\t";
#    } 
  if($scalh != 0)  
    {
     print "LINKS-TOTAL:",$scalh,"\t";#=($scalh+1),"\t";
#     print "CDRA-BIS:",$cdrsipcount,"\t";
        }
   if($e1count != 0)
  {
     print "E1:",$e1count,"\t";
  }
   if($stmcount != 0)
  {
     print "STM:",$stmcount,"\t";
  }
   if($ethcount != 0)
  {
     print "Ethernet:",$ethcount,"\t";
  }





 #}
