#! /bin/bash      
#SBATCH	--account=MST113077                                                                                     
#SBATCH --job-name=QE_band
##---------------------------------------------------------------------------------------------------
#SBATCH	--partition=trans
##---------------------------------------------------------------------------------------------------
###number of tasks and node on each node and memory
##---------------------------------------------------------------------------------------------------
#SBATCH --cpus-per-task=5 --ntasks=10
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

export OMP_NUM_THREADS=1

if ! $(type module &>/dev/null) || [[ -z "$LMOD_CMD" ]]; then
    echo "The \`module' or lua mod command failed, pleae contact the administrator"
    exit
fi

cd $SLURM_SUBMIT_DIR
echo -e "you are acquiring the resoures\n$(cat $SLURM_JOB_NODELIST	)"

source ~/intel/oneapi/setvars.sh

# use this if you want the intel mpi, be default, we use impi
#module load impi/2018/QE/6.3

export PATH=/home/l26111201/qe_6.8/qe-6.8/bin:$PATH
echo -e "using MPI: mpiexec is \n$(type -p mpiexec)"
#np=$(cat $SLURM_JOB_NODELIST |wc -l)
name=V

cat > pw.$name.scf.in << EOF
 &CONTROL
    prefix='$name',
    pseudo_dir  = './',	
 /
 &SYSTEM    
    ibrav= -3,
    celldm(1)=5.671987,
    nat= 1,
    ntyp = 1,
    ecutwfc = 50.0,
    ecutrho = 700.0, 

    occupations='smearing',
    smearing='mp',
    degauss=0.02,
 /
 &ELECTRONS
 /
ATOMIC_SPECIES
  V 50.9415 V.pbe-spnl-kjpaw_psl.1.0.0.UPF
ATOMIC_POSITIONS (crystal)
   V  0.0000000000  0.0000000000  0.0000000000
K_POINTS {automatic}
   6 6 6 0 0 0
EOF
run="mpiexec pw.x -in pw.$name.scf.in > pw.$name.scf.out"  # type waht you mainly want to run here
eval $run 1> >(tee ${SLURM_JOBID}.${SLURM_JOBNAME}.out) 2> >(tee -a ${SLURM_JOBID}.${SLURM_JOBNAME}.out)



cat > pw.$name.bands.in << EOF
 &CONTROL
    calculation = 'bands'
    prefix='$name',
    pseudo_dir  = './',	
 /
 &SYSTEM    
    ibrav= -3,
    celldm(1)=5.671987,
    nat= 1,
    ntyp = 1,
    ecutwfc = 50.0,
    ecutrho = 700.0, 

    occupations='smearing',
    smearing='mp',
    degauss=0.02,
    nbnd = 30,
 /
 &ELECTRONS
 /
ATOMIC_SPECIES
  V 50.9415 V.pbe-spnl-kjpaw_psl.1.0.0.UPF
ATOMIC_POSITIONS (crystal)
   V  0.0000000000  0.0000000000  0.0000000000
# W-L-G-X-W   

K_POINTS {crystal_b}
8
     0.0000    0.0000    0.0000 90 !G
     0.5000   -0.5000    0.5000 90 !H
     0.0000    0.0000    0.5000 90 !N
     0.0000    0.0000    0.0000 90 !G
     0.2500    0.2500    0.2500 90 !P
     0.5000   -0.5000    0.5000 90 !H
     0.2500    0.2500    0.2500 90 !P
     0.0000    0.0000    0.5000  1 !N
EOF
run="mpiexec pw.x -in pw.$name.bands.in > pw.$name.bands.out"  # type waht you mainly want to run here
eval $run 1> >(tee ${SLURM_JOBID}.${SLURM_JOBNAME}.out) 2> >(tee -a ${SLURM_JOBID}.${SLURM_JOBNAME}.out)


cat > bands.$name.in << EOF
 &BANDS
    prefix='$name',
    filband = '$name.bands.dat'
    lsym = .true.,
 /

EOF
run="mpiexec bands.x < bands.$name.in > bands.$name.out"  # type waht you mainly want to run here
eval $run 1> >(tee ${SLURM_JOBID}.${SLURM_JOBNAME}.out) 2> >(tee -a ${SLURM_JOBID}.${SLURM_JOBNAME}.out)




