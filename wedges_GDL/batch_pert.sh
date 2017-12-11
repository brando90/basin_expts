#!/bin/bash
#SBATCH --job-name=2D_potential
#SBATCH --nodes=1
#SBATCH --mem=2000
#SBATCH --time=0:01:00
#SBATCH --array=1-3

#alias matlab='/Applications/MATLAB_R2017a.app/bin/matlab -nodesktop -nosplash'
#SLURM_JOBID=0
#SLURM_ARRAY_TASK_ID=3

SLURM_JOBID=${SLURM_JOBID}
SLURM_ARRAY_TASK_ID=${SLURM_ARRAY_TASK_ID:-1}
print_hist=0
matlab -nodesktop -nosplash -nojvm -r "run_GDL_wedge_perturbations($SLURM_JOBID,$SLURM_ARRAY_TASK_ID,$print_hist)"