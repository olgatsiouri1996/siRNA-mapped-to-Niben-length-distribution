This pipeline describes the collection,calculation and plotting of siRNA length distribution that map to the *Nicotiana benthamiana* transcriptome
The Nicotiana benthamiana v2.6.1 transcriptome was downloaded from [solgenomics.net](https://solgenomics.net/ftp/genomes/Nicotiana_benthamianaV261/Nbenthamiana_Annotation/)

## Dependences 
1. wsl1 with ubuntu2004 running
2. cutadapt v2.8
3. bowtie v1.2.3
4. grep v3.4
5. R sessionInfo():
```R
R version 4.3.0 (2023-04-21 ucrt)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows 10 x64 (build 19045)

Matrix products: default


locale:
[1] LC_COLLATE=English_United Kingdom.utf8  LC_CTYPE=English_United Kingdom.utf8   
[3] LC_MONETARY=English_United Kingdom.utf8 LC_NUMERIC=C                           
[5] LC_TIME=English_United Kingdom.utf8    

time zone: Europe/Athens
tzcode source: internal

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] ggplot2_3.4.2 tidyr_1.3.0   dplyr_1.1.2  

loaded via a namespace (and not attached):
 [1] labeling_0.4.2   utf8_1.2.3       R6_2.5.1         tidyselect_1.2.0 farver_2.1.1     magrittr_2.0.3  
 [7] gtable_0.3.3     glue_1.6.2       tibble_3.2.1     pkgconfig_2.0.3  generics_0.1.3   lifecycle_1.0.3 
[13] cli_3.6.1        fansi_1.0.4      scales_1.2.1     grid_4.3.0       vctrs_0.6.2      withr_2.5.0     
[19] compiler_4.3.0   purrr_1.0.1      rstudioapi_0.14  tools_4.3.0      munsell_0.5.0    pillar_1.9.0    
[25] colorspace_2.1-0 rlang_1.1.1
```  
## Usage 
1. Go to  `niben/` with `cd niben` and run `bowtie-build niben.fasta niben` to index the *Nicotiana benthamiana* mRNA file
2. Put the niben folder in the folder you have the quality trimmed fastq files
3. Run the  `map_to_transcriptome.sh` to map to the *Nicotiana benthamiana* transcriptome and retrieve 21-28nt reads
4. Put the groups.txt file on the same folder as the rest of the .txt files
3. Run `length_distribution_mapped_to_niben_transcripts_calculation.R` in Rstudio to plot the results