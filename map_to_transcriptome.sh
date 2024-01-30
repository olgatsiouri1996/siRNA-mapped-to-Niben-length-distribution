#!/bin/bash
for i in `cat list`; do
    echo "Running bowtie and cutadapt for $i"
    # map to nicotiana benthamiana transcriptome
    bowtie -v 0  --norc --best --strata -a --threads 4 niben/niben ${i}"-SMALLRNA_A-smallRNA_Seq.fastq.gz" --al all/${i}"-niben-aligned.fastq"  -S all/${i}"-SMALLRNA_A-smallRNA_Seq.sam"
    # collect 21-28 nt
    for j in {21..28}; do
        cutadapt -m $j -M $j -o all/${i}_$j.fastq all/${i}"-niben-aligned.fastq"
        grep -c "^@" all/${i}_$j.fastq >> all/num-${j}nt-niben-aligned.txt
    done
done

echo "Completed analysis for the entire run"
