<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"> 
<head>
<meta http-equiv="Content-Type" content="application/xml+xhtml; charset=UTF-8" />
<title>summary</title>
<style >
 body {bgcolor:white}
 
 p {
  margin-top: 0em;
  margin-bottom: 2em;
 }
  
 table, td, th, tr {border:1px solid black; border-collapse:collapse; padding:7px 5px;}
 tbody tr:nth-of-type(2n+1) {
  background: none repeat scroll 0 0 #ebebeb;
 }


</style>

</head>
<body>
<pre {font-family:Consolas,Monaco,Lucida Console,Liberation Mono,DejaVu Sans Mono,Bitstream Vera Sans Mono,Courier New, monospace;}>

<p>19-12-2014</p>

<h1>Summary table</h1>

<table><thead>
<tr>
<th>1. sample after adapter trim</th>
<th>reads(fwd/reverse)</th>
<th>2. after collapse reads</th>
<th>Reads</th>
<th>Collapsed reads</th>
<th>3. remove linkers (GAC/TAAGG/TACCAGTAAGG)</th>
<th>Reads</th>
<th>Collapsed reads</th>
<th>% Reads vs 2. after collapse</th>
<th>4. Filter on length &gt;= 33 &amp;  &lt;= 34</th>
<th>Reads</th>
<th>Collapsed reads</th>
<th>% Reads vs Reads at collapse</th>
<th>5. Remove homologs</th>
<th>Reads</th>
<th>Collapsed reads</th>
</tr>
</thead><tbody>
<tr>
<td>17-eGFPfwd3E</td>
<td>843410/644126</td>
<td></td>
<td>843410</td>
<td>60415</td>
<td></td>
<td>71968</td>
<td>1411</td>
<td>8.53%</td>
<td></td>
<td>67202</td>
<td>1307</td>
<td>7.97%</td>
<td></td>
<td>649390</td>
<td>640</td>
</tr>
<tr>
<td>18-eGFPfwd3L</td>
<td>1481063/1119915</td>
<td></td>
<td>1481063</td>
<td>106581</td>
<td></td>
<td>128694</td>
<td>1945</td>
<td>8.69%</td>
<td></td>
<td>120046</td>
<td>1793</td>
<td>8.11%</td>
<td></td>
<td>1177324</td>
<td>901</td>
</tr>
<tr>
<td>8-eGFPfwd3L</td>
<td>1543617/1562697</td>
<td></td>
<td>1543617</td>
<td>88881</td>
<td></td>
<td>137310</td>
<td>2407</td>
<td>8.90%</td>
<td></td>
<td>127675</td>
<td>2219</td>
<td>8.27%</td>
<td></td>
<td>1247783</td>
<td>742</td>
</tr>
<tr>
<td>eGFPfwd3-193</td>
<td>867406/1208614</td>
<td></td>
<td>867406</td>
<td>49302</td>
<td></td>
<td>77798</td>
<td>875</td>
<td>8.97%</td>
<td></td>
<td>72331</td>
<td>793</td>
<td>8.34%</td>
<td></td>
<td>717257</td>
<td>669</td>
</tr>
</tbody></table>

<p>initital fastq: 13882978 reads</p>

<h1>Adapter trim</h1>

<p>A trim for the following adapters was performed. In our script allowed for 1 single nucleotide mismatch and it was done seperately for recognising the forward and reverse insetrion of the sequence. Note that in the actual contruct the reverse primer is reverse complemented to match the forward primer. </p>

