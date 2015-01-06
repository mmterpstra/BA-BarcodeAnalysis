#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper;
use File::Spec;
use Scalar::Util qw(looks_like_number);

#use
my $use = <<"END";
use $0 <mismatches(=INT)> <barcode.collapsed.fa> [barcode.collapsed.fa]
tries to fix unique
END
warn $use."\n";

my $DEBUG = 1;
my $skipRecordLimit = 1;

my $mismatches =1;
$mismatches = shift @ARGV if(looks_like_number($ARGV[0]));

for my $collapsedFaFile (@ARGV){
	if(not -e $collapsedFaFile){
		warn "[ERROR] warning skipped non existing file $collapsedFaFile";
	}
	next if(not -e $collapsedFaFile);

	#mkdir
	my $basenameCollapsedFaFile = getBasename($collapsedFaFile);
	my $dirnameCollapsedFaFile = getDirname($collapsedFaFile);
	my $dirmake = $dirnameCollapsedFaFile.$basenameCollapsedFaFile;
	mkdir  $dirmake;
	warn "[INFO] made dir $dirmake" if $DEBUG;
	
	#trim BC / linkers??
	
	#my $cmd = "cat $collapsedFaFile | perl ~/workspace/FastqManipulations/TrimTAAGGfa.pl |perl ~/workspace/FastqManipulations/adapterTrimmer.pl -B -m 1 -f fasta -a GACGGCCAGTGAGGATCCCC -i - -o $dirnameCollapsedFaFile/$basenameCollapsedFaFile/bctrim.collapsed.fa";
	#warn "[INFO] trimming barcode with $cmd" if $DEBUG;
	#system($cmd);
	my $bctrimFa=${dirnameCollapsedFaFile}.$basenameCollapsedFaFile."/bctrim.collapsed.fa";
	#perl in perl
	my $cmd = "cat $collapsedFaFile |perl -we '
	my \$printB=0;
	while(<>){
		my \$line= \$_; 
		if(\$line =~ />.*_x(\\d+).*/ && \$1 > $skipRecordLimit){
			\$printB++;
		}
		if(\$printB){
			print \$line;
		}
		if($.%2==1){
			\$printB = 0;
		}
	}'> $bctrimFa";
	warn "[INFO] trimming barcode with $cmd" if $DEBUG;
	system($cmd);
	#compare barcodes:
	my $barcodesFiltered = filterHomologBarcodes($bctrimFa);
	open(my $FilteredHandle,'>',$bctrimFa) or die "[ERROR]Cannot write file '$bctrimFa'";
	print $FilteredHandle BarcodesAsFaString($barcodesFiltered);
	close($FilteredHandle);
}


