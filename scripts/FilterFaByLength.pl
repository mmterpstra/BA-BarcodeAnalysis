#!/usr/bin/perl
use warnings;
use strict;



my $use = <<"END1";
$0 minlen maxlen file
filters by length by not returning sequences and returns fastq file on stdout.
Note:ints are inclusive.

END1
#warn $use;
my $filterlenlower = shift @ARGV;
my $filterlenupper = shift @ARGV;

#use Getopt::Std;
#my %opts;
#$opts{'u'}=33;
#$opts{'l'}=33;
#getopts('i:u:l:', \%opts);

#warn "$0: run options -i $opts{'i'} -u $opts{'u'} -l $opts{'l'}";

#main (file opens, and file iteration)

my $seq;
my $header;
while (<>) {
	chomp;
	if ($. % 2 == 0) {
		$seq = $_;
		selectAndPrint($seq, $header);
	}elsif($. % 2 == 1){
		$header = substr($_,1);
	}
}
###subs
sub selectAndPrint{
	my $seq = shift(@_);
	my $header = shift(@_);
	my $quals = shift(@_);
		
	#filter
	print '>'.$header."\n".$seq."\n" if(length($seq) <= $filterlenupper && length($seq) >= $filterlenlower);
	
}
