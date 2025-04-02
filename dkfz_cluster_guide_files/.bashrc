
################################################################################
# Help                                                                         #
################################################################################
Help()
{
   # Display Help
   echo "This is the manual for .bashrc"
   echo
   echo "You have to give some arguments or otherwise your scipt might run unexpected"
   echo "options:"
   echo "--username           your DKFZ username, default: r807n"
   echo "--department_name    the name of your department, default: OE0601"
   echo "--exp_set            the name of your experiment set folder, default: exp_SET"
   echo "--exp_results        the name of your experiment results folder, default: exp_RESULTS"
   echo "--virtenv            the name of your virtual environment, default: selfsupervised, "
   echo
}

################################################################################
################################################################################
# Main program                                                                 #
################################################################################
################################################################################

# pass username, dataset location and virtualenv according to experiment

username=${username:-hekler}
department_name=${department_name:-OE0603}  #OE0601
exp_set=${exp_set:-exp_SET}
exp_results=${exp_results:-exp_RESULTS}
virtenv=${virtenv:-mmd} #scp

while getopts ":h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
   esac
done


while [ $# -gt 0 ]; do

   if [[ $1 == *"--"* ]]; then
        param="${1/--/}"
        declare $param="$2"
        # echo $1 $2 // Optional to see the parameter:value result
   fi

  shift
done

# change username, dataset location and virtualenv according to experiment

export PATH=/bin:$PATH
export OMP_NUM_THREADS=1 # needed to be able to run batchgenerators with new numpy versions. Use this!

module load python/3.7.0 # load python module. If you don't do this then you have no python

#source /odcf/cluster/virtualenvs/{USERNAME}/{YOUR_ENV}/bin/activate # activate my python virtual environment
# or, if you do not use a shared virtualenv:
# source /home/$username/envs/$virtenv/bin/activate  # commented out by conda initialize
# this part only makes sense if you have one virtual environment for all your experiments. If you have multiple, please see the runner script section below

CUDA=11.7 #11.0 #10.2 # or 11.0
export PATH=/usr/local/lib:$PATH
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=/usr/local/lib:$LIBRARY_PATH
export CPATH=/usr/local/lib:$CPATH
export PATH=/usr/local/cuda-${CUDA}/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-${CUDA}/lib64:$LD_LIBRARY_PATH
export CUDA_HOME=/usr/local/cuda-${CUDA}
export CUDA_CACHE_DISABLE=1

export DATASET_LOCATION=/gpu/data/$department_name/$username/$exp_set
export EXPERIMENT_LOCATION=/gpu/checkpoints/$department_name/$username/$exp_results

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/software/anaconda3/2021.05/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/software/anaconda3/2021.05/etc/profile.d/conda.sh" ]; then
        . "/software/anaconda3/2021.05/etc/profile.d/conda.sh"
    else
        export PATH="/software/anaconda3/2021.05/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

conda activate mmd
