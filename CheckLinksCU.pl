#!/usr/bin/perl -w

use D7::Net::SS7::Config;
#use Data::Dumper;
my $LINKSXML="/etc/danss/links.xml";
my $NETXML="/etc/danss/network.xml";
my $HARDXML="/etc/danss/hardware.xml";
#my $RUNAME="danss-ru-1"; chomp $RUNAME;
my $cdrss7count=0;
my $ss7count=0;
my $cdrdsscount=0;
my $dsscount=0;
my $cascount=0;
my $cdrcascount=0;
my $sigtrancount=0;
my $cdrsigtrancount=0;
my $sipcount=0;
my $cdrsipcount=0;
my $cdrtotal=0;
my $lintotal=0;
my $h323count=0;
my $cdrh323count=0;
my $v5count=0;
my $cdrv5count=0;
my $abiscount=0;
my $cdrabiscount=0;

my $cfg = new D7::Net::SS7::Config;
$cfg->load($NETXML,$LINKSXML,"/tmp/checklinkscu.tmp",$HARDXML);
#if(exists $cfg->Links())
#  {
   my $links = $cfg->Links();
    foreach my $linksall (keys %$links) 
        {

        my $linktypes = $cfg->Links()->{$linksall}->{"PROTOCOL"};
        my $cdr = $cfg->Links()->{$linksall}->{"CDR"};
#        if(lc($cdr) eq "YES")
#              {
                
                  if(lc($linktypes) eq "css7")
                     {
                        $ss7count=($ss7count+1);
			$lintotal=($lintotal+1);
#                        print Dumper "=================";
                        if(lc($cdr) eq "yes")
                        {
                        $cdrss7count=($cdrss7count+1);
			$cdrtotal=($cdrtotal+1);
                        }
                     } 
                elsif(lc($linktypes) eq "dss1")
                     {
                        $dsscount=($dsscount+1);
			$lintotal=($lintotal+1);
                        if(lc($cdr) eq "yes")
                        {
                        $cdrdsscount=($cdrdsscount+1);
			$cdrtotal=($cdrtotal+1);
                        }
                     }       
                elsif(lc($linktypes) eq "r1.5/r2")
                     {
                        $cascount=($cascount+1);
			$lintotal=($lintotal+1);
                        if(lc($cdr) eq "yes")
                        {
                        $cdrcascount=($cdrcascount+1);
			$cdrtotal=($cdrtotal+1);
                        } 
                     }       
                elsif(lc($linktypes) eq "sigtran")
                     {
                        $sigtrancount=($sigtrancount+1);
			$lintotal=($lintotal+1);
                        if(lc($cdr) eq "yes")
                        {
                        $cdrsigtrancount=($cdrsigtrancount+1);
			$cdrtotal=($cdrtotal+1);
                        }
                     }
                elsif(lc($linktypes) eq "sip")
                     {
                        $sipcount=($sipcount+1);
			$lintotal=($lintotal+1);
                        if(lc($cdr) eq "yes")
                        {
                        $cdrsipcount=($cdrsipcount+1);
			$cdrtotal=($cdrtotal+1);
                        }
                      }
		elsif(lc($linktypes) eq "v5")
                     {
                       $v5count=($v5count+1);
		       $lintotal=($lintotal+1);
                        if(lc($cdr) eq "yes")
                        {
                        $cdrv5count=($cdrv5count+1);
			$cdrtotal=($cdrtotal+1);
                        }
                     }       
                elsif(lc($linktypes) eq "h323")
                     {
                        $h323count=($h323count+1);
			$lintotal=($lintotal+1);
                        if(lc($cdr) eq "yes")
                        {
                        $cdrh323count=($cdrh323count+1);
			$cdrtotal=($cdrtotal+1);
                        }
                     }  
                elsif(lc($linktypes) eq "a-bis")
                     {  
                        $abiscount=($abiscount+1);
			$lintotal=($lintotal+1);
                        if(lc($cdr) eq "yes")
                        {
                        $cdrabiscount=($cdrabiscount+1);
			$cdrtotal=($cdrtotal+1);
                        }
                     }
                }
#               }         
#
#                print Dumper $linksall;
#                print Dumper $linktypes;
#                print Dumper $cdr;
#                print "CSS7:",$ss7count,"n";
#                print "CDRCSS7:",$cdrss7count,"n";
#                print "DSS:",$dsscount,"n";
#                print "CDRDSS:",$cdrdsscount,"n";
#                print "CAS:" $cascount
#                print "CDRCAS:" $cdrcascount
#                print "SIGTRAN:" $sigtrancount
#                print "CDRSIGTRAN:" $cdrsigtrancount
#                print "SIP:" $sipcount
#                print "CDRSIP:" $cdrsipcount


#                 }
                
   if($lintotal != 0)
  {
    print "LINKS-TOTAL:",$lintotal,"\t";#=($lintotal+1),"\t";
  }
  if($cdrtotal != 0)
  {
     print "CDR-TOTAL:",$cdrtotal,"\t";#=($cdrtotal+1),"\t";
  }
   if($ss7count != 0)
  {
    print "CSS7:",$ss7count,"\t";
#    print "CDRCSS7:",$cdrss7count,"\t";
  }
   if($dsscount != 0)
  {
    print "DSS:",$dsscount,"\t";
#    print "CDRDSS:",$cdrdsscount,"\t";
  }           
   if($cascount != 0)
  {
    print "CAS:",$cascount,"\t";
#    print "CDRCAS:",$cdrcascount,"\t";
  } 
   if($sigtrancount != 0)
  {
     print "SIGTRAN:",$sigtrancount,"\t";
#     print "CDRSIGTRAN:",$cdrsigtrancount,"\t";
  } 
   if($sipcount != 0)  
  {
     print "SIP:",$sipcount,"\t";
#     print "CDRSIP:",$cdrsipcount,"\t";
  }
   if($v5count != 0)
  {
         print "V5:",$v5count,"\t";
#	 print "CDRV5:",$cdrv5count,"\t";
  }
   if($h323count != 0)
  {
         print "H323:",$h323count,"\t";
#	 print "CDRH323:",$cdrh323count,"\t";
  }
   if($abiscount != 0)
  {
         print "A-BIS:",$abiscount,"\t";
#         print "CDRA-BIS:",$cdrabiscount,"\t";
  }
#   if($sigtrancount != 0)
#  {
#         print "SIGTRAN:",$sigtrancount,"\t";
#         print "CDRSIGTRAN:",$cdrsigtrancount,"\t";
#  }
#   if($sipcount != 0)
#  {
#         print "SIP:",$sipcount,"\t";
#         print "CDRSIP:",$cdrsipcount,"\t";
#  }
#}
