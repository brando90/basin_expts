#!/bin/bash
#SBATCH --mem=20000
#SBATCH --time=7-00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=brando90@mit.edu

matlab -nodisplay -nodesktop -r "run /om/user/brando90/home_simulation_research/basin_expts/basin_GDL/GLD_basin_1D_0p45.m"
