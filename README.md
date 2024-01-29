This pipeline describes the collection,calculation and plotting of siRNA length distribution that map to the *Nicotiana benthamiana* transcriptome
The Nicotiana benthamiana v2.6.1 transcriptome was downloaded from [solgenomics.net](https://solgenomics.net/ftp/genomes/Nicotiana_benthamianaV261/Nbenthamiana_Annotation/)

## Dependences/Installation
1. [wsl](https://learn.microsoft.com/en-us/windows/wsl/install) with ubuntu2004 running or any machine running ubuntu
2. cutadapt: 
```shell
sudo apt update -y
sudo apt install -y cutadapt
```
3. bowtie
```shell
sudo apt update -y
sudo apt install -y bowtie
```
5. [docker](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04)
6. docker container with R and data analysis packages:
```shell
docker pull pegi3s/r_data-analysis
```
## Usage 
1. Go to  `niben/` with `cd niben` and run `bowtie-build niben.fasta niben` to index the *Nicotiana benthamiana* mRNA file
2. Put the niben folder in the folder you have the quality trimmed fastq files
3. convert the map_to_transcriptome.sh script to executable: `chmod +x map_to_transcriptome.sh`
4. Run `./map_to_transcriptome.sh` to map to the *Nicotiana benthamiana* transcriptome and retrieve 21-28nt reads
5. Put the groups.txt and .R files on the same folder as the rest of the .txt files
6. Run the following to plot the results(in this example all txt files and the .R script are in the `/home/linuxubuntu2004/Desktop` folder): 
```shell
docker run --rm -it -v /home/linuxubuntu2004/Desktop:/data pegi3s/r_data-analysis Rscript /data length_distribution_mapped_to_niben_transcripts_calculation.R
``` 