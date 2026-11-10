# SSCHA Installation and Modified Quantum ESPRESSO — Bilingual Notes

本文件根據原本的安裝紀錄整理，保留曾經使用的套件版本與指令，並在每個步驟後加入簡單英文說明。

This file follows my original installation notes. It keeps the package versions and commands, with simple English explanations.

> **注意 / Note**

這是舊環境的安裝紀錄，不保證在目前所有 Linux 系統上都能直接執行。筆記標題雖寫有 SSCHA 1.1.1，但實際安裝紀錄顯示 `python-sscha` 版本為 1.4.1。

This is a record from an older system. It may not work on every current Linux system. Although the old title says SSCHA 1.1.1, the package record shows `python-sscha` version 1.4.1.

## 1. Install Anaconda（安裝 Anaconda）

首先下載原本使用的 Anaconda 安裝程式，再執行安裝。

First, download the Anaconda installer used in the original setup. Then run it.

```bash
wget https://repo.anaconda.com/archive/Anaconda3-2024.02-1-Linux-x86_64.sh
bash Anaconda3-2024.02-1-Linux-x86_64.sh
```

安裝完成後，可以使用 `conda activate` 進入環境。若終端機尚未讀取設定，可重新讀取 `~/.bashrc`。

After installation, use `conda activate` to enter an environment. If needed, reload `~/.bashrc`.

```bash
source ~/.bashrc
conda activate base
```

原始紀錄也用完整路徑進入特定環境，但該路徑是原本帳號專用，不能直接照抄到其他電腦。

The original notes also activate an environment by its full path. That path belongs to the old user account and must be changed on another computer.

```bash
conda activate /home/880212l26111201/anaconda3/envs/sscha/
```

使用 `conda deactivate` 可以離開目前環境。

Use `conda deactivate` to leave the current environment.

```bash
conda deactivate
```

## 2. Create the SSCHA Environment（建立 SSCHA 環境）

原始筆記使用 Python 3.10，並同時安裝編譯器、線性代數函式庫、MPI、Julia 與相關 Python 套件。

The original setup uses Python 3.10. It also installs compilers, math libraries, MPI, Julia, and related Python packages.

```bash
conda create -n sscha -c conda-forge python=3.10 gfortran libblas lapack openmpi julia openmpi-mpicc pip numpy scipy spglib=2.2
conda activate sscha
```

接著安裝原子模擬套件與平行計算介面。

Next, install the atomic simulation package and the parallel computing interface.

```bash
conda install -c conda-forge ase=3.22.1 julia mpi4py
```

然後安裝 SSCHA 所需的三個主要套件。

Then install the three main SSCHA packages.

```bash
conda install -c conda-forge cellconstructor python-sscha tdscha
```

可以使用 `pip show` 檢查實際安裝的套件版本。

Use `pip show` to check the installed package versions.

```bash
pip show cellconstructor python-sscha tdscha
```

原始紀錄中的版本為 `CellConstructor 1.4.1`、`python-sscha 1.4.1` 和 `tdscha 1.4.0`。

The original record shows `CellConstructor 1.4.1`, `python-sscha 1.4.1`, and `tdscha 1.4.0`.

## 3. Julia and PyCall Setup（設定 Julia 與 PyCall）

原始安裝紀錄另外安裝 Python 的 Julia 介面，並在 Julia 環境中編譯 PyCall。這是原本環境的額外設定，不代表每一次 SSCHA 安裝都必須手動執行。

The original setup also installs the Python–Julia interface and builds PyCall in Julia. This is an extra step from that system. It may not be needed in every SSCHA installation.

```bash
pip install julia
```

原始筆記先搜尋 Julia 套件目錄，然後將 PyCall 原始碼下載到該目錄。

The old notes first find the Julia packages folder. Then they clone the PyCall source into that folder.

```bash
cd anaconda3/
find . -type d -wholename "*/julia/packages"
# Example path recorded in the old system:
# ./anaconda3/envs/sscha/share/julia/packages
cd anaconda3/envs/sscha/share/julia/packages
git clone https://github.com/JuliaPy/PyCall.jl.git
```

請注意，上面的 `cd` 順序取自原始筆記；若你的工作目錄不同，請先確認路徑，避免重複進入 `anaconda3` 目錄。

