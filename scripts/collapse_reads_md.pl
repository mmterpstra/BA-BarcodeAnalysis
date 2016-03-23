#!/bin/env perl 

#Based of the similar mirdeep script for collapsing reads
use warnings;
use strict;
if( scalar(@ARGV) < 2){
	die "use: $0 FASTA [FASTA] SEQ> COLLAPSEDFASTA\nFASTA	Contains input reads in the fasta format. can be specified 1 or more times\nSEQ	is an three letter indentifier allowed chars:[a-zA-Z0-9]\nCOLLAPSEDFASTA	Reads collapsed is a fastq like format only containing the unique strings and the count info is contained on the header\n";
}

my $id = pop(@ARGV);
$id =~ m/[a-zA-Z0-9]{3}/ or die "Invalid SEQ id for more help call this prog without args";

my $collapse;

while(<>){
	chomp;
	my $h = $_;
	die "Invalid fast no '>' on header part " if(substr($h,0,1) ne ">");
	$h=substr($h,1);
	$_ = <> or die "The file should be single line fastq thus it shouldent end in an odd line number";
	chomp;
	my $s=$_;#warn $s;
	$collapse -> {"$s"} -> {"l"}	= $. if(not($collapse -> {"$s"} -> {"l"}));
	$collapse -> {"$s"} -> {"h"}	= $h;
        $collapse -> {"$s"} -> {"s"}	= $s;#not really efficient memory wise though...
	$collapse -> {"$s"} -> {"c"}++;
}

for my $seq (sort {$b -> {"c"} <=> $a -> {"c"} } (values(%{$collapse}))){
	print ">" . $id . "_". $seq -> {"l"} ."_x" . $seq->{"c"} . "\n" . $seq->{"s"}."\n";
}

