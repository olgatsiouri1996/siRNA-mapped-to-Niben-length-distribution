# list all .txt files 
file_list <- list.files(pattern=".txt",path= ".")
table_list <-lapply(file_list,read.delim,header=F)
# concatenate the files into 1 dataframe
result <- do.call(cbind, table_list)
# add column names
colnames(result) <- gsub(".txt","",file_list)
# load the dplyr library
library(dplyr)
# Summarize by group and sample type to merge both technical replicates into 1
summary_data <- result %>%
  group_by(groups) %>%
  summarise(
    len21_by_sample_sum = sum(`num-21nt-aligned`),
    len22_by_sample_sum = sum(`num-22nt-aligned`),
    len23_by_sample_sum = sum(`num-23nt-aligned`),
    len24_by_sample_sum = sum(`num-24nt-aligned`),
    len25_by_sample_sum = sum(`num-25nt-aligned`),
    len26_by_sample_sum = sum(`num-26nt-aligned`),
    len27_by_sample_sum = sum(`num-27nt-aligned`),
    len28_by_sample_sum = sum(`num-28nt-aligned`),
  )

# calculate the sum of reads per each biological condition(don't use the 1st column as it contains the group names, not numeric data)
summary_data$total_reads_by_sample_sum <- rowSums(summary_data[ ,-1])
# calculate the percentage of each siRNA classified by nt lenght
fi <- summary_data %>%
  mutate(
    across(c(2:9),
           .fns = ~./total_reads_by_sample_sum))
# remove the group and total_reads_by_sample_sum columns
fi <- fi[ ,2:9]
# load the tidyr library
library(tidyr)
# merge all rows with percentage of siRNA by nt into 1-column with the 2nd row under the 1st row etc(data added from left to right)
# "Original_Column" contains len21-28_by_sample_sum repeated per each unique element of groups(as in summary_data$groups)
df_long <- pivot_longer(fi, cols = everything(), names_to = "Original_Column", values_to = "Value")

library(ggplot2)

# create a dataframe to plot the data(convert len21_by_sample_sum to 21 etc)
df <- data.frame(
  group = gsub("len(\\d+)_by_sample_sum", "\\1", df_long$Original_Column),
  plant = rep(c(summary_data$groups), each = 8),
  value = df_long$Value
)

# Create a stacked barplot with ggplot2
plot <- ggplot(df, aes(x = plant, y = value, fill = factor(group))) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Total siRNA Length Distribution", x = "\n", y = "% of siRNA counts", fill = "siRNA Length") + scale_fill_manual(values = c("black","#003F5C","#665191","#A05195","#D45087","#F95D6A","#FF7C43","#FFA600"))

# Save the plot as a PDF
ggsave("siRNA_length_distribution.pdf", plot, width=8, height=6)