The `cd` commands above come from the old notes. Check your current folder first. Do not enter the wrong directory by mistake.

接著進入 Julia，使用套件管理器將下載的 PyCall 加入環境。原始紀錄使用了絕對路徑。

Next, open Julia and use its package manager to add the downloaded PyCall. The old notes use an absolute path.

```julia
julia
# Run inside the Julia prompt:
using Pkg
Pkg.add(path="/home/880212l26111201/anaconda3/envs/sscha/share/julia/packages/PyCall.jl")
```

完成後回到 Shell，原始紀錄執行了下列 Python–Julia 設定命令。

After that, return to the shell. The original setup runs this Python–Julia configuration command.

```bash
python -c 'import julia; julia.install()'
```

## 4. Install Intel oneAPI for the Modified QE Build（安裝編譯修改版 QE 所需的 Intel 工具）

原始筆記使用 Intel oneAPI 2022 的離線安裝程式，提供 Fortran、C 與 MPI 編譯環境。

The original notes use the Intel oneAPI 2022 offline installers for Fortran, C, and MPI.

```bash
wget https://registrationcenter-download.intel.com/akdlm/irc_nas/18445/l_BaseKit_p_2022.1.1.119_offline.sh
sh ./l_BaseKit_p_2022.1.1.119_offline.sh
wget https://registrationcenter-download.intel.com/akdlm/irc_nas/18438/l_HPCKit_p_2022.1.1.97_offline.sh
sh ./l_HPCKit_p_2022.1.1.97_offline.sh
```

這些是歷史版本的下載位置。舊連結可能已失效，且部分舊編譯器可能不包含在新版工具包中。

These are old download links. They may no longer work, and newer toolkits may not include the same old compilers.

## 5. Build the Modified QE 5.1.0（編譯修改版 QE 5.1.0）

下載原始教程使用的修改版 Quantum ESPRESSO 5.1.0。

Download the modified Quantum ESPRESSO 5.1.0 used in the tutorial.

```bash
git clone https://github.com/SSCHAcode/qe-5.1.0_elph.git
cd qe-5.1.0_elph
```

載入 Intel oneAPI 環境，再使用原始筆記中的 Intel 編譯器與數學函式庫設定。

Load the Intel oneAPI environment. Then configure the build with the compilers and math libraries from the original notes.

```bash
source ~/intel/oneapi/setvars.sh

./configure \
F90=ifort \
F77=ifort \
MPIF90=mpiifort \
CC=icc \
BLAS_LIBS="-lmkl_intel_lp64  -lmkl_sequential -lmkl_core" \
SCALAPACK_LIBS="-lmkl_scalapack_lp64 -lmkl_blacs_intelmpi_lp64" \
FFT_LIBS="-lmkl_intel_lp64 -lmkl_sequential -lmkl_core"
```

最後執行編譯命令。這只是原始紀錄中的操作，是否編譯成功仍需依實際輸出確認。

Finally, run the build command. This is the command from the original notes. Check the actual output to confirm that the build succeeds.

```bash
make all
```

## 6. Check the Installation（檢查安裝結果）

原始筆記沒有提供完整的安裝驗證測試，因此無法僅根據這份紀錄保證所有工具正常運作。

The original notes do not include a full verification test. This record alone cannot prove that every tool works.

可以先檢查 Python 套件是否能匯入，並確認修改版 QE 的執行檔是否存在。這是額外建議的檢查步驟，不是原筆記中的已完成測試。

You can check whether Python imports work and whether the modified QE executables exist. These are suggested checks, not tests confirmed by the original notes.

```bash
python -c "import cellconstructor, sscha; print('SSCHA imports OK')"
ls -l bin/pw.x bin/ph.x
```

## 7. Version and Environment Notes（版本與環境提醒）

這份記錄包含 Anaconda 2024.02、Python 3.10、SSCHA 相關套件 1.4.x、Intel oneAPI 2022，以及修改版 QE 5.1.0。

This record uses Anaconda 2024.02, Python 3.10, SSCHA packages 1.4.x, Intel oneAPI 2022, and modified QE 5.1.0.

它適合保留為當時可參考的研究環境紀錄。若要重新安裝，應先確認套件相依性、作業系統版本、編譯器與 MPI 是否相容。

This is useful as a record of the old research setup. For a new installation, first check package, operating-system, compiler, and MPI compatibility.
