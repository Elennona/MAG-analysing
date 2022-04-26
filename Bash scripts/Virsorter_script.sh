#!/bin/bash -l
#SBATCH --job-name=virsorter
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

#activate environment for virsorter2
conda activate virsorter2

#defying input and output folders
IN_DIR="/path_to_folder_with_MAGs"
OUT_DIR="/path_to_folder_with_virsorter_output"

#path to virsorter's database
DATABASE="/scratch/project_2004910/databases/virsorter_database_250322"

#making output directory and moving to input directory 
mkdir $OUT_DIR
cd $IN_DIR

#making a loop, that creates the output files. Each file will be named as the original file but without .fa
for f in *.fa
do 
	echo "processing $f"
	VS_OUT="$OUT_DIR/${f%%.fa}"
	
#-i: input; -w: wright; --min-length: sequences shorter than 1500bp won't be considered, all: run all steps for virsorter; -j: the threads 8/10 CPU will be used
virsorter run -w $VS_OUT -i $f --min-length 1500 -j 8 all

done

echo “job done”; date

#30.3.22 created by ED and AS, updated by ED 26.4.22
