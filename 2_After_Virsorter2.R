library(tidyverse)

#to combine Virsorter2 output prepossessed files into one table
pfam_dir="C:/Users/Virsorter_preprossessed"
profiles <- sort(list.files(pfam_dir, pattern=".txt", full.names = TRUE))

#create empty data frame
all_data <- tibble(
  genome_name=character(),
  seqname = character(),
  dsDNAphage = numeric(),
  ssDNA = numeric(),
  max_score = numeric(),
  max_score_group = character(),
  length = numeric(),
  hallmark = numeric(),
  viral = numeric(),
  cellular = numeric(),
)

#Change txt to the common pattern. name parameter tasks name as the name of the file
for(f in profiles) {
  name <- unlist(strsplit(basename(f), ".txt"))
  #mutating the name parameter as a column genome_name
  curr_profile <- read_tsv(f) %>% mutate(genome_name=name)
  
  if (dim(curr_profile)[1] != 0) {
    all_data <- add_row(all_data,curr_profile)
  }
}

#error may happen if the viral contigs were not found in bacterial metagenomes, there will be empty files.

all_data_final <- all_data %>% 
  separate(seqname, sep="\\|\\|", into=c("viral_conting_name", "type_phage"))

all_data_final[c('Family_ID','sample_type','bin_name_cat','roska_1')]<- str_split_fixed(all_data_final$genome_name, "_", n = 4)
all_data_final = subset(all_data_final, select = -roska_1)
all_data_final <- all_data_final %>% mutate(unique_viral_conting = paste(Family_ID, viral_conting_name, sep = "@"))
all_data_final <- all_data_final %>% mutate(bin_name = paste(Family_ID, bin_name_cat, sep = "_"))

write_csv(all_data_final, "VirSorter2_contings.txt")


