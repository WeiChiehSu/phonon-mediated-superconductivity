#! /bin/bash      
#SBATCH	--account=114514                                                                                     
#SBATCH --job-name=1919810
##---------------------------------------------------------------------------------------------------
#SBATCH	--partition=MUR
##---------------------------------------------------------------------------------------------------
###number of tasks and node on each node and memory
##---------------------------------------------------------------------------------------------------
#SBATCH --cpus-per-task=10 --ntasks=5
##---------------------------------------------------------------------------------------------------
###Wall time limit(days-hrs:min:sec)
##---------------------------------------------------------------------------------------------------
#SBATCH --time=0-02:00:00
##---------------------------------------------------------------------------------------------------
###Path to the standard output files relative to the working directory
##---------------------------------------------------------------------------------------------------
#SBATCH --output=%j.out
##---------------------------------------------------------------------------------------------------
###PPath to the error files relative to the working directory
##---------------------------------------------------------------------------------------------------
#SBATCH --error=%j.cash
##---------------------------------------------------------------------------------------------------
cd $SLURM_SUBMIT_DIR
echo -e "you are acquiring the resoures\n$(cat $SLURM_JOB_NODELIST)"

source ~/intel/oneapi/setvars.sh

export PATH=/home/l26111201/qe_code/qe-6.8/bin:$PATH
echo -e "using MPI: mpiexec is \n$(type -p mpiexec)"
calcul=relax
name=114514
cat > pw.$name.$calcul.in << EOF
 &CONTROL
    calculation = '$calcul',
    prefix = '$name'
    outdir = './',
    pseudo_dir  = './',	
    etot_conv_thr = 1.0d-6,
    forc_conv_thr = 1.0d-4, 
 /

 &SYSTEM
    ibrav= 4,
    celldm(1)=9.200132,
    celldm(3)=5.093207,
    nat= 4,
    ntyp = 1,
    ecutwfc = 50.0,
    ecutrho = 500.0,

    occupations='smearing',
    smearing='mp',
    degauss=0.02,

 /

 &ELECTRONS
    conv_thr = 1.0d-12
 /
 &IONS
    upscale = 100.0
 /
 &CELL
    cell_factor = 3
    cell_dofree = '2Dxy'
 /
 
ATOMIC_SPECIES
  Sn 118.71 Sn.pbe-dn-kjpaw_psl.1.0.0.UPF
ATOMIC_POSITIONS (crystal)
  Sn  0.6666666866  0.3333333433  0.4021013081
  Sn  0.3333333433  0.6666666866  0.4390847981
  Sn  0.3333333433  0.6666666866  0.5609151721
  Sn  0.0000000000  0.0000000000  0.5978987217
K_POINTS {automatic}
  12 12 1 0 0 0
EOF
run="mpiexec pw.x -in pw.$name.$calcul.in > pw.$name.$calcul.out"  # type waht you want to run 
eval $run 1> >(tee ${SLURM_JOBID}.${SLURM_JOBNAME}.out) 2> >(tee -a ${SLURM_JOBID}.${SLURM_JOBNAME}.out)
