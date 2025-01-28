#!/bin/bash
#SBATCH --job-name=PaScal_job
#SBATCH --partition=amd-512
#SBATCH --output=results_pascal/PaScal_job%j.out
#SBATCH --error=results_pascal/PaScal_job%j.err
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=32
#SBATCH --time=0-0:10

pascalanalyzer -t aut -c 1,2,4,8,16,32,64,128 -i 50,100,150,200,250,275 -o result.json ./MLP
