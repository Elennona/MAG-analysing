#!/bin/bash -l
#SBATCH --job-name=picking_names
#SBATCH --account=project_12345
#SBATCH --output=output_%j.txt
#SBATCH --error=errors_%j.txt
#SBATCH --partition=small
#SBATCH --time=24:00:00
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=1000

#defying input and output folders
	RESULT_DIR=/path_to_folder_with_output
	RAW_DATA=/path_to_virsorter2_output

#create an output directory and moving to the folder with raw data
	mkdir $RESULT_DIR
	cd $RAW_DATA

#Coping the final-viral-combined.fa for every MAG from folder RAW_DATA to RESULT_DIR. While doing so we rename it: 1) putting the name of the folder from RAW_DATA as a viable = PART 2)then giving the final-viral-combined.fa a new name in .fa format

for folder in Perhe*
do
	PART=${folder}
	OUT_FILE="$RESULT_DIR/${PART}.fa"

	cp $folder/final-viral-combined.fa $OUT_FILE

done

#created 30.3.22 by ED

