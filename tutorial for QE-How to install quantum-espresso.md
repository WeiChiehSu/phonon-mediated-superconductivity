We use quantum espresso 6.8 version to calculate material superconditivy.
After installing quantum espresso, we need to install oneapi to auxiliary operating software.

##########################################################################################################

# download oneapi

wget https://registrationcenter-download.intel.com/akdlm/irc_nas/18445/l_BaseKit_p_2022.1.1.119_offline.sh

wget https://registrationcenter-download.intel.com/akdlm/irc_nas/18438/l_HPCKit_p_2022.1.1.97_offline.sh

##########################################################################################################

# compile oneapi

sh ./l_BaseKit_p_2022.1.1.119_offline.sh

sh ./l_HPCKit_p_2022.1.1.97_offline.sh

###########################################################################################################

When we finish installing oneapi, we can start to install quantum espresso

###########################################################################################################

# download quantum espresso 6.8

wget https://github.com/QEF/q-e/releases/download/qe-6.8/qe-6.8-ReleasePack.tgz

###########################################################################################################

# compile quantum espresso 6.8 with oneapi

tar zxvf qe-6.8-ReleasePack.tgz

cd qe-6.8/

source ~/intel/oneapi/setvars.sh

./configure

make all

make epw

###########################################################################################################

when we finish installing quantum espresso 6.8, we need to add some keyword the script to run quantum espresso 6.8 with oneapi.

That is example for PBS system and SLURM system:

###########################################################################################################

# PBS scf script

cd $PBS_O_WORKDIR

echo -e "you are acquiring the resoures\n$(cat $PBS_NODEFILE)"

source ~/intel/oneapi/setvars.sh  # use oneapi

export PATH=/home/XXXXXXXXX/qe_code/qe-6.8/bin:$PATH  # the place of quantum espresso 6.8 which you install

echo -e "using MPI: mpiexec is \n$(type -p mpiexec)"

name=example

cat > pw.in << EOF
 &CONTROL 
    calculation = 'scf',    
    prefix = '$name'  
    outdir = './tmp',  
    pseudo_dir  = './',
    disk_io = 'low'
    
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

run="mpiexec pw.x -in pw.in > pw.out"  # type you  want to run here

eval $run 1> >(tee ${PBS_JOBID}.${PBS_JOBNAME}.out) 2> >(tee -a ${PBS_JOBID}.${PBS_JOBNAME}.out)

###########################################################################################################

# SLURM relax script

#! /bin/bash      

#SBATCH	--account=114514  

#SBATCH --job-name=RLEAX

##---------------------------------------------------------------------------------------------------

#SBATCH	--partition=1919810

##---------------------------------------------------------------------------------------------------

###number of tasks and node on each node and memory

##---------------------------------------------------------------------------------------------------

#SBATCH --cpus-per-task=1 --ntasks=20

##---------------------------------------------------------------------------------------------------

###Wall time limit(days-hrs:min:sec)

##---------------------------------------------------------------------------------------------------

#SBATCH --time=0-00:30:00

##---------------------------------------------------------------------------------------------------

###Path to the standard output files relative to the working directory

##---------------------------------------------------------------------------------------------------

#SBATCH --output=%j.out

##---------------------------------------------------------------------------------------------------

###Path to the error files relative to the working directory

##---------------------------------------------------------------------------------------------------

#SBATCH --error=%j.cash

##---------------------------------------------------------------------------------------------------

cd $SLURM_SUBMIT_DIR

echo -e "you are acquiring the resoures\n$(cat $SLURM_JOB_NODELIST)"

source ~/intel/oneapi/setvars.sh

export PATH=/home/l26111201/qe_code/qe-6.8/bin:$PATH

echo -e "using MPI: mpiexec is \n$(type -p mpiexec)"

calcul=relax

name=example

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

run="mpiexec pw.x -in pw.$name.$calcul.in > pw.$name.$calcul.out"  # type waht you  want to run 

eval $run 1> >(tee ${SLURM_JOBID}.${SLURM_JOBNAME}.out) 2> >(tee -a ${SLURM_JOBID}.${SLURM_JOBNAME}.out)


