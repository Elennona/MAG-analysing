library(dplyr)
library(tidyverse)
library(stringr)

#prepossessing data for R analysis. This will change the txt files permanently. Done for 3 databases: Pvog, Imgvr and Kegg

#PVOG DATABASE ####

#This script results and print out a filtered table to be used in R analysis

#folder where the imgvr output files in .txt format can be found
pfam_dir="C:/Users/Pvog_infant_MAG"
#0.1% prosent or below can be found by chance in the metagenome
cutoff_pfam=0.001

#makes a character vector of the names of files in the folder
list.files(pfam_dir)
profiles <- sort(list.files(pfam_dir, pattern="_annotated_prots.txt", full.names = TRUE))

columns=c("annotated protein", "accession", "cds_ID", "stuff2", "E_value", "score","bias", 
          "E-value2", "score2", "bias2","exp","reg","clu","ov","env","dom","rep","inc", "stuff3")
#build a dataframe
all_data <- tibble(
  "annotated protein" = character(),
  "accession"= character(),
  "cds_ID"= character(),
  "E_value"= numeric(),
  "score"= numeric(),
  "bias"= numeric(),
  "E-value2"= numeric(),
  "score2"= numeric(),
  "bias2"= numeric(),
  "exp"= numeric(),
  "reg"= numeric(),
  "clu"= numeric(),
  "ov"= numeric(),
  "env"= numeric(),
  "dom"= numeric(),
  "rep"= numeric(),
  "inc"= numeric(),
  "Family_ID" = character()
)

for(f in profiles) {
  # read profile + select read counts and taxID
  name <- sapply(strsplit(basename(f), "_annotated_prots.txt"), `[`, 1)
  currdataset <- readr::read_table(f, col_names=columns, comment = "#")
  
  # remove white spaces everywhere ()
  corr_all_datasets<- currdataset %>% select(-stuff2,-stuff3) %>% mutate_if(is.character, str_trim)
  corr_all_datasets$E_value <- as.numeric(corr_all_datasets$E_value)
  
  # get the min evalue hit only for each
  min_evalue<- corr_all_datasets %>% group_by(cds_ID) %>% slice_min(E_value, with_ties = FALSE)
  
  # filter by a cutoff e-value
  cutoff_data<- min_evalue %>% filter(as.numeric(E_value)<=cutoff_pfam)
  nb_of_pfam_cutoff<-cutoff_data%>% select(cds_ID)%>% unique()
  
  # print selected filtered hits
  file_name <- paste(name,"_annotated_prots.txt", sep="")
  file_dir <- paste(pfam_dir, file_name, sep="/")
  write.csv(cutoff_data, file_dir, row.names=FALSE)
  
  #copying family codes from file name to a column, mutate create or change a column
  cutoff_data <- cutoff_data %>% mutate(Family_ID=name)
  
  all_data <- all_data %>% add_row(cutoff_data)
  
}

write_csv(all_data, "Protein_annotation_pvog_infant_MAG.txt")


#Imgvr DATABASE ####

#This script results and print out a filtered table to be used in R analysis

#folder where the imgvr output files in .txt format can be found
pfam_dir="C:/Users/Imgvr_infant_MAG"
#0.1% percent or below can be found by chance in the metagenome
cutoff_pfam=0.001

#makes a character vector of the names of files in the folder
list.files(pfam_dir)
#to put in alpha order
profiles <- sort(list.files(pfam_dir, pattern="_annotated_prots.txt", full.names = TRUE))

columns=c("annotated protein", "accession", "cds_ID", "stuff2", "E_value", "score","bias", 
          "E-value2", "score2", "bias2","exp","reg","clu","ov","env","dom","rep","inc", "stuff3")
#build a dataframe
all_data <- tibble(
  "annotated protein" = character(),
  "accession"= character(),
  "cds_ID"= character(),
  "E_value"= numeric(),
  "score"= numeric(),
  "bias"= numeric(),
  "E-value2"= numeric(),
  "score2"= numeric(),
  "bias2"= numeric(),
  "exp"= numeric(),
  "reg"= numeric(),
  "clu"= numeric(),
  "ov"= numeric(),
  "env"= numeric(),
  "dom"= numeric(),
  "rep"= numeric(),
  "inc"= numeric(),
  "Family_ID" = character()
)

