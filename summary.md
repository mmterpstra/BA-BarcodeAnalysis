<style {font-family:Consolas,Monaco,Lucida Console,Liberation Mono,DejaVu Sans Mono,Bitstream Vera Sans Mono,Courier New, monospace;font-size:6}>



Intro
=====

Artificial barcodes have been sequenced after pooling the 500 barcodes together and after lentiviral transduction of cell cultures. This can ben used for tracking individual cells if the library density is high enough or can be used for to asses of homogenity of proliferation of the cell culture. In our experiment we have used the barcodes for assesment of the selective pressure of the barcodes so it can be compared with lentiviral sh mediated knockdowns or lentiviral knockin of genes.

We did this in 3 main parts:

 1. Analysis of the four barcode pools and selection of about 500 random barcodes..
 1. Quantify run of the four barcode pools consisting of about 500 random barcodes and removal of multiple mapping barcodes
 3. Quantify run of ~200 samples
 
This document describes this in three parts:
 - Workflows & result tables
 - Methods
 - Example Code
 
The "Workflows & result tables" section describes the workflows and based on the workflows presents result tables. The "Methods" section describes the methods used in the different parts of the workflow. The "Example Code" section describes the code for performing the different mentioned in the "Methods/Workflows" section.

Workflows & result tables
=========================

Analysis of 4 barcode pools
---------------------------
The barcode data was analysed using mirdeep helper scripts and custom made scripts present here.
The analyses consisted of the following operations on the data to find the best amount of barcodes:

1. Adapter trim (bc adapter and the adapter containing the samplespecific part)
2. Read collapse
3. Linker trim
4. collapse again
5. Filter by length
6. Homolog removal 1mm
7. Merge datasets
   - homolog removal 1mm?
8. Homolog removal 2mm on single and merged datasets

Then we did a quantification run on the 4 pools, only checking the samplespecific adapter and the random barcode improving the  yield:

1. Adapter trim (the adapter containing the samplespecific part)
2. Read collapse
3. Adapter trim (for each of the ~500 barcodes)

This is done twice once for 0 mismatches and once for 1 mismatches in steps 1 & 3. 

Then we did a quantification run on the ~200 samples:

1. Adapter trim (the adapter containing the samplespecific part)
2. Read collapse
3. Adapter trim (for each of the ~500 barcodes)

This is done twice once for 0 mismatches and once for 1 mismatches in steps 1 & 3.

Summary table of analysis of 4 barcode pools
--------------------------------------------

this table tries to summarise the results

current:

initital fastq: 13882978 reads


