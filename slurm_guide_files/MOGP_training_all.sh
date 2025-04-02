#!/bin/bash
#SBATCH --time=10:00:00 # maximum allocated time
#SBATCH --job-name=MOGP-allJobs # name of the job
#SBATCH --partition=gpu-12h # which partition the job should be scheduled on
#SBATCH --output=./MOGP-allJobs-%j.out
#SBATCH --error=./MOGP-allJobs-%j.err

n_inducing_points_arr=(64 128 256)
dim1_arr=(8 32 64 128 256)
batch_size_arr=(1000)
max_iter_arr=(10 100 500)
lr_arr=(1e-3 1e-2)
with_PCA_arr=(0)

dt=$(date '+%d/%m/%Y %H:%M:%S');
echo $dt # debugging datetime print

for i in {0..2} # 3 steps
do
	for j in {0..4} # 5 steps
	do
		for k in {0..0} # 1 steps
		do
			for x in {0..2} # 3 steps
			do
				for y in {0..1} # 2 steps
				do
					for z in {0..0} # 1 steps
					do
						n_inducing_points=${n_inducing_points_arr[i]}
    						dim1=${dim1_arr[j]}
    						dim2=${dim1_arr[j]}
    						batch_size=${batch_size_arr[k]}
    						max_iter=${max_iter_arr[x]}
    						lr=${lr_arr[y]}
    						with_PCA=${with_PCA_arr[z]}
						printf "python MOGP_Training.py $n_inducing_points $dim1 $dim2 $batch_size $max_iter $lr $with_PCA \n" # comment in for testing
    						sbatch MOGP_Training.sh $n_inducing_points $dim1 $dim2 $batch_size $max_iter $lr $with_PCA
						sleep 10
						dt=$(date '+%d/%m/%Y %H:%M:%S');
						echo $dt # debugging datetime print	
					done
				done
			done
		done
	done
done
	
	
dt=$(date '+%d/%m/%Y %H:%M:%S');
echo $dt # debugging datetime print