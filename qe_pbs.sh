#! /bin/bash                                                                                           
#PBS -N scf
#PBS -l select=4:ncpus=1:mem=5gb
#PBS -l place=pack:group=switch
##---------------------------------------------------------------------------------------------------
cd $PBS_O_WORKDIR
echo -e "you are acquiring the resoures\n$(cat $PBS_NODEFILE)"

source ~/intel/oneapi/setvars.sh

export PATH=/home/XXXXXXXXXX/qe-6.8/qe-6.8/bin:$PATH
echo -e "using MPI: mpiexec is \n$(type -p mpiexec)"
#np=$(cat $PBS_NODEFILE |wc -l)
calcul=scf
name=114514

cat > pw.in << EOF
 &CONTROL
    calculation = '$calcul',
    prefix = '$name'
    outdir = './tmp',
    pseudo_dir  = './',
    disk_io = 'low'
    wf_collect = .true.
 /

 &system
    ibrav= 4,
    celldm(1)=9.164794,
    celldm(3)=5.112845,
    nat= 4,
    ntyp = 1,
    ecutwfc = 50.0,
    ecutrho = 500.0,

    occupations =  'smearing',
    smearing    =  'mp',
    degauss     =  0.02,
 /
 &electrons
    conv_thr =  1.0d-15
    startingpot = 'file'
 /
ATOMIC_SPECIES
  Sn 118.71 Sn_ONCV_PBE_FR-1.1.upf
ATOMIC_POSITIONS (crystal)
  Sn  0.6666667461  0.3333334625  0.4051318467
  Sn  0.3333334923  0.6666669846  0.4390676916
  Sn  0.3333334923  0.6666669846  0.5609322786
  Sn  0.0000000000  0.0000000000  0.5948681831
K_POINTS (automatic)
   12 12 1 0 0 0
EOF
run="mpiexec pw.x -in pw.in > pw.out"  # type waht you  want to run 
eval $run 1> >(tee ${PBS_JOBID}.${PBS_JOBNAME}.out) 2> >(tee -a ${PBS_JOBID}.${PBS_JOBNAME}.out)
