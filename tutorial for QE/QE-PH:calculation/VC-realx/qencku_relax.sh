#! /bin/bash                                                                                           
#PBS -N elph-scf
#PBS -q workq
##---------------------------------------------------------------------------------------------------
## -l select=<# of chunks>[:<ncpus=#>], how many chunks. ncpus, how many cpus for each chunk.
## chunks is the set of resources allocated, typically, there is one chunk per MPI process.
## recommend select=2:ncpus=1 for 2-rank MPI job, select=1:ncpus=2 for 2-threads openMP job.
## select=<...>:cpu=9960 or cpu=7720 for request the i9-9960X CPU nodes or zen2 7702 CPU nodes.
##---------------------------------------------------------------------------------------------------
#PBS -l select=16:ncpus=1:host=trnckun07
##---------------------------------------------------------------------------------------------------
## -l place= <type>[:<sharing>][:<group>]
## place the chunks on which way.
## vnodes is a virtual node, a abstract object representing a sub set of resources of a machine(host).
###     free,     on any vnode(s)
###     pack,     all chunks will be taken from one host
###     scatter,  only one chunk is taken from any host(means try to distribute your MPI rank to nodes)
###     vscatter, only one chunk is taken from any vnode(same as above but to vnodes)
## recommned place=pack for avoiding the hosts-crossing jobs
## place=pack:excl(exclhost) for exclusively using the vnode(node)
## a placement set will try to allocate the node for the jobs best,
## example: <...>:group=switch will arrange the vnodes(or nodes) for jobs at the same switch if possible
##---------------------------------------------------------------------------------------------------
#PBS -l place=pack
##---------------------------------------------------------------------------------------------------

export OMP_NUM_THREADS=1

#if ! $(type module &>/dev/null) || [[ -z "$LMOD_CMD" ]]; then
#    echo "The \`module' or lua mod command failed, pleae contact the administrator"
#    exit
#fi

cd $PBS_O_WORKDIR
echo -e "you are acquiring the resoures\n$(cat $PBS_NODEFILE)"

source ~/intel/oneapi/setvars.sh


export PATH=/home/880212l26111201/qe_code/qe-7.1/bin:$PATH
echo -e "using MPI: mpiexec is \n$(type -p mpiexec)"
#np=$(cat $PBS_NODEFILE |wc -l)
calcul=vc-relax
name=al_bulk
cat > pw.$name.$calcul.in << EOF
 &CONTROL
    calculation = '$calcul',
    prefix = '$name'
    outdir = './',
    pseudo_dir  = './',		
    !verbosity = 'high',
    etot_conv_thr = 1.0d-7,
    forc_conv_thr = 1.0d-6,
    nstep = 200		
 /

 &SYSTEM
    ibrav= 1,
    celldm(1)=7.632471,
    nat= 4,
    ntyp= 1,
    ecutwfc = 40.0,
    ecutrho = 400.0, 

    occupations='smearing',
    smearing='mp',
    degauss=0.02,

 /

 &ELECTRONS
    conv_thr = 1.0d-8
 /
 &IONS
    upscale = 100.0
 /
 &CELL
    cell_factor = 3
 /
ATOMIC_SPECIES
  Al 26.98154 Al.pbe-n-kjpaw_psl.1.0.0.UPF
ATOMIC_POSITIONS (crystal)
  Al  0.0000000000  0.0000000000  0.0000000000
  Al  0.5000000000  0.5000000000  0.0000000000
  Al  0.5000000000  0.0000000000  0.5000000000
  Al  0.0000000000  0.5000000000  0.5000000000
K_POINTS {automatic}
   12 12 12 0 0 0
EOF
run="mpiexec pw.x -in pw.$name.$calcul.in > pw.$name.$calcul.out"  # type waht you mainly want to run here
eval $run 1> >(tee ${PBS_JOBID}.${PBS_JOBNAME}.out) 2> >(tee -a ${PBS_JOBID}.${PBS_JOBNAME}.out)

wait
awk '/Program PWSCF/,/Writing/{print $0} /Begin final coordinates/,/JOB DONE./{print $0}' pw.$name.$calcul.out > relax.reduced.txt

echo "$calcul done"

