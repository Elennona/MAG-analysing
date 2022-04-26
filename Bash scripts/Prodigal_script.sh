#!/bin/bash -l
#SBATCH --job-name=prodigal
#SBATCH --account=project_12345
#SBATCH --output=output_%j.txt
#SBATCH --error=errors_%j.txt
#SBATCH --partition=small
#SBATCH --time=72:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=1000

echo "job started"; hostname; date

#activate environment for prodigal. Prodigal only for prokaryotes and prokaryotes viruses
conda activate prodigal

#defying input and output folders
IN_DIR="/path_to_virsorter2_output_files"
OUT_DIR="/path_to_prodigal_output"

#makinf an output directory and moving to input directory
mkdir $OUT_DIR
cd $IN_DIR

#Creating viables. For each file that ends in .fa in input directory, three outputs will be created. gff - tab delimited file for genes summary aka coordinates for genes, faa - tab file for amino acids for predicted proteins, fna - tab nucleotide fasta
for f in *.fa
do 
	prodigal_OUT="$OUT_DIR/${f%%.fa}.gff"
	prodigal_FAA="$OUT_DIR/${f%%.fa}.faa"
	prodigal_FNA="$OUT_DIR/${f%%.fa}.fna"	


#-p: metagenome partial genes are ok; -a: amino acid output; -d: nucleotide output; -i: input files; -o: output files. Prodigal will take your dna sequence form fasta file and predict what genes it has and then translates those to possible proteins. 
prodigal -a $prodigal_FAA -d $prodigal_FNA -i $f -o $prodigal_OUT -p meta

#-p normal if it is a complete genome 

done

echo “job done”; date

#created 2.3.22, revised 2.3.22 by ED
