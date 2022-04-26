library(tidyverse)

#to create contig count file, after Virsorter2 -> CheckV -> quality status files -> pick-and-rename preprocessing=====
#Get file names. Change pattern with your own
pfam_dir="C:/Users/CheckV_preprossesed"
profiles <- sort(list.files(pfam_dir, pattern=".tsv", full.names = TRUE))

#create empty dataframe
all_data <- tibble(
  genome_name = character(),
  contig_id = character(),
  contig_length = numeric(),
  provirus = character(),
  proviral_length = numeric(),
  gene_count = numeric(),
  viral_genes = numeric(),
  host_genes = numeric(),
  checkv_quality = character(),
  miuvig_quality = character(),
  completeness = numeric(),
  completeness_method = character(),
  contamination = numeric(),
  kmer_freq = numeric(),
  warnings = character(),
)

#Change tsv to the common pattern. name parametr tasks name as the name of the file
for(f in profiles) {
  name <- unlist(strsplit(basename(f), ".tsv"))
  #mutating the name parameter as a column genome_name
  curr_profile <- read_tsv(f) %>% mutate(genome_name=name)
  
  if (dim(curr_profile)[1] != 0) {
    all_data <- add_row(all_data,curr_profile)
  }
}


all_data_final <- all_data %>% 
  separate(contig_id, sep="\\|\\|", into=c("viral_conting_name", "type_phage"))

all_data_final[c('roska_1','Family_ID','roska_2','bin')]<- str_split_fixed(all_data_final$genome_name, "_", n = 4)
all_data_final = subset(all_data_final, select = -c(roska_1, roska_2, genome_name))
all_data_final <- all_data_final %>% mutate(unique_viral_conting = paste(Family_ID, viral_conting_name, sep = "@"))

write_csv(all_data_final, "checkV.txt")

