#!/bin/bash
#SBATCH --time=24:00:00 # maximum allocated time
#SBATCH --job-name=MOGP # name of the job
#SBATCH -p gpu-unlimited # which partition the job should be scheduled on
#SBATCH --output=./MOGP-%j.out
#SBATCH --error=./MOGP-%j.err
#SBATCH --gres=gpu:1
##SBATCH --nodes=4
##SBATCH --tasks-per-node=4
##SBATCH -w gpu[25,27,28,30]
##SBATCH -N 5
##SBATCH --mem=3000
##SBATCH -a 0-120%3

dt=$(date '+%d/%m/%Y %H:%M:%S');
echo $dt # debugging datetime print

printf "InnerValues $1 $2 $3 $4 $5 $6 $7 \n" # comment in for testing
python MOGP_Training.py $1 $2 $3 $4 $5 $6 $7
	
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo $dt # debugging datetime print