<table><thead>
<tr>
<th>PCRset</th>
<th>Forward primer name</th>
<th>Forward primer sequence</th>
<th>Forward primer sequence_original</th>
<th>Reverse primer name</th>
<th>Reverse primer sequence</th>
</tr>
</thead><tbody>
<tr>
<td>1</td>
<td>8-eGFPfwd3L</td>
<td>AATCCGTCCAAGGCATGGACGAGCTGTACAAG</td>
<td>AATCCGTCCAAGGCATGGACGAGCTGTACAAG</td>
<td>BC-rev-L+2:</td>
<td>ATGGGGGATCCTCACTGGCC</td>
</tr>
<tr>
<td>2</td>
<td>17-eGFPfwd3E</td>
<td>CAAGAATATTCTCGGCATGGACGAGCTGTACAAG</td>
<td>CAAGAATATTCTCGGCATGGACGAGCTG</td>
<td>BC-rev-L+6:</td>
<td>TAATATGGGGGATCCTCACTGGCC</td>
</tr>
<tr>
<td>3</td>
<td>eGFPfwd3-193</td>
<td>TCATCTCTGGCATGGACGAGCTGTACAAG</td>
<td>TCATCTCTGGCATGGACGAGCTGTACAAG</td>
<td>BC-rev-L+5:</td>
<td>AATATGGGGGATCCTCACTGGCC</td>
</tr>
<tr>
<td>4</td>
<td>18-eGFPfwd3L</td>
<td>ATCGAATTTATGGCATGGACGAGCTGTACAAG</td>
<td>ATCGAATTTATGGCATGGACGAGCTGTACAAG</td>
<td>BC-rev-L+1:</td>
<td>TGGGGGATCCTCACTGGCC</td>
</tr>
</tbody></table>

<h1>Read collapse</h1>

<p>recution of duplicate reads to a single fasta entry.
fastq example:
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
ABBDFDFDFDFDDDDDDD</p>

<p>after collapse:
&gt;SEQ_1_x2
AAAAAAAAAAAAAAAAAA
&gt;SEQ_3_x1
AAAAAAAAAAAAAAANAA</p>

<h1>Linker trim</h1>

<p>Removal of the linker sequences from the end of the reads (GAC/TAAGG/TACCAGTAAGG).
These linkers are present between the adapters and the 33nt barcode.</p>

<h1>Filter by length</h1>

<table><thead>
<tr>
<th>keep 33-34:</th>
</tr>
</thead><tbody>
<tr>
<td>GTTACATAGTTGCCGAATTATCGCAGAATGTAA</td>
</tr>
<tr>
<td>AAGGTACCATGTCACCGGTTTAAACCATACTAAG</td>
</tr>
<tr>
<td>not</td>
</tr>
<tr>
<td>GTTACATAGT</td>
</tr>
<tr>
<td>GTTACATAGTAAGGTACCATGTCACCGGTTTAAACCATACTAAG</td>
</tr>
</tbody></table>

<h1>Homolog removal</h1>

<p>Removal of similar sequences by trimming data.</p>

<p>this was done:</p>

<ul>
<li>Allowing 1 single nucleotide mismatch</li>
<li>Removing the reads with a count less than or equal to 1</li>
<li>Removing reads when it has a homolog read with a higher count</li>
</ul>


<code>
#create plot
for t in $(ls *.tsv) ; do echo $t; head -1 $t >${t}.tmp;tail -n+2 $t|sort -d$(echo -e "\t") -k2,2n  >>${t}.tmp;Rscript ../PcrProductKlaas/CreateHist.R ${t}.tmp;mv $(basename ${t} .tsv).tmp.pdf $(basename $t .tsv).pdf; rm ${t}.tmp ; done

