#!/bin/bash
#SBATCH --job-name=Hello_World_Worker
#SBATCH --nodes=1
#SBATCH --mem=1000
#SBATCH --time=1:00:00
#SBATCH --array=1-10

alias matlab='/Applications/MATLAB_R2017a.app/bin/matlab -nodesktop -nosplash'

#SLURM_JOBID=${SLURM_JOBID}
#SLURM_ARRAY_TASK_ID=${SLURM_ARRAY_TASK_ID:-1}
SLURM_JOBID=0
SLURM_ARRAY_TASK_ID=3
print_hist=0
matlab -nodesktop -nosplash -nojvm -r "run_GDL_wedge_perturbations($SLURM_JOBID,$SLURM_ARRAY_TASK_ID,$print_hist)"