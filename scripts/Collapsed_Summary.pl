#!/usr/bin/perl
use strict;
use warnings;
#use 5.10.1;or more, although not tested;
my $Use =<<"END";

Use: $0 FILE(s)

Calculates total mapped seqs ( ignoring the double reported ID's) and unique 
mapped seqs (way faster than any spreadsheet programme). usige tip: use on 
quantifier.pl .arf/.bwt miRDeepcollapsed.fa output or on mapper.pl output and
compare it with the mentioned output.

input
FILE(s): any number of miRDeep generated .bwt/arf file with read naming as:
"seq_1_x100"
	where the 'seq' part could be any combination of alfanumeric chars
	or a mirdeep collapsed fasta file

END
#edit history
#28-11-2011 Now gets the summary for multiple samples when ran with config mapper this results in output for every sample in the arf file

my @files;
if(scalar(@ARGV) > 0){
	foreach my $file(@ARGV){
		if(-e $file){
		push @files, $file;
		}else{
		print "skipped non existing file $file";
		}
	}
}else{
	print "$Use";
	exit(1);
}

print "File\tSample\tReads\tCollapsed reads\n";

if(scalar(@files) >= 0){
	foreach my $file(@files){
		if( -z $file){
			print "$file\tXXX\tNA\tNA\n";
		}else{
			my %seqIDsAndAmounts = ();
			my %sampleTags = ();
			my $total = 0;
			my $unique = 0;	
			
			open(my $in,'<',"$file") or die "$0 error:$!";
			my $line;
			my $fastatest = 0;
			#first line
				$line = <$in>;
				#Test4fasta
				if(substr($line,0,1) eq '>'){
					$fastatest = 1;
					$line = substr($line,1);
				}
				my @ebwtOrArf_parsed = split /\t/,$line;
				my @identifier_parsed = split /[_x]|[_]/,$ebwtOrArf_parsed[0];
				$seqIDsAndAmounts{$identifier_parsed[0]."_".$identifier_parsed[1]} = $identifier_parsed[3];#I really have no idea why $identifier_parsed[3] has the read numbers and not $identifier_parsed[2], solution any1?
				#list of keys = ID e.g. "seq_119" values =  Amount e.g. "1" this removes double IDs of reads mapping to multiple locations 	
			#rest of lines
			while (not(eof($in))){
				$line = <$in>;
				next if (($fastatest == 1)&&(substr($line,0,1) ne '>'));
				if (($fastatest == 1)&&(substr($line,0,1) eq '>')){
					$line = substr($line,1);	
				}	
				@ebwtOrArf_parsed = split /\t/,$line;
				@identifier_parsed = split /[_x]|[_]/,$ebwtOrArf_parsed[0];
				$seqIDsAndAmounts{$identifier_parsed[0]."_".$identifier_parsed[1]} = $identifier_parsed[3] if($identifier_parsed[3] ne "\n");
				#I really have no idea why $identifier_parsed[3] has the read numbers and not $identifier_parsed[2], solution any1?
				#list of keys = ID e.g. "seq_119" values =  Amount e.g. "1" this removes double IDs of reads mapping to multiple locations  
				}
			close $in;
			#print "\n$file\n";
			
			foreach my $key(keys(%seqIDsAndAmounts)){#get stats from IDs($key)
				my $sampletag;
				my $readID;
				($sampletag,$readID) = split(/_/,$key);
				$sampleTags{$sampletag."_UNIQUE"}++;#28-11-2011 edited
				$sampleTags{$sampletag."_TOTAL"} += $seqIDsAndAmounts{$key};
			}
			
			foreach my $key(sort(keys(%sampleTags))){#print stats by IDs($key)#28-11-2011
				
				my $sampletag;
				my $UniqeOrTotal;
				
				($sampletag,$UniqeOrTotal) = split(/_/,$key);
				
				if($UniqeOrTotal eq 'TOTAL'){
					$total += $sampleTags{$key};
					print $file."\t".$sampletag."\t".$sampleTags{$key}."\t";
				}elsif($UniqeOrTotal eq 'UNIQUE'){
					$unique += $sampleTags{$key};
					print $sampleTags{$key}."\n";
				}
			}
		}
		#print "\n";
		#print "#Total\t$total\n";
		#print "#Total collapsed\t$unique\n";
		
	}
}else{
	print "all files: $ARGV\n are non existent!!!\n";
	exit(2);
} 

