# replace path/to/XXX with your correct paths

# read filtering to get good reads with AfterQC (if you have installed pypy, replace python with pypy)
python AfterQC/after.py -1 path/to/data/R1.fq.gz -2 path/to/data/R2.fq.gz -g outdir/ -b outdir/ -r outdir/

# alignment
bwa mem -k 32 -t 10 -M hg19.fa outdir/R1.good.fq outdir/R2.good.fq > outdir/test.sam

# convert sam to bam, and sort it
samtools view -bS -@ 10 outdir/test.sam -o outdir/test.bam
samtools sort -@ 10 outdir/test.bam -f outdir/test.sort.bam

# deduplication
python dedup/dedup.py -1 outdir/test.sort.bam -o outdir/test.dedup.bam

# index bam
samtools index outdir/test.dedup.bam

# generate mpileup
# target.bed is a BED file describing the target capturing regions
samtools mpileup -B -Q 20 -C 50 -q 20 -d 20000 -f hg19.fa -l target.bed  outdir/test.dedup.bam >outdir/test.dedup.mpileup

# SNP calling with VarScan
java -jar VarScan.v2.3.8.jar mpileup2snp outdir/test.dedup.mpileup --min-coverage 4 --min-reads2 2 --min-avg-qual 20 --min-var-freq 0.001 --min-freq-for-hom 90 --output-vcf 1 > outdir/test.snp.vcf

# INDEL calling with VarScan
java -jar VarScan.v2.3.8.jar mpileup2indel outdir/test.dedup.mpileup --min-coverage 4 --min-reads2 2 --min-avg-qual 20 --min-var-freq 0.001 --min-freq-for-hom 90 --output-vcf 1 > outdir/test.indel.vcf