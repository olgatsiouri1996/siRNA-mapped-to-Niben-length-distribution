This pipeline describes the collection,calculation and plotting of siRNA length distribution that map to the *Nicotiana benthamiana* transcriptome.
The *Nicotiana benthamiana* v2.6.1 transcriptome was downloaded from [solgenomics.net](https://solgenomics.net/ftp/genomes/Nicotiana_benthamianaV261/Nbenthamiana_Annotation/)
## Citation
When using this software cite the following:  
***(https://github.com/olgatsiouri1996/siRNA-mapped-to-Niben-length-distribution. Kellari et al., unpublished)***
## Publication
When using this software cite the following publication:  
***Kellari L., Dalakouras A., Tsiouri O., Vletsos P., Katsaouni A., Uslu V. V. and Papadopoulou K. K. Cross-kingdom RNAi induced by a beneficial endophytic fungus to its host requires transitivity and amplification of silencing signals (unpublished)***
## Dependences/Installation
1. docker
2. docker container used to retrieve the 21-28nt siRNA counts per samples:
```shell
docker pull olgatsiouri/sinra_21_28nt_length_calculator_all
```
3. docker container used to plot the data:
```shell
docker pull pegi3s/r_data-analysis
```
## Usage 
The sinra_21_28nt_length_calculator_all performs the following analysis:  
1). uses `bowtie-build` to build indexes of user specified fasta file   
2). runs `bowtie -v 0  --norc --best --strata -a` per each sample(samplenames specified in `list`)  
3). selects siRNAs with length 21-28 nt in 8 files per length  with `cutadapt` for each sample  
4). uses grep for each of the 21nt to 28nt  to calculate the number of reads per sample

The final result is 8 `.txt` files with a `num` prefix, 1 for each length, where each line is each sample in `list`
To run the whole pipeline run the following:
1. run the sinra_21_28nt_length_calculator_all container:
```shell
docker run -v /media/linuxubuntu2004/INTENSO/loukia/cleaned/dock/niben:/database -v /media/linuxubuntu2004/INTENSO/loukia/cleaned/dock:/input -v /media/linuxubuntu2004/INTENSO/loukia/cleaned/dock:/output -v /media/linuxubuntu2004/INTENSO/loukia/cleaned/dock:/list olgatsiouri/sinra_21_28nt_length_calculator_all niben 4

```
The format for linux and macos is:
```shell
docker run -v /path/to/database:/database -v /path/to/input:/input -v /path/to/output:/output -v /path/to/list:/list olgatsiouri/sinra_21_28nt_length_calculator_all database_name thread_count
```
The format for windows is:
```shell
docker run -v C:\path\to\database:/database -v C:\path\to\input:/input -v C:\path\to\output:/output -v C:\path\to\list:/list olgatsiouri/sinra_21_28nt_length_calculator_all database_name thread_count
```
where `/path/to/database` is the path to the folder containing the *Nicotiana benthamiana* transcriptome, `/path/to/input` is the path to the folder containing trimmed fastq.gz files to be mapped and `database_name` is the name of the indexed transcriptome files

2. Put the groups.txt and .R files on the same folder as the rest of the num*.txt files
3. Run the following to plot the results(in this example all txt files and the .R script are in the `/home/linuxubuntu2004/Desktop` folder): 
```shell
docker run --rm -it -v /home/linuxubuntu2004/Desktop:/data pegi3s/r_data-analysis Rscript /data/length_distribution_mapped_to_niben_transcripts_calculation.R
``` 
the group.txt file(that in this case contains 4 different conditions with 2 technical replicates each) can be modified for use in other projects
