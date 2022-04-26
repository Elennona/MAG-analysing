#!/bin/bash -l
#SBATCH --job-name=checkV
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

#activate environment for checkv
conda activate checkv

#give the location of the database for checkv
export CHECKVDB="/path_to_checkv_database/checkv-db-v1.0"

#defying input and output folders
IN_DIR="/path_to_folder_with_preprocessed_virsoter_output_files"
OUT_DIR="/path_to_folder_with_checkv_output"

#Making an output directory and moving to input directory
mkdir $OUT_DIR
cd $IN_DIR

#Making a loop, that for each file that ends in .fa, creates a new directorynamed myout_dir, that will have a name as an .fa file without .fa
for f in *.fa
do 
	myout_dir=$OUT_DIR/${f%%.fa}


#-t: indicates number of threads/CPUs to be used; takes a new file inside IN_DIR, does a loop, and returns it to a specific folder
	checkv end_to_end $f $myout_dir -t 10
done

echo “job done”; date

#created 23.2.22 by ED and AP. Updated by ED 26.4.22