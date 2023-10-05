#!/usr/bin/perl
use strict;
use warnings;

my $seq;
my $spname=$ARGV[1];
my $seqname;
 my $seqbed;
my $seqlen;
my $typeP;
my $typeC;
my $sc;
die "Usage: perl $0 <tRNA.out> <species name>...\n" if (@ARGV<2);

open F,"<$ARGV[0]";
while (<F>) {
	chomp;
	if(/(\w+\.\w+)\s+(\(\d+\-\d+\))\s+Length:\s+(\d+)\s+bp/) {
		 $seqname = $1;
		 $seqbed = $2;
		 $seqlen = $3;
	}

	if(/Type:\s+(\w+)\s+\w+\:\s+(\w+)\s+at\s+\d+\-\d+\s+\(\d+\-\d+\)\s+Score:\s+(\d+\.\d+)/) {
		 $typeP = $1;
		 $typeC = $2;
		 $sc = $3;
	}

	if (/Seq:\s+(\w+)/) {
		 $seq = $1;
	}else { next;}

	print ">".$spname."_".$seqname."-".$typeP.$typeC." ".$seqbed." ".$typeP." (".$typeC.") ".$seqlen." bp Sc: ".$sc."\n$seq\n\n";


}
