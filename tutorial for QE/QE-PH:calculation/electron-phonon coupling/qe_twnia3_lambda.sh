#! /bin/bash      
#SBATCH	--account=MST                                                                                    
#SBATCH --job-name=QE_lambda
##---------------------------------------------------------------------------------------------------
#SBATCH	--partition=ctest
##---------------------------------------------------------------------------------------------------
###number of tasks and node on each node and memory
##---------------------------------------------------------------------------------------------------
#SBATCH --cpus-per-task=1 --ntasks=10
##---------------------------------------------------------------------------------------------------
###Wall time limit(days-hrs:min:sec)
##---------------------------------------------------------------------------------------------------
#SBATCH --time=0-00:30:00
##---------------------------------------------------------------------------------------------------
###Path to the standard output files relative to the working directory
##---------------------------------------------------------------------------------------------------
#SBATCH --output=%j.out
##---------------------------------------------------------------------------------------------------
###PPath to the error files relative to the working directory
##---------------------------------------------------------------------------------------------------
#SBATCH --error=%j.cash
##---------------------------------------------------------------------------------------------------

# PBSpro will set the thread of openMP to `ncpus', make it 1 in case you used the option         
# kind of -l select=1:ncpus=10, using this usually faster in VASP.
export OMP_NUM_THREADS=1

if ! $(type module &>/dev/null) || [[ -z "$LMOD_CMD" ]]; then
    echo "The \`module' or lua mod command failed, pleae contact the administrator"
    exit
fi

cd $SLURM_SUBMIT_DIR
echo -e "you are acquiring the resoures\n$(cat $SLURM_JOB_NODELIST)"




source ~/intel/oneapi/setvars.sh

# use this if you want the intel mpi, be default, we use impi
#module load impi/2018/QE/6.3

export PATH=/home/l26111201/qe_6.8/qe-6.8/bin:$PATH
echo -e "using MPI: mpiexec is \n$(type -p mpiexec)"
#np=$(cat $SLURM_JOB_NODELIST |wc -l)
name=V


cat > lambda.$name.in << EOF
10 0.1 1
   16
   0.000000000   0.000000000   0.000000000  1
   0.166666667   0.166666667   0.000000000 12
   0.333333333   0.333333333   0.000000000 12
  -0.500000000  -0.500000000   0.000000000  6
   0.333333333   0.166666667   0.166666667 24
   0.500000000   0.333333333   0.166666667 48
   0.666666667   0.333333333   0.333333333  8
   0.333333333   0.333333333   0.333333333  8
   0.500000000   0.500000000   0.333333333 12
   0.000000000   0.000000000   0.333333333  6
  -0.000000000  -0.166666667   0.500000000 24
  -1.000000000  -0.333333333  -0.333333333 12
  -0.833333333  -0.166666667  -0.333333333 24
  -0.000000000  -0.000000000   0.666666667  6
  -1.000000000  -0.166666667  -0.166666667 12
  -1.000000000  -1.000000000  -1.000000000  1
elph_dir/elph.inp_lambda.1
elph_dir/elph.inp_lambda.2
elph_dir/elph.inp_lambda.3
elph_dir/elph.inp_lambda.4
elph_dir/elph.inp_lambda.5
elph_dir/elph.inp_lambda.6
elph_dir/elph.inp_lambda.7
elph_dir/elph.inp_lambda.8
elph_dir/elph.inp_lambda.9
elph_dir/elph.inp_lambda.10
elph_dir/elph.inp_lambda.11
elph_dir/elph.inp_lambda.12
elph_dir/elph.inp_lambda.13
elph_dir/elph.inp_lambda.14
elph_dir/elph.inp_lambda.15
elph_dir/elph.inp_lambda.16
 0.3
EOF

run="mpiexec lambda.x  < lambda.$name.in > lambda.$name.out"  # type waht you mainly want to run here
eval $run 1> >(tee ${SLURM_JOBID}.${SLURM_JOBNAME}.out) 2> >(tee -a ${SLURM_JOBID}.${SLURM_JOBNAME}.out)


echo "lambda done"

mkdir banddos
cp lambda.$name.in ./banddos
cp lambda.$name.out ./banddos
