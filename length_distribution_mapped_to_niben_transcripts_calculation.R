# list all .txt files 
file_list <- list.files(pattern=".txt",path= ".")
table_list <-lapply(file_list,read.delim,header=F)
# merge the files into 1 dataframe
result <- do.call(cbind, table_list)
# add column names
colnames(result) <- gsub(".txt","",file_list)

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

# calculate the sum of reads per each biological condition
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
# merge all columns with percentage of siRNA by nt into 1
df_long <- pivot_longer(fi, cols = everything(), names_to = "Original_Column", values_to = "Value")

library(ggplot2)

# create a dataframe to plot the data
df <- data.frame(
  group = rep(c(21, 22, 23, 24, 25, 26, 27, 28), times = 4),
  plant = rep(c("Plant 1 Leaf", "Plant 1 Root", "Plant 2 Leaf", "Plant 2 Root"), each = 8),
  value = df_long$Value
)

# Create a stacked barplot with ggplot2
plot <- ggplot(df, aes(x = plant, y = value, fill = factor(group))) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "Total siRNA Length Distribution", x = "\n", y = "% of siRNA counts", fill = "siRNA Length") + scale_fill_manual(values = c("black","#003F5C","#665191","#A05195","#D45087","#F95D6A","#FF7C43","#FFA600"))

# Save the plot as a PDF
ggsave("siRNA_length_distribution.pdf", plot, width=8, height=6)
