#!/bin/bash
#SBATCH --mem=80000
#SBATCH --time=7-00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=brando90@mit.edu

matlab -nodisplay -nodesktop -r "run GLD_basin_5D_0p45.m"
