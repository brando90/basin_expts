clear;
%SLURM_JOBID = getenv('SLURM_JOBID')
%SLURM_ARRAY_TASK_ID = getenv('SLURM_ARRAY_TASK_ID')
hello = getenv('hello')
res = getenv('SYSTEMROOT')
PATH = getenv('PATH')