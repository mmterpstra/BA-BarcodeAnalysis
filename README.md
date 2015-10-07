BA-BarcodeAnalysis
==================

The scripts used for the analysis of the 33nt barcode data.

the [summary.md](https://github.com/mmterpstra/BA-BarcodeAnalysis/blob/master/summary.md) file contains the description of our workflow with results.


If you got here looking for demultiplexing ngs reads look for:

[bclToFastq](http://support.illumina.com/sequencing/sequencing_software/bcl2fastq-conversion-software.html): demultiplexing / optional adapter trimming /masking and conversion to fastq

[bbduk from the bbmap package](http://sourceforge.net/projects/bbmap/):demultiplexing and adapter trimming and many more 

[cutadapt](https://github.com/marcelm/cutadapt):removing adapters

[fastqc](http://www.bioinformatics.babraham.ac.uk/projects/fastqc/): assesing resulting fastq files

[ea-utils](https://code.google.com/p/ea-utils/):another toolkit for demultiplexing / adapter trimming

[DigitalBarcodeReadgroups](https://github.com/mmterpstra/DigitalBarcodeReadgroups): If you want to apply an extended barcode (for example consisting of a samplespecific part and a semi-random part).
