
use warnings;
use strict;
my $IN=*STDIN;
my @fq;
while(<$IN>){
	my $line = $_;
	if($.%4==1){
		$fq[0]=$line;
		warn "line0 $.=".$fq[0];
	}elsif($.%4==2){
		$fq[1]=$line;
		$fq[4]=$line;
		warn "line1/4 $.=".$fq[1];
		
	}elsif($.%4==3){
		$fq[2]=$line;
		warn "line2 $.=".$fq[2];
	}elsif($.%4==0){
		$fq[3]=$line;
		warn "line3 $.=".$fq[3];
		if($fq[1] =~  /[ATCGN]{33,43}([ATCG]{3}AC[ATCG]{3}GT[ATCG]{3}CG[ATCG]{3}TA[ATCG]{3}CA[ATCG]{3}TG[ATCG]{3})[ATCGN]{21,27}|[ATCGN]{21,27}([ATCG]{3}CA[ATCG]{3}TG[ATCG]{3}TA[ATCG]{3}CG[ATCG]{3}AC[ATCG]{3}GT[ATCG]{3})[ATCGN]{33,43}/){
			$fq[1] =~ s/[ATCGN]{33,43}([ATCG]{3}AC[ATCG]{3}GT[ATCG]{3}CG[ATCG]{3}TA[ATCG]{3}CA[ATCG]{3}TG[ATCG]{3})[ATCGN]{21,27}|[ATCGN]{21,27}([ATCG]{3}CA[ATCG]{3}TG[ATCG]{3}TA[ATCG]{3}CG[ATCG]{3}AC[ATCG]{3}GT[ATCG]{3})[ATCGN]{33,43}/$1/;
			print $fq[0].$fq[1]."\n".$fq[2].substr($fq[3],index($fq[4],$fq[1]),length($fq[1]));
		}
	}
}