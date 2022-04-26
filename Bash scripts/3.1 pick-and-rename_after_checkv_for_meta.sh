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
	RESULT_DIR=/path_to_output_folder
	RAW_DATA=/path_to_folder_with_checkv_output

#create an output directory and moving to the folder with raw data
	mkdir $RESULT_DIR
	cd $RAW_DATA

#creates a string of names, by picking them from the folder name. Removes everything before Virsorterpred
for folder in Common_name*
do
	SUB_ID=${folder##}

#gives a new name for the file and copy it to output folder
	cp $folder/quality_summary* $RESULT_DIR/qs_${SUB_ID}.tsv

done

#created 2.3.22 by ED