for(f in profiles) {
  # read profile + select read counts and taxID, basename(f) - removes a path before a file.txt
  name <- sapply(strsplit(basename(f), "_annotated_prots.txt"), `[`, 1)
  currdataset <- readr::read_table(f, col_names=columns, comment = "#")
  
  # remove white spaces everywhere ()
  corr_all_datasets<- currdataset %>% select(-stuff2,-stuff3) %>% mutate_if(is.character, str_trim)
  corr_all_datasets$E_value <- as.numeric(corr_all_datasets$E_value)
  
  # get the min evalue hit only for each
  min_evalue<- corr_all_datasets %>% group_by(cds_ID) %>% slice_min(E_value, with_ties = FALSE)
  
  # filter by a cutoff e-value
  cutoff_data<- min_evalue %>% filter(as.numeric(E_value)<=cutoff_pfam)
  nb_of_pfam_cutoff<-cutoff_data%>% select(cds_ID)%>% unique()
  
  # print selected filtered hits
  file_name <- paste(name,"_annotated_prots.txt", sep="")
  file_dir <- paste(pfam_dir, file_name, sep="/")
  write.csv(cutoff_data, file_dir, row.names=FALSE)
  
  
  #copying family codes from file name to a column, mutate create or change a column
  cutoff_data <- cutoff_data %>% mutate(Family_ID=name)
  
  
  all_data <- all_data %>% add_row(cutoff_data)
  
}

write_csv(all_data, "Protein_annotation_imgvr_infant_MAG.txt")

#KEGG DATABASE ####

#This script results and print out a filtered table to be used in R analysis

#folder where the imgvr output files in .txt format can be found
pfam_dir="C:/Users/Kegg_infant_MAG"
#0.1% precent or below can be found by chance in the metagenome
cutoff_pfam=0.001

#makes a character vector of the names of files in the folder
list.files(pfam_dir)
profiles <- sort(list.files(pfam_dir, pattern="_annotated_prots.txt", full.names = TRUE))

columns=c("kegg_prot_code", "accession", "cds_ID", "stuff2", "E_value", "score","bias", 
          "E-value2", "score2", "bias2","exp","reg","clu","ov","env","dom","rep","inc", "stuff3")
#build a dataframe
all_data <- tibble(
  "kegg_prot_code" = character(),
  "accession"= character(),
  "cds_ID"= character(),
  "E_value"= numeric(),
  "score"= numeric(),
  "bias"= numeric(),
  "E-value2"= numeric(),
  "score2"= numeric(),
  "bias2"= numeric(),
  "exp"= numeric(),
  "reg"= numeric(),
  "clu"= numeric(),
  "ov"= numeric(),
  "env"= numeric(),
  "dom"= numeric(),
  "rep"= numeric(),
  "inc"= numeric(),
  "Family_ID" = character()
)

for(f in profiles) {
  # read profile + select read counts and taxID
  name <- sapply(strsplit(basename(f), "_annotated_prots.txt"), `[`, 1)
  currdataset <- readr::read_table(f, col_names=columns, comment = "#")
  
  # remove white spaces everywhere ()
  corr_all_datasets<- currdataset %>% select(-stuff2,-stuff3) %>% mutate_if(is.character, str_trim)
  corr_all_datasets$E_value <- as.numeric(corr_all_datasets$E_value)
  
  # get the min evalue hit only for each
  min_evalue<- corr_all_datasets %>% group_by(cds_ID) %>% slice_min(E_value, with_ties = FALSE)
  
  # filter by a cutoff e-value
  cutoff_data<- min_evalue %>% filter(as.numeric(E_value)<=cutoff_pfam)
  nb_of_pfam_cutoff<-cutoff_data%>% select(cds_ID)%>% unique()
  
  # print selected filtered hits
  file_name <- paste(name,"_annotated_prots.txt", sep="")
  file_dir <- paste(pfam_dir, file_name, sep="/")
  write.csv(cutoff_data, file_dir, row.names=FALSE)
  
  #copying family codes from file name to a column, mutate create or change a column
  cutoff_data <- cutoff_data %>% mutate(Family_ID=name)
  
  all_data <- all_data %>% add_row(cutoff_data)
  
}

write_csv(all_data, "Protein_annotation_KEGG_infant_MAG.txt")