#create tsv
for fa in $(ls filterlength/*/bctrim.collapsed.fa); do basenamefa=$(basename $(dirname $fa) .keep_33-34);dirnamefa=./;echo -e "ID\tcounts\tsequence" > ${dirnamefa}/${basenamefa}.tsv;perl -ne 'chomp; s/^>SEQ_|\n//g;s/_x|_/\t/g;print $_ if $.%2==1;print "\t".$_."\n" if $.%2==0;' $fa >> ${dirnamefa}/${basenamefa}.tsv; done

#filter for homolog barcodes
(for i in $(ls filterlength/*.fa); do echo $i;perl ~/workspace/FastqManipulations/barcodeCleanup.pl $i & done)&

#code for filtering by length
mkdir -p  filterlength; 
for fa in $(ls trimlinkers/*.fa); do 
	perl ~/workspace/FastqManipulations/FilterFaByLength.pl 33 34 $fa > filterlength/$(basename $fa .trim_GAC_TAAGG.fa).keep_33-34.fa ;
done

#collapse again?

#code for trimming linkers
mkdir -p trimlinkers;
for fa in $(ls collapse/*fa); do 
	basenamefa=$(basename $fa .collapse_md.fa);
	cat $fa | \
	perl ~/workspace/FastqManipulations/TrimGACfa.pl -| \
	perl ~/workspace/FastqManipulations/TrimTAAGGfa.pl - > trimlinkers/${basenamefa}.trim_GAC_TAAGG.fa;
done



#code for collapse (using the mirdeep package)
mkdir -p collapse;
for fq in $(ls trimAdapters/*.fq); do 
	dirnamefq=$(dirname $fq);
	basenamefq=$(basename $(basename $fq .fwtrim.fq) .rvtrim.fq);
	cat $dirnamefq/${basenamefq}.fwtrim.fq  <(perl -wpe 'chomp;$_=reverse($_);tr/ATCGNatcgn/TAGCNtagcn/;' $dirnamefq/${basenamefq}.rvtrim.fq) | \
	fastq2fasta.pl -| \
	collapse_reads_md.pl - SEQ > collapse/${basenamefq}.collapse_md.fa;
done

#code for trimming adapters
for data in $(cat samplesheet.csv); do 
	CMD=$data";
	echo \$(gzip -dc KlaasPCRproducten_S1_L001_R1_001.fastq.gz| \
	perl ~/workspace/FastqManipulations/adapterTrimmer.pl -i - -a \$(perl -wpe 'chomp;\$_=reverse(\$_);tr/ATCGNatcgn/TAGCNtagcn/;' <(echo \$fwdPrimer)) -B -m 1 -o - |\
	perl ~/workspace/FastqManipulations/adapterTrimmer.pl -i - -a \$reversePrimer -A -m 1 -o - >trimAdapters/\${samplename}.rvtrim.fq ) &
	echo \$(gzip -dc KlaasPCRproducten_S1_L001_R1_001.fastq.gz| \
	perl ~/workspace/FastqManipulations/adapterTrimmer.pl -i - -a  \$fwdPrimer -A -m 1 -o - | \
	perl ~/workspace/FastqManipulations/adapterTrimmer.pl -i - -a \$(perl -wpe 'chomp;\$_=reverse(\$_);tr/ATCGNatcgn/TAGCNtagcn/;' <(echo \$reversePrimer )) -B -m 1 -o - > trimAdapters/\${samplename}.fwtrim.fq) &" ; 
	echo $CMD;
done
#copypase/pipe to bash the returned commands are good for trimming
</code>

#them comparison
TGGGGGATCCTCACTGGCCGTC
TGGGGGATCCTCAC<b>C</b>GGCCGTC
TGGGG<b>-A</b>TCCTCACTGGCCGTC

CTTGTACAGCTCGTCTATGCCGTC
CT<b>G</b>GTACAGCTCGTCCATGCC
CTTGTACAGCTCGTCCATGCC
CTTGTACAGCTC<b>T</b>TCCATGCC
CTTGTACAGCTCGTC<b>T</b>ATGCC
CTTGTACAGCTCGTCCATGAT
CTTGTACAGCTCGTCCATGAT
CTTGTCAACCTCGTCCTTGCC
CAGCTCGTCCATGCCTTG

#them adapters 
#8-eGFPfwd3L
CTTGTACAGCTCGTCCATGCCTTGGACGGATT
<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TTGGACGGATTATCTCTAGATCTGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATG
<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TTGGACGGATTATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGT
<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TTGGACGGATTATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTC
<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TTGGACGGATTATCTCTAGATCGGAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCG
<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TTGGATCTGTTGATCTGAAGAGCGGATCAGCAGTAATGCCGAAACCCAAATCCTATGCCGTATT
#eGFPfwd3-193
CTTGTACAGCTCGTCCATGCCAGAGATGA
<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>AGAGATGAATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCG
<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>AGAGATGAATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTAT
<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>AGAGATGAATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCG
#18-eGFPfwd3L
CTTGTACAGCTCGTCCATGCCATAAATTCGAT
<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>ATAAATTCGATATCTCTAGACCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATATCGTATG
<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>ATAAATTCGATATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCG
<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>ATAAATTCGATATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCG
#17-eGFPfwd3E
CTTGTACAGCTCGTCCATGCCGAGAATATTCTTG
<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>GAGAATATTCTTGATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCG
<span style="color:red;font-weight:bold;">CTGGTACAGCTCGTCCATGCC</span>GAGAATATTCTTGATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTC
<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>GAGAATATTCTTGATCTCTAGATCGGAAGAGCGGTTCAGCAGGGAATGCCGAGACCGG
<span style="color:red;font-weight:bold;">CTGGTACAGCTCGTCCATGCC</span>GAGAATATTCTTGATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTC

#made with
terpstramm@terpstramm-HP-EliteBook-Folio-9470m:/media/terpstramm/My_Book/largeDataByProject/PCRproductKlaasMiseq$ gzip -dc KlaasPCRproducten_S1_L001_R1_001.fastq.gz  | head -400 | grep --color=always -P "TGGGGGATCCTCACTGGCCGTC|CTGGTACAGCTCGTCCATGCC|CTTGTACAGCTCGTCCATGCC|CAGCTCGTCCATGCCTTG|CTTGTACAGCTCTTCC|TGGGGGATCCTCACCGGCCGTC|CTTGTACAGCTCGTCCATGAT|CTTGTACAGCTCGTCTATGCCGTC|CTTGTCAACCTCGTCCTTGCC|CTTGTACAGCTCGTCCATGAT|CTTGTACAGCTCGTCTATGCC" |aha --line-fix > grep.output.html
#######################################################################################################################################################
AGAGATAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACCGGCCGTC</span>ATCCAATTTGAGTTAAATCGTTGACTTTGTTTGCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>AGAGATGAATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGAACCGATCTCGT
CGAGATTATTA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CTTCATCATGCGTTACTCCGGGGACTACGTGATCCTTA<span style="color:red;font-weight:bold;">CTGGTACAGCTCGTCCATGCC</span>GAGAATATTCTTGATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATC
AGAGATAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>GTTCAGTTTGATGTATAACGTTAACTATGTCGGCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TTGGACGGATTATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCG
AGAGATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>TGGCACCGTGAAATATAACGGCCACATCGTTTACCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TTGGACGGATTATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTAT
AGAGAT<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CTTACGTTGAGCTACTGCGTTGACTAGGTATGTTCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>ATGGACGGATTATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTAT
CGAGAT<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>GCACAAGTTGCATTAATGCGAGCACCAGGTCACCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>ATAAATTCGATATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATG
AGAGAT<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CTCCCTCTTGCTCTAATCCGTTAACTTCGTCATCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TGAGATGAATCTTCTCTTCCTCAGAACGGTTCATCAGGGGAATGCCGAGACCGATCTCGTATGC
AGAGATTAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>AGGCATAATGGTTAATACGCCAACGTCGTTATCCTTA<span style="color:red;font-weight:bold;">CTGGTACAGCTCGTCCATGCC</span>AAAATCGATATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGT
CGAGAT<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>ATACAACATGCCATAGGCCGGCAACATTGTAATCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>GAGAATATTCTTGATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGT
AGAGATTAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CCTCAATGTGGCGTAAATCGTGCACTCCGTGTCCCTTA<span style="color:red;font-weight:bold;">CTGGTACAGCTCGTCCATGCC</span>GAGAATATTCTTGATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATC
CGAGATTAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>TTGCATACTGGACTATAACGATTACATTGTAAGCCTTA<span style="color:red;font-weight:bold;">CTGGTACAGCTCGTCCATGCC</span>GAGAATATTCGATATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATC
AGAGATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>GATCAGAGTGTAGTAGTTCGGCCGTCGTAGTCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>ATAAATTCGATATCTCTAGATCGGACGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGC
AGAGATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>TACCACTTTGTCCTACAACGACAACAACGTTGCCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TTGGAATATCTCTATATCGGAAGAGCGATTCAGCAGGAATGCCGAGACCGATCTCGTATGCCG
CGAGATTAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CTTACCATGGAGTAGGTCGATTACTCTCTGCATTCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCTTCC</span>ATGCCGAGAATATTCTTGATCTCTAGATCGGACGAGCGGTTCAGCAGGAATGCCGAGACCGAT
AGAGATTAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>AAGCACTTTGTGATAATTCGGGAACGTCGTGGTCCTTA<span style="color:red;font-weight:bold;">CTGGTACAGCTCGTCCATGCC</span>GAGAATATTCTTGATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATC
CGAGATTAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CTTCATGATGCATTAACTCGATTACGTAGTGGCCCTTA<span style="color:red;font-weight:bold;">CTGGTACAGCTCGTCCATGCC</span>GAGAATATTCTTGATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATC
AGAGATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>ATCCAGTCTGTGTTATTGCGCTTACCTCGTGCACCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TTGGACGGATTATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTAT
AGAGATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>ATCCAGGTTGCATTACACCGTAGACCTAGTGACCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>ATAAATTTCGATATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGT
AGAGAT<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>GTCCAAAGTGACATAACTCGCGTACTCCGTTAACCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>AGAGATGAATCTCTAGATCGGACGAGCGGTTCAGCAGGAATGCCGAGACCGATATCGTATGCCG
AGAGATAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CTTCATGATGCATTAACCCGATTACGTAGTGGTCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TTGGACGGATTATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCG
CGAGATAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>GCCCAATGTGCGGTATCTCGTTAACCATGTGGACCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCTATGCC</span>AGAGATGAATCTCTAGATCCGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTAT
CGAGATTAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>ATTCATCATGCGGTCGTCGACTACATCGTTGGCCTTA<span style="color:red;font-weight:bold;">CTGGTACAGCTCGTCCATGCC</span>GAGAATATTCTTGATCTCTAGATCGGAAGAGCGGTTCAGCAGGAAATGCCGAGACCGATC
AGAGATTAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CATCACGCTGAAGTAGACCGCCCACGACGTACTCCTTA<span style="color:red;font-weight:bold;">CTGGTACAGCTCGTCCATGCC</span>GAGAATATTCTTATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCT
CGAGATTATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CTTCGTCTGTCGTAATTCGTGGAACTTGTCGGTTCCTTC<span style="color:red;font-weight:bold;">CTTGTCAACCTCGTCCTTGCC</span>TTGGCCGGTTTTTCTCTAGTTCGGAAAGCGGGTTCGCAAGGAATGCCGAAACCGATTTC
CGAGATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CTTAGGCTGTGGTAATTCGTGGACCTTGTCGGTTCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>GAGAATATTCTTGATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCG
AGAGATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>GTGCAGTATGACCTAAAACGTGAACCACGTCAACCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TTGGACGGATTATCTCTAGATCGGAAGAGCGGTTCAGCAAGAATGCCGAGACCGATCTCGTAT
CGAGATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>TAACACCTTGCAGTATGGCGGGGACTCCGTTCCCCTTACCTTTTACAGCTCTTCCTTGCCTTGGTCGGCTTGTTTCTTAGACCGGCGAACGGGTTCACCGGGAATGCCGGGCCCGTTTCCGT
AGAGATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CTTCACGTTATGTATGACCGATCCCCTGTCTCTCCTTTCTTTTACCACTCCTCCCTTCCCTTGACCGATCTCCTCTTCAGCAGAGCGGCTCATCAGCAATGCTGCCACCAACCTCGTCTGAC
AGAGATAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>GGACAACATGTGTTATTGCGAAAACCACGCACTCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>AGAGATGAATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTAT
CGAGAT<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CTTACTCTGGTTTACCGCGAATACTTTGTGAGTTCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>AGAGATGAATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCC
AGAGATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>ATACAATATGCCATATGTCGCCCACGGTGTCAGCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TTGGACGGATTATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTAT
AGAGAT<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>GTACATATTGAGATACCGCGGCGACGGGGTGCTCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>ATAAATTCGATATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATG
AGAGAT<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>AAACATCCTGTCTTAACTCGGGAACCATGTCACCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>ATAAATTCGGTATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATG
AGAGATATGGGGATCCTCACTGGCCGTCGTGCAGGTTGAGTTATGGCGAAGACTTGGTTTACCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TTGGACGGATTATCTCTAGATCTGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATG
AGAGATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CTTACGTTGACCTACTGCGTTGACTAGGTATGTTCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TTGGACGGATTATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGT
AGAGATAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CTTACGCTGCTCTATTTCGAGAACTACGTAGCTTCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGAT</span>CTCTAGATCCGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTC
AGAGATTAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>TCATTATGCTTTATACCGGGAACTGAGTCGCCCTTA<span style="color:red;font-weight:bold;">CTGGTACAGCTCGTCCATGCC</span>GAGAATATTCTTGATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTC
AGAGAT<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>GTACATATTGAGATACGTCGTTGACGGCGTCTTCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TTGGACGGATTATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATG
AGAGATAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CTTACACTGATTTACACCGTACACATAGTTGATTCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>GAGAATATTCTTGATCTCTAGATCGGAAGAGCGGTTCAGCAGGGAATGCCGAGACCGG
AGAGATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CAACAGAATGACATAAAACGTCCACTGTGTATACCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>ATAAATTCGATATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTAT
AGAGATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>TGCCAAATTGCCATACTCCGATTACTAGGTGCGCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>AGAGATGAATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCC
AGAGAT<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>TACCAAGTTGCTTTACGGCGGTAACCCGGTACACCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>AGAGATGAATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCG
AGAGATAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>AGTCACGGTGTCTTACTGCGCGCACTCTGTTCGCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TTGGACGATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATG
AGAGATAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CTTAGTATGGTTTAAACCGGTGACATGGTACCTTCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TTGGACGGATTATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTC
AGAGAT<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>GATCATCTTGGAATATATCGAAAACATTGTGTTCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>ATAAATTCGATATCTCTAGACCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATATCGTATG
CGATATTAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CATCATATTGCATTATCACGTTGACTCCGTCAGCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TTGGACGGATTATCTCTAGATCGGAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCG
AGAGATAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>GAACATACTGTCCTATATCGCACACAACGTCGTCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>ATAAATTCGATATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCG
AGAGAT<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CATCAATATGCATTAAACCGTACACCATGTACCCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>TTGGATCTGTTGATCTGAAGAGCGGATCAGCAGTAATGCCGAAACCCAAATCCTATGCCGTATT
AGAGATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CTTAATATGCGATACCACGTCGACACGGTTGACCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>AGAGATGAATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCG
AGAGATAATA<span style="color:red;font-weight:bold;">TGGGGGATCCTCACTGGCCGTC</span>CCTCACCTTGCGTTACGGCGATCACGAGGTGCTCCTTA<span style="color:red;font-weight:bold;">CTTGTACAGCTCGTCCATGCC</span>AGAGATGAATCTCTAGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTAT

</pre>
</body>
</html>
