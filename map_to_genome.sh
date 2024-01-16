#!/bin/bash
for i in `cat list`
do
echo "Running of bowtie from unaligned mature miRNA reads to genome as reference (Exiqon style)"
bowtie -v 0  --norc --best --strata -a --threads 4 niben/niben ${i}"_21.fastq.gz" --al ${i}"-21nt-niben-aligned.fastq" -S ${i}"-21nt-niben-aligned.sam"
grep -c "^@" ${i}"-21nt-niben-aligned.fastq" >> num-21nt-niben-aligned.txt
bowtie -v 0  --norc --best --strata -a --threads 4 niben/niben ${i}"_22.fastq.gz" --al ${i}"-22nt-niben-aligned.fastq" -S ${i}"-22nt-niben-aligned.sam"
grep -c "^@" ${i}"-22nt-niben-aligned.fastq" >> num-22nt-niben-aligned.txt
bowtie -v 0  --norc --best --strata -a --threads 4 niben/niben ${i}"_23.fastq.gz" --al ${i}"-23nt-niben-aligned.fastq" -S ${i}"-23nt-niben-aligned.sam"
grep -c "^@" ${i}"-23nt-niben-aligned.fastq" >> num-23nt-niben-aligned.txt
bowtie -v 0  --norc --best --strata -a --threads 4 niben/niben ${i}"_24.fastq.gz" --al ${i}"-24nt-niben-aligned.fastq" -S ${i}"-24nt-niben-aligned.sam"
grep -c "^@" ${i}"-24nt-niben-aligned.fastq" >> num-24nt-niben-aligned.txt
bowtie -v 0  --norc --best --strata -a --threads 4 niben/niben ${i}"_25.fastq.gz" --al ${i}"-25nt-niben-aligned.fastq" -S ${i}"-25nt-niben-aligned.sam"
grep -c "^@" ${i}"-25nt-niben-aligned.fastq" >> num-25nt-niben-aligned.txt
bowtie -v 0  --norc --best --strata -a --threads 4 niben/niben ${i}"_26.fastq.gz" --al ${i}"-26nt-niben-aligned.fastq" -S ${i}"-26nt-niben-aligned.sam"
grep -c "^@" ${i}"-26nt-niben-aligned.fastq" >> num-26nt-niben-aligned.txt
bowtie -v 0  --norc --best --strata -a --threads 4 niben/niben ${i}"_27.fastq.gz" --al ${i}"-27nt-niben-aligned.fastq" -S ${i}"-27nt-niben-aligned.sam"
grep -c "^@" ${i}"-27nt-niben-aligned.fastq" >> num-27nt-niben-aligned.txt
bowtie -v 0  --norc --best --strata -a --threads 4 niben/niben ${i}"_28.fastq.gz" --al ${i}"-28nt-niben-aligned.fastq" -S ${i}"-28nt-niben-aligned.sam"
grep -c "^@" ${i}"-28nt-niben-aligned.fastq" >> num-28nt-niben-aligned.txt
done
echo "Completed analysis for whole run!!"
