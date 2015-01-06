#!/usr/bin/perl
use warnings;
use strict;
use List::Util qw(min max);
my $use =<<"END";

use: perl $0 <fastq.fq> <fastq.fq>
tries to check tail validity using tail -n8 

END

if(not(scalar(@ARGV))){
	die $use."\n";
}

my @fqs;

for my $arg (@ARGV){
	if(-e $arg){
		push (@fqs, $arg) if(-e $arg);
	}else{
		die "Non -e file entered '$arg'\n";
	}
}

my $exit=0;
my $warncount=0;

my @goodFqs;
my @badFqs;

for my $fq (@fqs){
	if(-s $fq){
		my $cmd = "tail -n8 $fq";
		$cmd = "tail -n8 $fq" if($fq =~ m/.fq|.fastq/);
		$cmd = "gzip -dc $fq|tail -n8" if($fq =~ m/.fq.gz|.fastq.gz/);
		
		open(my $fqTailHandle,'-|',$cmd) or die "[ERR] Invalid read from command '$cmd'";
		
		if(ReadFastq(\$fqTailHandle) && ReadFastq(\$fqTailHandle)){
			push(@goodFqs, $fq);
		}else{
			push(@badFqs, $fq);
			$exit=1;
		}
	}else{
		warn "[WARN] Zero size error on file:'$fq'\n";
		push(@badFqs, $fq);
		$exit=1;
		$warncount++;
	}
}
warn "[INFO] result:".
	" good=".scalar(@goodFqs).
	", bad=".scalar(@badFqs).
	"\n#good files:\n\"".
	join('" "',@goodFqs).
	"\"\n#bad files:\n\"".
	join('" "',@badFqs)."\"\n";
	

sub ReadFastq {
	my $fqHandle = ${shift(@_)};
	my $seqHeader = <$fqHandle>;
	
	if(! $seqHeader =~  m/@.*\n/ || eof($$fqHandle)){
		chomp $seqHeader;
		warn "Sequence header does not match '\@.*\\n'. Probably invalid ofset.Dump:seqHeader=$seqHeader\n";
		$exit=1;
		$warncount++;
		return '';
	}
	
	$seqHeader = substr($seqHeader,1);
	
	my $seq = <$fqHandle>;
	
	if(! $seq =~  m/[ATCGNatcgn]*\n/|| eof($$fqHandle)){
		chomp $seq;
		warn "Sequence does not match '[ATCGNatcgn]*\\n'. Probably wrong base usage.Dump:seq=$seq\n";
		$exit=1;
		$warncount++;
		return '';
	}
	
	chomp $seq;
	
	my $qualHeader = <$fqHandle>;
	
	if(! $qualHeader =~  m/\+\n|\+$seqHeader\n/ || eof($$fqHandle)){
		chomp $qualHeader;
		warn "Quality header does not match '+\\n|+$seqHeader\\n'. Probably format execption.Dump:qualHeader=$qualHeader\n";
		$exit=1;
		$warncount++;
		return '';
	}
	my $qual = <$fqHandle>;
	chomp $qual;
	my @quals = split('',$qual);
	my @ordQuals;
	map{push(@ordQuals, ord($_))}(@quals);
	
	if(min(@ordQuals) < 33 || max(@ordQuals) > 104 || length($qual) != length($seq) ){
		my $dump=join(',',("minqual=".min(@ordQuals),"maxqual=".max(@ordQuals),"seqlength=".length($seq),("quallength=".length($qual))));
		warn "Quality does not match 'min(\@ordQuals) < 33 || max(\@ordQuals) > 104 || length($qual) != length($seq)'. Probably format exeception or truncated end of file.Dump:qual=$qual,".$dump."\n";
		$exit=1;
		$warncount++;
		return '';
	}
	
	my $fastq;
	$$fastq{'seq'}=$seq;
	$$fastq{'header'}=$seqHeader;
	$$fastq{'qual'}=$qual;
	
	return $fastq;	
}