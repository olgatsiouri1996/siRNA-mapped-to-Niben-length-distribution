#!/bin/bash
for i in `cat list`
do
echo "Running of bowtie from unaligned sRNA reads to transcriptome as reference"
# map to nicotiana benthamiana transcriptome
bowtie -v 0  --norc --best --strata -a --threads 4 niben/niben ${i}"-SMALLRNA_A-smallRNA_Seq.fastq.gz" --al all/${i}"-niben-aligned.fastq"  -S all/${i}"-SMALLRNA_A-smallRNA_Seq.sam"
# collect 21-28 nt
cutadapt -m 21 -M 21 -o all/${i}_21.fastq all/${i}"-niben-aligned.fastq" 
cutadapt -m 22 -M 22 -o all/${i}_22.fastq all/${i}"-niben-aligned.fastq" 
cutadapt -m 23 -M 23 -o all/${i}_23.fastq all/${i}"-niben-aligned.fastq" 
cutadapt -m 24 -M 24 -o all/${i}_24.fastq all/${i}"-niben-aligned.fastq" 
cutadapt -m 25 -M 25 -o all/${i}_25.fastq all/${i}"-niben-aligned.fastq" 
cutadapt -m 26 -M 26 -o all/${i}_26.fastq all/${i}"-niben-aligned.fastq" 
cutadapt -m 27 -M 27 -o all/${i}_27.fastq all/${i}"-niben-aligned.fastq" 
cutadapt -m 28 -M 28 -o all/${i}_28.fastq all/${i}"-niben-aligned.fastq"
# count number of reads per siRNA length
grep -c "^@" all/${i}_21.fastq >> bam/num-21nt-niben-aligned.txt
grep -c "^@" all/${i}_22.fastq >> bam/num-22nt-niben-aligned.txt
grep -c "^@" all/${i}_23.fastq >> bam/num-23nt-niben-aligned.txt
grep -c "^@" all/${i}_24.fastq >> bam/num-24nt-niben-aligned.txt
grep -c "^@" all/${i}_25.fastq >> bam/num-25nt-niben-aligned.txt
grep -c "^@" all/${i}_26.fastq >> bam/num-26nt-niben-aligned.txt
grep -c "^@" all/${i}_27.fastq >> bam/num-27nt-niben-aligned.txt
grep -c "^@" all/${i}_28.fastq >> bam/num-28nt-niben-aligned.txt
done
echo "Completed analysis for whole run!!"
