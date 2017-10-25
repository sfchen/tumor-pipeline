# ctdna-pipeline
A simplified pipeline for ctDNA sequencing data analysis

# prepare the tools
* BWA: https://github.com/lh3/bwa
* Samtools: https://github.com/samtools/samtools
* VarScan: https://github.com/dkoboldt/varscan
* AfterQC: https://github.com/OpenGene/AfterQC
* dedup.py: https://github.com/OpenGene/dedup

# prepare the reference data and databases
* hg19: http://hgdownload.cse.ucsc.edu/downloads.html
* Annovar: http://annovar.openbioinformatics.org/en/latest/user-guide/startup/

# get data for testing
A pair of FastQ files (R1.fq.gz and R2.fq.gz) can be downloaded from http://opengene.org/dataset.html

# test the pipeline
modify `pipeline.sh` according to your local settings, run it.
