#!/bin/bash
#SBATCH --job-name=PaScal_job
#SBATCH --partition=amd-512
#SBATCH --output=PaScal_job%j.out
#SBATCH --error=PaScal_job%j.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=32
#SBATCH --time=0-0:10

pascalanalyzer -t aut -c 1,2,4,8,16,32 -i 500,707,1000,1414,2000 -o result.json ./MLP
