

19-12-2014

Summary table
=============

1. sample after adapter trim | reads(fwd/reverse) | 2. after collapse reads | Reads | Collapsed reads | 3. remove linkers (GAC/TAAGG/TACCAGTAAGG) | Reads | Collapsed reads | % Reads vs 2. after collapse | 4. Filter on length >= 33 &  <= 34 | Reads | Collapsed reads | % Reads vs Reads at collapse | 5. Remove homologs | Reads | Collapsed reads
--- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | ---
17-eGFPfwd3E | 843410/644126  | | 843410 | 60415 |  | 71968 | 1411 | 8.53% |  | 67202 | 1307 | 7.97% |  | 649390 | 640
18-eGFPfwd3L| 1481063/1119915 | | 1481063 | 106581 |  | 128694 | 1945 | 8.69% |  | 120046 | 1793 | 8.11% |  | 1177324 | 901
8-eGFPfwd3L| 1543617/1562697 | | 1543617 | 88881 |  | 137310 | 2407 | 8.90% |  | 127675 | 2219 | 8.27% |  | 1247783 | 742
eGFPfwd3-193| 867406/1208614 | | 867406 | 49302 |  | 77798 | 875 | 8.97% |  | 72331 | 793 | 8.34% |  | 717257 | 669

initital fastq: 13882978 reads


Adapter trim
============

A trim for the following adapters was performed. In our script allowed for 1 single nucleotide mismatch and it was done seperately for recognising the forward and reverse insetrion of the sequence. Note that in the actual contruct the reverse primer is reverse complemented to match the forward primer. 

PCRset | Forward primer name | Forward primer sequence | Forward primer sequence_original | Reverse primer name | Reverse primer sequence
--- | --- | --- | --- | --- | ---
1 | 8-eGFPfwd3L | AATCCGTCCAAGGCATGGACGAGCTGTACAAG | AATCCGTCCAAGGCATGGACGAGCTGTACAAG | BC-rev-L+2:      | ATGGGGGATCCTCACTGGCC
2 | 17-eGFPfwd3E | CAAGAATATTCTCGGCATGGACGAGCTGTACAAG | CAAGAATATTCTCGGCATGGACGAGCTG | BC-rev-L+6:   | TAATATGGGGGATCCTCACTGGCC
3 | eGFPfwd3-193 | TCATCTCTGGCATGGACGAGCTGTACAAG | TCATCTCTGGCATGGACGAGCTGTACAAG | BC-rev-L+5:   | AATATGGGGGATCCTCACTGGCC
4 | 18-eGFPfwd3L | ATCGAATTTATGGCATGGACGAGCTGTACAAG | ATCGAATTTATGGCATGGACGAGCTGTACAAG | BC-rev-L+1:   | TGGGGGATCCTCACTGGCC



Read collapse
=============

recution of duplicate reads to a single fasta entry.
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
ABBDFDFDFDFDDDDDDD

after collapse:
\>SEQ_1_x2
AAAAAAAAAAAAAAAAAA
\>SEQ_3_x1
AAAAAAAAAAAAAAANAA

Linker trim
===========

Removal of the linker sequences from the end of the reads (GAC/TAAGG/TACCAGTAAGG).
These linkers are present between the adapters and the 33nt barcode.


Filter by length
================

|keep 33-34: |
| --- |
|GTTACATAGTTGCCGAATTATCGCAGAATGTAA |
|AAGGTACCATGTCACCGGTTTAAACCATACTAAG |
|not |
|GTTACATAGT |
|GTTACATAGTAAGGTACCATGTCACCGGTTTAAACCATACTAAG |

Homolog removal
===============

Removal of similar sequences by trimming data.

this was done:
 - Allowing 1 single nucleotide mismatch
 - Removing the reads with a count less than or equal to 1
 - Removing reads when it has a homolog read with a higher count

