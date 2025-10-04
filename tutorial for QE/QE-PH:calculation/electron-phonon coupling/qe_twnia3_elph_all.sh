#! /bin/bash      
#SBATCH	--account=MST                                                                                     
#SBATCH --job-name=QE_elph_all
##---------------------------------------------------------------------------------------------------
#SBATCH	--partition=ct224
##---------------------------------------------------------------------------------------------------
###number of tasks and node on each node and memory
##---------------------------------------------------------------------------------------------------
#SBATCH --cpus-per-task=16 --ntasks=10
##---------------------------------------------------------------------------------------------------
###Wall time limit(days-hrs:min:sec)
##---------------------------------------------------------------------------------------------------
#SBATCH --time=0-96:00:00
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
echo -e "you are acquiring the resoures\n$(cat $SLURM_JOB_NODELIST)"

source ~/intel/oneapi/setvars.sh


export PATH=/home/l26111201/qe_6.8/qe-6.8/bin:$PATH
echo -e "using MPI: mpiexec is \n$(type -p mpiexec)"
#np=$(cat $SLURM_JOB_NODELIST |wc -l)
calcul=scf
name=V

cat > pw.$name.$calcul-1.in << EOF
 &CONTROL
    calculation = '$calcul',
    prefix = '$name'
    outdir = './',
    pseudo_dir  = './',
    disk_io = 'low'
    wf_collect = .true.
 /

 &system
    ibrav= -3,
    celldm(1)=5.670829,
    nat= 1,
    ntyp = 1,
    ecutwfc = 100.0,
    ecutrho = 800.0, 
    la2F = .true.

    occupations =  'smearing',
    smearing    =  'mp',
    degauss     =  0.02,

 /
 &electrons
    conv_thr =  1.0d-8
    startingpot = 'file'
 /
ATOMIC_SPECIES
  V 50.9415 V.pbe-spn-rrkjus_psl.1.0.0.UPF
ATOMIC_POSITIONS (crystal)
   V  0.0000000000  0.0000000000  0.0000000000
K_POINTS {automatic}
   72 72 72  0  0  0
EOF
run="mpiexec pw.x -in pw.$name.$calcul-1.in > pw.$name.$calcul-1.out"  # type waht you mainly want to run here
eval $run 1> >(tee ${SLURM_JOBID}.${SLURM_JOBNAME}.out) 2> >(tee -a ${SLURM_JOBID}.${SLURM_JOBNAME}.out)

echo "scf-1 done"

cat > pw.$name.$calcul-2.in << EOF
 &CONTROL
    calculation = '$calcul',
    prefix = '$name'
    outdir = './',
    pseudo_dir  = './',
    disk_io = 'low'
    wf_collect = .true.
    tstress = .true.
    tprnfor = .true.
 /

 &system
    ibrav= -3,
    celldm(1)=5.670829,
    nat= 1,
    ntyp = 1,
    ecutwfc = 100.0,
    ecutrho = 800.0, 

    occupations =  'smearing',
    smearing    =  'mp',
    degauss     =  0.02,
 /
 &electrons
    conv_thr =  1.0d-10
    startingpot = 'file'
 /
ATOMIC_SPECIES
  V 50.9415 V.pbe-spn-rrkjus_psl.1.0.0.UPF
ATOMIC_POSITIONS (crystal)
  V  0.0000000000  0.0000000000  0.000000000
K_POINTS {automatic}
    18  18  18  0  0  0
EOF
run="mpiexec pw.x -in pw.$name.$calcul-2.in > pw.$name.$calcul-2.out"  # type waht you mainly want to run here
eval $run 1> >(tee -a ${SLURM_JOBID}.${SLURM_JOBNAME}.out) 2> >(tee -a ${SLURM_JOBID}.${SLURM_JOBNAME}.out)

echo "scf-2 done"

grep -A100 'Forces acting on atoms' pw.$name.$calcul-2.out > force.txt

cat > ph.$name.in << EOF
$name
 &inputph
  tr2_ph=1.0d-16,
  prefix='$name',
  outdir='./'
  fildyn='$name.dyn',
  ldisp = .true.
  trans = .true.
  fildvscf = 'dvscf'
  electron_phonon = 'interpolated'  
  amass(1) = 50.9415
  nq1      = 6
  nq2      = 6
  nq3      = 6
  el_ph_sigma =  0.002
  el_ph_nsigma=30,
  !verbosity   =  'high'
  alpha_mix(5)=0.1
  !start_q = 1
  !last_q = 1
/
EOF
run="mpiexec ph.x -in ph.$name.in > ph.$name.out"  # type waht you mainly want to run here
eval $run 1> >(tee -a ${SLURM_JOBID}.${SLURM_JOBNAME}.out) 2> >(tee -a ${SLURM_JOBID}.${SLURM_JOBNAME}.out)

echo "ph done"


cat > q2r.$name.in << EOF
 &input
  zasr='simple',  
  fildyn='$name.dyn', 
  flfrc='$name.fc', 
  la2F=.true.
 /
EOF
run="mpiexec q2r.x -in q2r.$name.in > q2r.$name.out"  # type waht you mainly want to run here
eval $run 1> >(tee -a ${SLURM_JOBID}.${SLURM_JOBNAME}.out) 2> >(tee -a ${SLURM_JOBID}.${SLURM_JOBNAME}.out)

echo "q2r done"

cat > matdyn.$name.in << EOF
 &input
    asr='simple', 
    flfrc='$name.fc', 
    flfrq='$name.freq', 
    amass(1) = 50.9415,
    q_in_band_form=.true.,
    q_in_cryst_coord=.true.	
    la2F=.true.,
    dos=.false.
 /
5
     0.0000    0.0000    0.0000 90 !G
     0.5000   -0.5000    0.5000 90 !H
     0.2500    0.2500    0.2500 90 !P
     0.0000    0.0000    0.0000 90 !G
     0.0000    0.0000    0.5000  1 !N
EOF
run="mpiexec matdyn.x -in matdyn.$name.in > matdyn.$name.out"  # type waht you mainly want to run here
eval $run 1> >(tee -a ${SLURM_JOBID}.${SLURM_JOBNAME}.out) 2> >(tee -a ${SLURM_JOBID}.${SLURM_JOBNAME}.out)


echo "matdyn done"

cat > matdyn.$name.in.dos << EOF
 &input
    asr='simple', 
    flfrc='$name.fc',
    amass(1) = 50.9415,
    la2F=.true.,
    dos=.ture.,
    fldos='$name.dos',
    nk1=120,
    nk2=120,
    nk3=120,
    ndos=200,
 /
EOF
run="mpiexec matdyn.x -in matdyn.$name.in.dos > matdyn.$name.out.dos"  # type waht you mainly want to run here
eval $run 1> >(tee -a ${SLURM_JOBID}.${SLURM_JOBNAME}.out) 2> >(tee -a ${SLURM_JOBID}.${SLURM_JOBNAME}.out)


echo "matdyn.dos done"


mkdir banddos
cp a2F.dos* ./banddos
cp $name.dos ./banddos
cp $name.freq ./banddos
cp lambda ./banddos
cp pw.$name.$calcul-1.out ./banddos
cp pw.$name.$calcul-2.out ./banddos
cp force.txt ./banddos