step	|	stepname			|	sample		|	Reads	|	Collapsed reads
--------|---------------------------------------|-----------------------|---------------|----------------------
1	|	Adapter trim			|	17-eGFPfwd3E	|	843410/644126 (fwd/reverse)	|	
2	|	Collapse after adapter trim	|	17-eGFPfwd3E	|	1487536	|	93413
3	|	Trim on linkers			|	17-eGFPfwd3E	|	1395112	|	69513
4	|	Collapse after linker trim	|	17-eGFPfwd3E	|	1395112	|	65486
5	|	Filter on length		|	17-eGFPfwd3E	|	1297389	|	58390
6	|	Homolog removal 1mm		|	17-eGFPfwd3E	|	1183152	|	855 [pdf](https://github.com/mmterpstra/BA-BarcodeAnalysis/blob/master/pdf/17-eGFPfwd3E.collapse_md.keep_33-34.fa.pdf?raw=true)
8	|	Homolog removal 2mm		|	17-eGFPfwd3E	|	1178649	|	756
1	|	Adapter trim			|	18-eGFPfwd3L	|	1481063/1119915 (fwd/reverse)	|	
2	|	Collapse after adapter trim	|	18-eGFPfwd3L	|	2600978	|	158669
3	|	Trim on linkers			|	18-eGFPfwd3L	|	2512249	|	134702
4	|	Collapse after linker trim	|	18-eGFPfwd3L	|	2512249	|	134210
5	|	Filter on length		|	18-eGFPfwd3L	|	2334138	|	119084
6	|	Homolog removal 1mm		|	18-eGFPfwd3L	|	2086164	|	1367 [pdf](https://github.com/mmterpstra/BA-BarcodeAnalysis/blob/master/pdf/18-eGFPfwd3L.collapse_md.keep_33-34.fa.pdf?raw=true)
8	|	Homolog removal 2mm		|	18-eGFPfwd3L	|	2077441	|	1236 
1	|	Adapter trim			|	8-eGFPfwd3L	|	1543617/1562697 (fwd/reverse)	|	
2	|	Collapse after adapter trim	|	8-eGFPfwd3L	|	3106314	|	163385
3	|	Trim on linkers			|	8-eGFPfwd3L	|	3010420	|	139339
4	|	Collapse after linker trim	|	8-eGFPfwd3L	|	3010420	|	138903
5	|	Filter on length		|	8-eGFPfwd3L	|	2782738	|	118561
6	|	Homolog removal 1mm		|	8-eGFPfwd3L	|	2504569	|	1868 [pdf](https://github.com/mmterpstra/BA-BarcodeAnalysis/blob/master/pdf/8-eGFPfwd3L.collapse_md.keep_33-34.fa.pdf?raw=true)
8	|	Homolog removal 2mm		|	8-eGFPfwd3L	|	2494862	|	1678
1	|	Adapter trim			|	eGFPfwd3-193	|	867406/1208614 (fwd/reverse)|
2	|	Collapse after adapter trim	|	eGFPfwd3-193	|	2076020	|	110927
3	|	Trim on linkers			|	eGFPfwd3-193	|	2013563	|	94335
4	|	Collapse after linker trim	|	eGFPfwd3-193	|	2013563	|	93985
5	|	Filter on length		|	eGFPfwd3-193	|	1862435	|	80481
6	|	Homolog removal 1mm		|	eGFPfwd3-193	|	1700850	|	1288 [pdf](https://github.com/mmterpstra/BA-BarcodeAnalysis/blob/master/pdf/eGFPfwd3-193.collapse_md.keep_33-34.fa.pdf?raw=true)
8	|	Homolog removal 2mm		|	eGFPfwd3-193	|	1694066	|	1147
7	|	Merge Datasets			|	Merged		|	7474735	|	3565 [pdf](https://github.com/mmterpstra/BA-BarcodeAnalysis/blob/master/pdf/bctrim.pdf?raw=true)
-	|	Homolog removal 1mm		|	Merged		|	7474583	|	3502 [pdf](https://github.com/mmterpstra/BA-BarcodeAnalysis/blob/master/pdf/bctrim_1mm.pdf?raw=true)
8	|	Homolog removal 2mm		|	Merged		|	7444426	|	2943

Conclusion:
Not all data is cleanable by allowing 1 or more nucleotide polymorfisms so for better cleanup indels should be considered. The results here show that the dataset complexity of about 500 artificial sequences mixed equally result in many more observed sequences depending on the depth of sequencing. Also the cleanup is able to reduce dataset complexity to 1% of the initial unique sequences and should be used to reduce false discoveries. The demultiplexing and complexity reduction of reads also has applications in increasing the amount of pooled samples in a single sequencing run and possibly miRNA's. 

quantification run on the 4 pools
---------------------------------

initital fastq (same as prevous): 13882978 reads


step | stepname				| sample		| Reads		| Collapsed reads	| mm
-----|----------------------------------|-----------------------|---------------|-----------------------|---
1    | Samplespecific adapter trim 	| 17-eGFPfwd3E 		| 2670617	| 505966		| 0
2    | Read collapse		 	| 17-eGFPfwd3E 		| 2670617	| 505966		| 0
3    | Barcode adapter trim	 	| 17-eGFPfwd3E 		| 2261443	| 257669		| 0
1    | Samplespecific adapter trim 	| 17-eGFPfwd3E 		| 2792101	| 551772		| 1
2    | Read collapse		 	| 17-eGFPfwd3E 		| 2792101	| 551772		| 1
3    | Barcode adapter trim	 	| 17-eGFPfwd3E 		| 2416519	| 371907		| 1
1    | Samplespecific adapter trim 	| 18-eGFPfwd3L 		| 2424959	| 443085		| 0
2    | Read collapse		 	| 18-eGFPfwd3L 		| 2424959	| 443085		| 0
3    | Barcode adapter trim	 	| 18-eGFPfwd3L 		| 2021103	| 207016		| 0
1    | Samplespecific adapter trim 	| 18-eGFPfwd3L 		| 2688475	| 508716		| 1
2    | Read collapse		 	| 18-eGFPfwd3L 		| 2688475	| 508716		| 1
3    | Barcode adapter trim	 	| 18-eGFPfwd3L 		| 2172441	| 311691		| 1
1    | Samplespecific adapter trim 	| 8-eGFPfwd3L 		| 2844152	| 485055		| 0
2    | Read collapse		 	| 8-eGFPfwd3L 		| 2844152	| 485055		| 0
3    | Barcode adapter trim	 	| 8-eGFPfwd3L 		| 2396236 	| 220525		| 0
1    | Samplespecific adapter trim 	| 8-eGFPfwd3L 		| 3280829	| 582815		| 1
2    | Read collapse		 	| 8-eGFPfwd3L 		| 3280829	| 582815		| 1
3    | Barcode adapter trim	 	| 8-eGFPfwd3L 		| 2576582	| 338302		| 1
1    | Samplespecific adapter trim 	| eGFPfwd3-193 		| 2563602	| 414875		| 0
2    | Read collapse		 	| eGFPfwd3-193 		| 2563602	| 414875		| 0
3    | Barcode adapter trim	 	| eGFPfwd3-193 		| 2190566	| 209101		| 0
1    | Samplespecific adapter trim 	| eGFPfwd3-193 		| 2776328	| 461136		| 1
2    | Read collapse		 	| eGFPfwd3-193 		| 2776328	| 461136		| 1
3    | Barcode adapter trim	 	| eGFPfwd3-193 		| 2329905	| 303702		| 1

```yield 0mm = (2261443 + 2021103 + 2396236 + 2190566) / 13882978 = 0.64 ```

```yield 1mm = (2416519 + 2172441 + 2576582 + 2329905) / 13882978 = 0.68 ```

Methods
=======

Adapter trim
------------

A trim for the following adapters was performed. In our script allowed for 1 single nucleotide mismatch and it was done seperately for recognising the forward and reverse insetrion of the sequence. Note that in the actual contruct the reverse primer is reverse complemented to match the forward primer. 

PCRset | Forward primer name | Forward primer sequence | Forward primer sequence_original | Reverse primer name | Reverse primer sequence
--- | --- | --- | --- | --- | ---
1 | 8-eGFPfwd3L | AATCCGTCCAAGGCATGGACGAGCTGTACAAG | AATCCGTCCAAGGCATGGACGAGCTGTACAAG | BC-rev-L+2:      | ATGGGGGATCCTCACTGGCC
2 | 17-eGFPfwd3E | CAAGAATATTCTCGGCATGGACGAGCTGTACAAG | CAAGAATATTCTCGGCATGGACGAGCTG | BC-rev-L+6:   | TAATATGGGGGATCCTCACTGGCC
3 | eGFPfwd3-193 | TCATCTCTGGCATGGACGAGCTGTACAAG | TCATCTCTGGCATGGACGAGCTGTACAAG | BC-rev-L+5:   | AATATGGGGGATCCTCACTGGCC
4 | 18-eGFPfwd3L | ATCGAATTTATGGCATGGACGAGCTGTACAAG | ATCGAATTTATGGCATGGACGAGCTGTACAAG | BC-rev-L+1:   | TGGGGGATCCTCACTGGCC

Read collapse
-------------

reduction of duplicate reads to a single fasta entry.
fastq example:

```
@read1
AAAAAAAAAAAAAAAAAA
+read1
ABBDFDFDFDFDDDGGGG
@read2
AAAAAAAAAAAAAAAAAA
+read2
ABBDFDFDFDFDDDDDDD
@read3
AAAAAAAAAAAAAAANAA
+read4
ABBDFDFDFDFDDDDDDD
```

after collapse:
```
>SEQ_1_x2
AAAAAAAAAAAAAAAAAA
>SEQ_3_x1
AAAAAAAAAAAAAAANAA
```

Linker trim
-----------

Removal of the linker sequences from the end of the reads (GAC/TAAGG/TACCAGTAAGG).
These linkers are present between the adapters and the 33nt barcode.


Filter by length
----------------

|keep 33-34: |
| --- |
|GTTACATAGTTGCCGAATTATCGCAGAATGTAA |
|AAGGTACCATGTCACCGGTTTAAACCATACTAAG |
|not |
|GTTACATAGT |
|GTTACATAGTAAGGTACCATGTCACCGGTTTAAACCATACTAAG |

Homolog removal
---------------

Removal of similar sequences by trimming data.

this was done:
 - Allowing 1 single nucleotide mismatch
 - Removing the reads with a count less than or equal to 1
 - Removing reads when it has a homolog read with a higher count

Homolog removal (again)
-----------------------

Removal of similar sequences by trimming data.

this was done:

 - Allowing **2** single nucleotide mismatches
 - Removing the reads with a count less than or equal to 1
 - Removing reads when it has a homolog read with a higher count

Example Code
========================

this is example code and will probably not work on your system, or might botch because of missing stuff.


quantification run
-----------------



Convert samplespecific fastq to collaped fasta

1 Adapter trim only samplespecific

```sh
mkdir trimSampleSpecific1mm
largeCmd=$(for data in $(cat samplesheet.csv); do 
    CMD=$data";
    echo \$(gzip -dc KlaasPCRproducten_S1_L001_R1_001.fastq.gz| \
    perl ~/workspace/FastqManipulations/adapterTrimmer.pl -i - -a \$(perl -wpe 'chomp;\$_=reverse(\$_);tr/ATCGNatcgn/TAGCNtagcn/;' <(echo \$fwdPrimer)) -B -m 1 -o - >trimSampleSpecific1mm/\${samplename}.fwtrim.fq) &
    echo \$(gzip -dc KlaasPCRproducten_S1_L001_R1_001.fastq.gz| \
    perl ~/workspace/FastqManipulations/adapterTrimmer.pl -i - -a  \$fwdPrimer -A -m 1 -o - > trimSampleSpecific1mm/\${samplename}.rvtrim.fq) &" ; 
    echo $CMD;
done)
```

2 collapse

```sh
for fq in $(ls trimSampleSpecific1mm/*.fwtrim.fq); do 
	dirnamefq=$(dirname $fq);
	basenamefq=$(basename $(basename $fq .fwtrim.fq) .rvtrim.fq);
	mkdir -p $dirnamefq/collapse;
	cat $dirnamefq/${basenamefq}.rvtrim.fq  <(
		perl -wpe 'chomp;$_=reverse($_);tr/ATCGNatcgn/TAGCNtagcn/;$_.="\n";' $dirnamefq/${basenamefq}.fwtrim.fq) | \
	fastq2fasta.pl -| \
	collapse_reads_md.pl - SEQ > $dirnamefq/collapse/${basenamefq}.collapse_md.fa;
done
```

3 Barcode specific trim + creation of tsv

```sh
#0mismatches
( for fa in $(ls  trimSampleSpecific*mm/collapse2/*.fa);
do
    perl ~/workspace/BarcodeAnalysis/scripts/MultiAdapterTrimmingWrapperCollapseMd.pl $fa SelectionBarcodePools.collapse_md.fa 0 &
done )
#1mm
( for fa in $(ls  trimSampleSpecific*mm/collapse2/*.fa);
do
    perl ~/workspace/BarcodeAnalysis/scripts/MultiAdapterTrimmingWrapperCollapseMd.pl $fa SelectionBarcodePools.collapse_md.fa 0 &
done )
#tsv creation
for dir in $(ls trimSampleSpecific1mm/collapse/*/ -d); do perl ~/workspace/miRNA_stuffs/Collapsed_Summary.pl ${dir}*.fa > $(echo $dir| perl -wpe 's/\/$//g').quantify.tsv & done
#maybe cleanup
rm -rv trimSampleSpecific1mm/collapse/*/
```

finding unique barcode subset of ~500 barcodes
----------------------------------------------

Create plot

```sh
for t in $(ls *.tsv) ; do
	echo $t;
	head -1 $t >${t}.tmp;
	tail -n+2 $t|sort -d$(echo -e "\t") -k2,2nr  >>${t}.tmp;
	Rscript ../PcrProductKlaas/CreateHist.R ${t}.tmp;
	mv $(basename ${t} .tsv).tmp.pdf $(basename $t .tsv).pdf;
	rm ${t}.tmp ;
done
```

8. Create tsv

```sh
for fa in $(ls filterlength/*/bctrim.collapsed.fa); do 
	basenamefa=$(basename $(dirname $fa) .keep_33-34);dirnamefa=./;
	echo -e "ID\tcounts\tsequence" > ${dirnamefa}/${basenamefa}.tsv;
	perl -ne 'chomp; s/^>SEQ_|\n//g;s/_x|_/\t/g;
	print $_ if $.%2==1;print "\t".$_."\n" if $.%2==0;' $fa >> ${dirnamefa}/${basenamefa}.tsv;
done
```

8. Filter for homolog barcodes 2mm

```sh
 for i in $(ls filterlength/*/*.fa); 
 	perl ~/workspace/FastqManipulations/barcodeCleanup.pl 2 $i &
 done
```

7. collapse_md samples into single sample and filter for homolog barcodes

```sh
#something like
cat filterlength/*/*.fa| collapse_reads_md.pl - SEQ > filterlength/merged.collapse_md.fa
perl ~/workspace/FastqManipulations/barcodeCleanup.pl filterlength/merged.collapse_md.fa
```

6. Filter for homolog barcodes

```sh
(for i in $(ls filterlength/*.fa); do 
	echo $i;
	perl ~/workspace/FastqManipulations/barcodeCleanup.pl $i &
done)&
```

5. code for filtering by length

```sh
mkdir -p  filterlength; 
for fa in $(ls collapseTrimlinkers/*.fa); do 
	perl ~/workspace/FastqManipulations/FilterFaByLength.pl 33 34 $fa > filterlength/$(basename $fa .trim_GAC_TAAGG.fa).keep_33-34.fa ;
done
```

4. collapse again

```sh
mkdir -p collapseTrimlinkers
for fa in $(ls trimlinkers/*.fa); do 
	basenamefa=$(basename $fa .trim_GAC_TAAGG.fa);
	cat $fa | collapse_reads_md.pl - SEQ > collapseTrimlinkers/${basenamefa}.collapse_md.fa;
done
```
3. code for trimming linkers
```sh
mkdir -p trimlinkers;
for fa in $(ls collapse/*fa); do 
	basenamefa=$(basename $fa .collapse_md.fa);
	cat $fa | \
	perl ~/workspace/FastqManipulations/TrimGACfa.pl -| \
	perl ~/workspace/FastqManipulations/TrimTAAGGfa.pl - > trimlinkers/${basenamefa}.trim_GAC_TAAGG.fa;
done
```


2. code for collapse (using the mirdeep package)

```sh
mkdir -p collapse;
for fq in $(ls trimAdapters/*.fwtrim.fq); do 
	dirnamefq=$(dirname $fq);
	basenamefq=$(basename $(basename $fq .fwtrim.fq) .rvtrim.fq);
	cat $dirnamefq/${basenamefq}.fwtrim.fq  <(
		perl -wpe 'chomp;$_=reverse($_);tr/ATCGNatcgn/TAGCNtagcn/;$_.="\n";' $dirnamefq/${basenamefq}.rvtrim.fq) | \
	fastq2fasta.pl -| \
	collapse_reads_md.pl - SEQ > collapse/${basenamefq}.collapse_md.2.fa;
done
```

1. code for trimming adapters

```sh
mkdir trimAdapters

largeCmd=$(for data in $(cat samplesheet.csv); do 
	CMD=$data";
	echo \$(gzip -dc KlaasPCRproducten_S1_L001_R1_001.fastq.gz| \
	perl ~/workspace/FastqManipulations/adapterTrimmer.pl -i - -a \$(perl -wpe 'chomp;\$_=reverse(\$_);tr/ATCGNatcgn/TAGCNtagcn/;' <(echo \$fwdPrimer)) -B -m 1 -o - |\
	perl ~/workspace/FastqManipulations/adapterTrimmer.pl -i - -a \$reversePrimer -A -m 1 -o - >trimAdapters/\${samplename}.rvtrim.fq ) &
	echo \$(gzip -dc KlaasPCRproducten_S1_L001_R1_001.fastq.gz| \
	perl ~/workspace/FastqManipulations/adapterTrimmer.pl -i - -a  \$fwdPrimer -A -m 1 -o - | \
	perl ~/workspace/FastqManipulations/adapterTrimmer.pl -i - -a \$(perl -wpe 'chomp;\$_=reverse(\$_);tr/ATCGNatcgn/TAGCNtagcn/;' <(echo \$reversePrimer )) -B -m 1 -o - > trimAdapters/\${samplename}.fwtrim.fq) &" ; 
	echo $CMD;
done)
echo $largeCmd
#bash <($largeCmd)
```
copypaste/redirect to bash:the returned commands are good for trimming
