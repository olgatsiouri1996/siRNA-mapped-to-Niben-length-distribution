#!/bin/bash

# Check if custom name and thread count arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <custom_name> <thread_count>"
    exit 1
fi

custom_name=$1
thread_count=$2

# Index the reference sequence using bowtie-build
bowtie-build --threads ${thread_count} /database/${custom_name}.fasta /database/${custom_name}

for i in $(cat /list/list); do
    echo "Running bowtie and cutadapt for $i"
    
    # Map to the specified database directory with the custom name
    bowtie -v 0  --norc --best --strata -a --threads ${thread_count} /database/${custom_name} /input/${i}.fastq.gz --al /output/${i}-aligned.fastq  -S /output/${i}.sam
    
    # Collect 21-28 nt
    for j in {21..28}; do
        cutadapt -m $j -M $j -o /output/${i}_$j.fastq /output/${i}-aligned.fastq
        grep -c "^@" /output/${i}_$j.fastq >> /output/num-${j}nt-aligned.txt
    done
done

echo "Completed analysis for the entire run"
