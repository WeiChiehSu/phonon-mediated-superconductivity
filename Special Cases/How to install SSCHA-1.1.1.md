# download and compile Anaconda 

Anaconda website : https://www.taki.com.tw/blog/how-to-install-anaconda-on-ubuntu/?srsltid=AfmBOorCrHpUjb20gk407qZvZafDZAy59Ock60Q8p4iN7leKu6Xg2l3p

wget https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh

bash  Anaconda3-2024.02-1-Linux-x86_64.sh

# Enter a specific virtual ring

conda activate base 

or

conda activate /home/880212l26111201/anaconda3/envs/sscha/

source ~/.bashrc

# Exit a specific virtual ring

conda deactivate

# compile sscha 

conda create -n sscha -c conda-forge python=3.10 gfortran libblas lapack openmpi julia openmpi-mpicc pip numpy scipy spglib=2.2

conda activate sscha

conda install -c conda-forge ase=3.22.1 julia mpi4py

conda install -c conda-forge cellconstructor python-sscha tdscha

# the message indicating successful installation of SSCHA

pip show cellconstructor python-sscha tdscha

    (sscha) -bash-4.2$ pip show cellconstructor python-sscha tdscha
    Name: CellConstructor
    Version: 1.4.1
    Summary: Python utilities that is interfaced with ASE for atomic crystal analysis
    Home-page: https://github.com/mesonepigreco/CellConstructor
    Author: Lorenzo Monacelli
    Author-email:
    License: MIT
    Location: /home/880212l26111201/anaconda3/envs/sscha/lib/python3.10/site-packages
    Requires:
    Required-by: tdscha
    ---
    Name: python-sscha
    Version: 1.4.1
    Summary: Python implementation of the sscha code
    Home-page: https://github.com/mesonepigreco/python-sscha
    Author: Lorenzo Monacelli
    Author-email:
    License: GPLv3
    Location: /home/880212l26111201/anaconda3/envs/sscha/lib/python3.10/site-packages
    Requires:
    Required-by: tdscha
    ---
    Name: tdscha
    Version: 1.4.0
    Summary: Time Dependent Self Consistent Harmonic Approximation
    Home-page: https://github.com/SSCHAcode/tdscha
    Author: Lorenzo Monacelli
    Author-email:
    License: GPLv3
    Location: /home/880212l26111201/anaconda3/envs/sscha/lib/python3.10/site-packages
   Requires: ase, cellconstructor, numpy, python-sscha, scipy
    Required-by:

This means that SSCHA has been successfully installed.

# compile julia

pip install julia

cd anaconda3/

find . -type d -wholename "*/julia/packages"

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
(sscha) -bash-4.2$ find . -type d -wholename "*/julia/packages"
./anaconda3/envs/sscha/share/julia/packages
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

cd anaconda3/envs/sscha/share/julia/packages

git clone https://github.com/JuliaPy/PyCall.jl.git

julia

]

build Conda

using Pkg

Pkg.add(path="/home/880212l26111201/anaconda3/envs/sscha/share/julia/packages/PyCall.jl")

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

julia> using Pkg

julia> Pkg.add(path="/home/880212l26111201/anaconda3/envs/sscha/share/julia/packages/PyCall.jl")
     Cloning git-repo `/home/880212l26111201/anaconda3/envs/sscha/share/julia/packages/PyCall.jl`
    Updating git-repo `/home/880212l26111201/anaconda3/envs/sscha/share/julia/packages/PyCall.jl`
    Updating registry at `~/anaconda3/envs/sscha/share/julia/registries/General.toml`
   Resolving package versions...
    Updating `~/anaconda3/envs/sscha/share/julia/environments/sscha/Project.toml`
  [438e738f] ~ PyCall v1.96.4 ⇒ v1.96.4 `/home/880212l26111201/anaconda3/envs/sscha/share/julia/packages/PyCall.jl#master`
    Updating `~/anaconda3/envs/sscha/share/julia/environments/sscha/Manifest.toml`
  [438e738f] ~ PyCall v1.96.4 ⇒ v1.96.4 `/home/880212l26111201/anaconda3/envs/sscha/share/julia/packages/PyCall.jl#master`
    Building PyCall → `~/anaconda3/envs/sscha/share/julia/scratchspaces/44cfe95a-1eb2-52ea-b672-e2afdf69b78f/6ca471a8b5ec088665540d54ea93137d4f8f93f0/build.log`
Precompiling project...
  1 dependency successfully precompiled in 10 seconds. 9 already precompiled.


@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

add PyCall successfully

python -c 'import julia; julia.install()'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

To use this sscha, entering this environment 

conda activate sscha
