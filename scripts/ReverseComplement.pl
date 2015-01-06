#!/usr/bin/perl
use warnings;
use strict;

my $use = <<"END1";
$0 in.fq 
reverse complement seq/qual and returns fastq file on stdout

END1
warn $use;
#my $trimlen = shift @ARGV;

#main (file opens, and file iteration)

my $seq;
my $header;
my @qual;
while (<>) {
	chomp;
	if ($. % 4 == 0) {
		my $quals = $_;
		#@quals = map{chr(ord())}(@quals);
		#print join('',@quals)."\n";
		trimAndPrint($seq, $header, $quals);
	}elsif($. % 4 == 1){
		$header = substr($_,1);
	}elsif($. % 4 == 2){
		$seq = $_;
	}
}
###subs
sub trimAndPrint{
	my $seq = shift(@_);
	my $header = shift(@_);
	my $quals = shift(@_);
		
	#trim
	my $rcseq=reverse($seq);
	$rcseq =~ tr/acgntACGNT/tgcnaTGCNA/;
	my $rquals=reverse($quals);
	
	print '@'.$header."\n".$rcseq."\n".'+'.$header."\n".$rquals."\n";
	
}