sub getBasename{
	my $path = shift @_;
	my ($volume,$directories,$file) = File::Spec->splitpath( $path );
	my $base=$file;
	$base =~ s/\.collapsed.fa|mirdeep.fa|.fa//;
	return$base;
}
sub getDirname{
	my $path = shift @_;
	my ($volume,$directories,$file) = File::Spec->splitpath( $path );
	$directories.="/" if ($directories ne "");
	return $directories;
}
sub filterHomologBarcodes{
	my $collapsedFa = shift(@_);
	open(my $collapsedFaHandle,"< $collapsedFa") or die "[ERROR] read error cannot open file: $collapsedFa"; 
	my $homologdata;
	#read through and store data
	my $h;
	while(<$collapsedFaHandle>){
		chomp;
		if($.%2 == 1){
			$h=substr($_,1);
		}elsif($.%2 == 0){
			$$homologdata{'seq'.$.}{'seq'}=$_;
			$$homologdata{'seq'.$.}{'header'}=$h;
			$h =~ s/.*_x(\d+).*/$1/;
			$$homologdata{'seq'.$.}{'count'}=$h;
			$$homologdata{'seq'.$.}{'line'}=$.;
			$$homologdata{'seq'.$.}{'keep'}=1;
			#warn Dumper($$homologdata{'seq'.$_})."\n" if $DEBUG;
		}
	}
	warn "[INFO] read $. lines of input file '$collapsedFa'\n";
	#find/filter homologs
	my $count=1;
	my $last=0;
	my $total=scalar(keys(%$homologdata));
	#iterate collapsed.fa
	for my $s (keys(%$homologdata)){
		#skip trim when <= 1 or when no keep
		warn Dumper($$homologdata{$s}) if(not(looks_like_number($$homologdata{$s}{'count'})));
		$count++ if $$homologdata{$s}{'count'} == 1;
		$$homologdata{$s}{'keep'}=0 if $$homologdata{$s}{'count'} == $skipRecordLimit;
		next if $$homologdata{$s}{'keep'} == 0;
		
		#find seq
		my $seq = $$homologdata{$s}{'seq'};
		#adds additional NNN bofore and after sequence for better matching
		my $cmd = "perl -wpe \'chomp;if(\$.\%2==0){\$_=\"NNN\".\$_.\"NNN\\n\"}else{\$_=\$_.\"\\n\";}' $collapsedFa| perl ~/workspace/FastqManipulations/adapterTrimmer.pl -B -m $mismatches  -f fasta -a $seq -i - -o -";
		
		if($DEBUG && $count - $last > 40){
			warn "## ".localtime(time())." ## [INFO] finding homologs ($count of $total) with '$cmd' \n" ;
			$last=$count;
		}
		$count++;
		open(my $collapsedFaHitsHandle,'-|',"$cmd") or die "[ERROR] read error on command: $cmd";
		#filter
		while(<$collapsedFaHitsHandle>){
			chomp;
			my $h;
			if($.%2 == 1){
				#warn $_ if $DEBUG;
				$h=substr($_,1);
				my %d;
				$d{'header'}=$h;
				$h =~ s/.*_x(\d+).*/$1/;
				$d{'count'}=$h;
				$d{'line'}=$.;
				#warn Dumper(\%d, $$homologdata{$s})."\n" if $DEBUG && $$homologdata{$s}{'count'} > 1;
				push @{$$homologdata{$s}{'hits'}}, \%d;
				#filter
				if($$homologdata{$s}{'header'} ne $d{'header'} && $d{'count'} > $$homologdata{$s}{'count'}){
					$$homologdata{$s}{'keep'}=0;
				}elsif($$homologdata{$s}{'header'} ne $d{'header'} && $d{'count'} == $$homologdata{$s}{'count'}){
					$$homologdata{$s}{'equal'}="eq";
				}
				#die Dumper(\%d, $$homologdata{$s})."\n" if $DEBUG && $$homologdata{$s}{'count'} > 1;
				
				#elsif($$homologdata{$s}{'header'} ne $d{'header'} && $d{'count'} == $$homologdata{$s}{'count'}){
				#	die "unlikely error you figure it out\nsampleinfo:".Dumper($$homologdata{$s})."\nmatchinfo".Dumper(\%d);
				#}
				#die Dumper ($homologdata)." _$.\n";
			}
			#elsif($.%2 == 0){
			#	$$homologdata{$s}{'seq'}=$_;
			#	$$homologdata{$s}{'header'}=$h;
			#	$h =~ s/.*_x(\d*)$/$1/;
			#	$$homologdata{$s}{'count'}=$h;
			#	$$homologdata{$s}{'line'}=$.;
			#}
		}
	}
	return $homologdata;
}
sub BarcodesAsFaString{
	my $barcodes = shift(@_);
	my $string="";
	for my $s (keys($barcodes)){
		if($$barcodes{$s}{'keep'}==1){
			$string=$string.">".$$barcodes{$s}{'header'}."\n".$$barcodes{$s}{'seq'}."\n";
		}
	}
	return $string;
}
sub FilteredBarcodesAsFaString{
	my $barcodes = shift(@_);
	my $string="";
	for my $s (keys($barcodes)){
		if($$barcodes{$s}{'keep'}==1){
			if($$barcodes{$s}{'equal'}){
				$string=$string.">eq".$$barcodes{$s}{'header'}."\n".$$barcodes{$s}{'seq'}."\n";
			}else{
				$string=$string.">".$$barcodes{$s}{'header'}."\n".$$barcodes{$s}{'seq'}."\n";
			}
		}
	}
	return $string;
}