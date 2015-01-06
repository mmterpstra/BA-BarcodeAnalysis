#!/usr/bin/perl
use warnings;
use strict;
my $h1;
my $seq;
my $qual;
while(<STDIN>){
	chomp;
	my $line=$_;
	if($.%2==1){
		$h1=substr($line,1);
	}elsif($.%2==0){
		$seq=$line;
		$seq=uc($seq);
		if($seq =~ s/^TAAGG|^TAAGGG|^AAGG|^TAAAGG|^GTAAGG|^TACCAGTAAGG|^TACAAGTAAGG|^TACAATAAGG|^TACAAGAAGG//){
			print "\>$h1\n".$seq."\n";
		}
	}
}