# list all .txt files 
file_list <- list.files(pattern=".txt",path= ".")
table_list <-lapply(file_list,read.delim,header=F)
result <- do.call(cbind, table_list)
library(dplyr)
colnames(result) <- gsub(".txt","",file_list)
# Summarize by group and sample type to merge both technical replicates into 1
summary_data <- result %>%
  group_by(groups) %>%
  summarise(
    len21_by_sample_sum = sum(`num-21nt-niben-aligned`),
    len22_by_sample_sum = sum(`num-22nt-niben-aligned`),
    len23_by_sample_sum = sum(`num-23nt-niben-aligned`),
    len24_by_sample_sum = sum(`num-24nt-niben-aligned`),
    len25_by_sample_sum = sum(`num-25nt-niben-aligned`),
    len26_by_sample_sum = sum(`num-26nt-niben-aligned`),
    len27_by_sample_sum = sum(`num-27nt-niben-aligned`),
    len28_by_sample_sum = sum(`num-28nt-niben-aligned`),
  )

# calculate the sum of reads per each biological condition
summary_data$total_reads_by_sample_sum <- rowSums(summary_data[ ,-1])
# calculate the percentage
fi <- summary_data %>%
  mutate(
    across(c(2:9),
           .fns = ~./total_reads_by_sample_sum))
# remove the group and total_reads_by_sample_sum columns
fi <- fi[ ,2:9]
# load the tidyr library
library(tidyr)
# merge all columns into 1
df_long <- pivot_longer(fi, cols = everything(), names_to = "Original_Column", values_to = "Value")

library(ggplot2)

# create a dataframe to plot the data
df <- data.frame(
  group = rep(c(21, 22, 23, 24, 25, 26, 27, 28), times = 4),
  plant = rep(c("Plant 1 Leaf", "Plant 1 Root", "Plant 2 Leaf", "Plant 2 Root"), each = 8),
  value = df_long$Value
)

# Create a stacked barplot with ggplot2
ggplot(df, aes(x = plant, y = value, fill = factor(group))) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "siRNA Length Distribution", x = "\n", y = "% of siRNA counts(21-28 nt)", fill = "Group") + scale_fill_manual(values = c("black","#003F5C","#665191","#A05195","#D45087","#F95D6A","#FF7C43","#FFA600"))
