#!/usr/bin/perl
use warnings;
use strict;

my $use = <<"END1";
$0 in.fa Adapters.fa mismatches_int
END1
warn $use;
#my $prefix = '';
#if(scalar(@ARGV) == 3){
#	$prefix = shift @ARGV;
#	$prefix = $prefix."_";
#}
die "invalid input '@ARGV'" if(scalar(@ARGV) < 2 ||scalar(@ARGV) > 3);
warn join("\n",@ARGV);

my $fasta = shift @ARGV;
my $adapters = shift @ARGV;
my $mm = 0;
$mm = shift @ARGV if scalar(@ARGV);
die "invalid input '@ARGV'" if(scalar(@ARGV) > 0);

#main (file opens, and file iteration)
my $tmpDir = $fasta;
$tmpDir =~ s/\.collapse_md\.fa|\.collapsed\.fa|\.fasta|\.fa//g;
$tmpDir.="_${mm}mm";

mkdir $tmpDir;

open(my $adapterH,"<",$adapters) or die "Read error on '$adapters'";

while (<$adapterH>) {
	chomp;
	#my @t = split("\t");
	my $adapterFasta;
	$adapterFasta->{'header'}=substr($_,1);
	$_=<$adapterH>;# or die "format exception";
	chomp;
	$adapterFasta->{'seq'}=$_;
	my $trimOutFa=$tmpDir."/".$adapterFasta->{'header'}."_trimmed.fa";
	my $trimOutFaDone=$trimOutFa.".done";
	#	my ($adapterName,$adapterSeq,$box,$Owner) = @t;
	my $seq = $adapterFasta->{'seq'};
	my $cmd = "perl " . basename($0) . "adapterTrimmer.pl -f fasta -N -i $fasta -a $seq -m $mm -A -o $trimOutFa && touch $trimOutFaDone";
	
	if( not(-e "$trimOutFaDone")){
		warn "running forward adapter trim:'$cmd'\n";
		system($cmd);
		#die;
	}else{
	#warn "skipped because $trimOutFaDone present"
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

sub basename {
	my $p = shift @_;
	$p =~ s/[^\/]{1,}$//g;
	return $p;
}
