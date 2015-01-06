#!/usr/bin/perl
use warnings;
use strict;
my $h1;
my $seq;
my $qual;
#my $in=*STDIN;
open my $in,"<-";
while(<$in>){
	#warn ".\n";
	chomp;
	my $line=$_;
	if($.%2==1){
		$h1=substr($line,1);
		#warn "h=$h1\n";
		
	}elsif($.%2==0){

		$seq=$line;
		$seq=uc($seq);
		#warn "seq=$seq\n";

		if($seq =~ s/GAC$//){
			#$seq =~ s/GAC$//;
			#warn "line $." if($. % 100 == 0);
			print "\>$h1\n".substr($seq,0,length($seq))."\n";
		}
	}
}