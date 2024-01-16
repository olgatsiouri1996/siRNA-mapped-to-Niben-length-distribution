#!/bin/bash
for i in `cat list`
do 
	cutadapt -m 21 -M 21 -o ${i}_21.fastq.gz ${i}-SMALLRNA_A-smallRNA_Seq.fastq.gz
	cutadapt -m 22 -M 22 -o ${i}_22.fastq.gz ${i}-SMALLRNA_A-smallRNA_Seq.fastq.gz
	cutadapt -m 23 -M 23 -o ${i}_23.fastq.gz ${i}-SMALLRNA_A-smallRNA_Seq.fastq.gz
	cutadapt -m 24 -M 24 -o ${i}_24.fastq.gz ${i}-SMALLRNA_A-smallRNA_Seq.fastq.gz
	cutadapt -m 25 -M 25 -o ${i}_25.fastq.gz ${i}-SMALLRNA_A-smallRNA_Seq.fastq.gz
	cutadapt -m 26 -M 26 -o ${i}_26.fastq.gz ${i}-SMALLRNA_A-smallRNA_Seq.fastq.gz
	cutadapt -m 27 -M 27 -o ${i}_27.fastq.gz ${i}-SMALLRNA_A-smallRNA_Seq.fastq.gz
	cutadapt -m 28 -M 28 -o ${i}_28.fastq.gz ${i}-SMALLRNA_A-smallRNA_Seq.fastq.gz
done
	
