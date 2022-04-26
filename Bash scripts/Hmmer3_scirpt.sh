#!/bin/bash -l
#SBATCH --job-name=hmmer3
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

#activate environment for hmmer3
conda activate hmmer

#defying input and output folders
IN_DIR="path_to_folder_with_prodigal_output"
OUT_DIR="/path_to_folder_with_hmmer_output"

#path to protein (KEGG / PVOG / IMGVR) database
DATABASE="/path_to_protein_database_in_profile_form.hmms"

#moving to input directory and creating an output directory
cd $IN_DIR
mkdir $OUT_DIR

#making a loop that removes VirSorterPred_ and .faa parts form input file and adds _annotated_prots.txt part 
for f in *.faa
do 
	OUT_FILE="$OUT_DIR/${f%%.faa}_annotated_prots.txt"


#tblout: makes output as a table
hmmscan --tblout $OUT_FILE $DATABASE $f

done

echo “job done”; date

#created 5.5.22, revised 9.3.22 by ED. 
