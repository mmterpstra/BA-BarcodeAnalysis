#!/bin/env perl
use warnings;
use strict;

my $h; my $s;my $q;

while(<>){
	chomp;
	
	if($.%4==1){
	$h = $_;
		#warn substr($h,0,1) ;
		die "invalid fastq, incorrect header:'$h'" if(substr($h,0,1) ne "@");
		$h=substr($h,1);
	}elsif($.%4==2){
		$s = $_;
		die "invalid fq seq does not match [atcgnATCGN]" if(! $s =~ m/^[atcgnATCGN]{1,}$/);
	}elsif($.%4==0){
		$q = $_;
		print ">$h\n$s\n";
	}

}
