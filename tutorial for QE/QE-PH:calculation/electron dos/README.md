# electron dos

本次計算的材料為Nb(unit-cell)的電子態密度,運行計算只需把pseudopotential:Nb.pbe-spn-kjpaw_psl.1.0.0.UPF和腳本:qe_pbspro_dos.sh放進已經安裝好QE的pbs系統機器,運行:

In this calculation, the electronic density of states of Nb (unit cell) is computed. To run the calculation, simply place the pseudopotential file Nb.pbe-spn-kjpaw_psl.1.0.0.UPF and the script qe_pbspro_dos.sh into a PBS-based machine where Quantum ESPRESSO (QE) has already been installed, and run:

qsub qe_pbspro_dos.sh

稍等一段時間後,計算便完成了.

After waiting for a short period of time, the calculation will be completed.

接下來將10Nb.dos和pw.10Nb.nscf.out放到具有qe_dos.m的資料夾中 運行qe_dos.m 便可得到Nb(unit-cell)的態密度:dos1.png

Next, place 10Nb.dos and pw.10Nb.nscf.out into the folder containing qe_dos.m. Run qe_dos.m to obtain the electronic density of states of Nb (unit cell): dos1.png

# Analysis of the Quantum ESPRESSO script

腳本內總共創遭了三種輸入檔:pw.$name.scf.in pw.$name.nscf.in dos.$name.in 並進行了三次運算:

The script generates three input files—pw.$name.scf.in, pw.$name.nscf.in, and dos.$name.in—and performs three corresponding calculations:

# The first input file is pw.$name.scf.in:

 &CONTROL
 
    prefix = '$name'
    
    outdir = './',
    
    pseudo_dir  = './',		
    
    !verbosity = 'high',	
    
 /
 &SYSTEM    
 
    ibrav= -3,
    
    celldm(1)=6.243473,
    
    nat= 1,
    
    ntyp = 1,
    
    ecutwfc = 50.0,
    
    ecutrho = 300.0, 

    occupations='smearing',
    
    smearing='mp',
    
    degauss=0.02,
    
 /
 &ELECTRONS
 
 /
ATOMIC_SPECIES

    Nb 92.90638 Nb.pbe-spn-kjpaw_psl.1.0.0.UPF
  
ATOMIC_POSITIONS (crystal)

    Nb  0.0000000000  0.0000000000  0.0000000000
  
K_POINTS (automatic)

    12 12 12 0 0 0

這個輸入檔案的目的便是DFT中的自洽運算(scf):

The purpose of this input file is to perform a self-consistent field (SCF) calculation :

 $$
\begin{aligned}
\text{1.Guess-charge-density:} \, n(r) \\
\Downarrow \\
\text{2.Poisson-eq:} \, \nabla^2 V_{\text{Hatree}}(r) = -4 \pi n(r) \\
\Downarrow \\
\text{3.KS-eq:} \left[ -\frac{\nabla^2 r}{2} + V_{\text{SCF}}(r) + V_{\text{Hatree}}(r) \right] \Psi(r) = \varepsilon \Psi(r) \\
\Downarrow \\
4.n_{\text{new}}(r) = \sum \left| \Psi(r) \right|^2 \\
\Downarrow \\
5.n(r) = n_{\text{new}}(r) \vee n(r) \neq n_{\text{new}}(r)
\end{aligned}
$$

透過自洽運算得到Nb(unit-cell)的電荷密度和波函數

within DFT to obtain the charge density and wavefunctions of Nb (unit cell).

需要注意幾個必須要設置的參數:

Several parameters must be set:

1. prefix='$name':運行計算工作的名字[the name of the calculation job]

3. pseudo_dir  = './':pseudopotential:Nb.pbe-spn-kjpaw_psl.1.0.0.UPF讀取位置,目前設置為當前目錄[the pseudopotential file Nb.pbe-spn-kjpaw_psl.1.0.0.UPF, which is currently read from the current directory]

4. ibrav= -3 celldm(1)=5.671987:定義晶格參數,詳情請看https://www.quantum-espresso.org/Doc/INPUT_PW.html)[the lattice parameters (for details, see: https://www.quantum-espresso.org/Doc/INPUT_PW.html]

5. nat= 1:晶格內的原子數為1個[the number of atoms in the unit cell: 1]

6. ntyp = 1:晶格內的原子種類為1種[the number of atomic species in the unit cell: 1]

7. ecutwfc = 50.0: 用來展開平面波基底的截斷能,截斷能越大,計算越精準,耗時也會加大[the plane-wave cutoff energy used to expand the basis set; a larger cutoff energy increases accuracy but also increases computational cost]

8. Nb 92.90638 Nb.pbe-spn-kjpaw_psl.1.0.0.UPF:原子種類 原子質量 原子pseudopotential[the atomic species, atomic mass, and atomic pseudopotential]

9. Nb  0.0000000000  0.0000000000  0.0000000000:原子名稱 該原子在晶格內的相對位置[the atomic name and its fractional position in the unit cell]

10. 12 12 12 0 0 0 BZ內K空間三個維度的切點數(用來積化求和),切點數越大,計算越精準,耗時也會加大[the number of k-point divisions along the three dimensions in the Brillouin zone (used for integration); a larger number of k-points increases accuracy but also increases computational cost]

運行scf計算的指令為:mpiexec pw.x -in pw.$name.scf.in > pw.$name.scf.out

The command to run the SCF calculation is:mpiexec pw.x -in pw.$name.scf.in > pw.$name.scf.out


# The second input file is pw.$name.nscf.in:

 &CONTROL
 
    calculation = 'nscf'
    
    prefix = '$name'
    
    outdir = './',
    
    pseudo_dir  = './',		
    
    verbosity = 'high',	
    
 /
 &SYSTEM    
 
    ibrav= -3,
    
    celldm(1)=6.243473,
    
    nat= 1,
    
    ntyp = 1,
    
    ecutwfc = 50.0,
    
    ecutrho = 300.0, 

    occupations='smearing',
    
    smearing='mp',
    
    degauss=0.02,
    
 /
 &ELECTRONS
 
 /
ATOMIC_SPECIES

     Nb 92.90638 Nb.pbe-spn-kjpaw_psl.1.0.0.UPF
  
ATOMIC_POSITIONS (crystal)

    Nb  0.0000000000  0.0000000000  0.0000000000
  
K_POINTS automatic

    72 72 72 0 0 0

這個輸入檔案的目的是讀取前面scf計算收斂的電荷密度和波函數,在新的且更密的K點網格上,計算系統的eigenvalue.

The purpose of this input file is to read the converged charge density and wavefunctions obtained from the previous SCF calculation and compute the eigenvalues on a new and denser k-point grid.

需要注意幾個必須要設置的參數:

Several parameters must be set:

1. calculation = 'nscf':運行計算非自洽計算)[set the calculation type to non-self-consistent field calculation (nscf)

4. 72 72 72 0 0 0:設置更密的K點網格,其切點數越多,最終畫出來的電子態密度越準確,耗時也會加大[define a denser k-point grid; a larger number of k-points results in a more accurate electronic density of states but increases computational cost]

運行nscf計算的指令為:mpiexec pw.x -in pw.$name.nscf.in > pw.$name.nscf.out

The command to run the NSCF calculation is:mpiexec pw.x -in pw.$name.nscf.in > pw.$name.nscf.out

# The third input file is dos.$name.in:

 &DOS
 
    prefix = '$name'
    
    outdir = './',
    
    fildos = '$name.dos'
    
    degauss = 0.012,
    
    DeltaE = 0.001
    
 /

這個輸入檔案的目的是讀取前面nscf計算的eigenvalue,統計出能量分佈並輸出成可以讀取數值的檔案.

The purpose of this input file is to read the eigenvalues obtained from the previous NSCF calculation, compute the energy distribution, and output the electronic density of states in a readable numerical file.

需要注意幾個必須要設置的參數:

Several parameters must be set:

1. fildos = '$name.dos':最終輸出可以讀取數值的檔案名:$name.dos[the output filename containing readable numerical data: $name.dos]

2. outdir = './',:前面nscf計算後的數據讀取位置,目前設置為當前目錄[the directory containing the NSCF calculation data, currently set to the current directory]

3. degauss = 0.012:控制積分平滑程度的參數,具體可以看(https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/introduction%20to%20The%20theory%20of%20First%20principle/4.Delta%20function%20Approxima.mdte%20method.md)[the smearing parameter that controls the integration smoothing (see:https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/introduction%20to%20The%20theory%20of%20First%20principle/4.Delta%20function%20Approxima.mdte%20method.md )

4. DeltaE = 0.001: 控制繪圖取樣間距的參數,能量軸上每隔0.001Ry取一個能量點，繪製電子態密度[the sampling interval for plotting: one energy point is sampled every 0.001 Ry along the energy axis to construct the electronic density of states]

運行bands計算的指令為:mpiexec dos.x < dos.$name.in > dos.$name.out

The command to run the DOS calculation is:mpiexec dos.x < dos.$name.in > dos.$name.out

便能得到材料的能帶數值檔案$name.dos

This produces the numerical density-of-states file: $name.dos

# Analysis of qe_dos.m:

$name.dos和pw.10Nb.nscf.out放到具有qe_dos.m的資料夾中 運行qe_dos.m 便可得到Nb(unit-cell)的電子能帶:dos1.png

Place $name.dos and pw.10Nb.nscf.out into the folder containing qe_dos.m.Run qe_dos.m to obtain the electronic density of states of Nb (unit cell): dos1.png.

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/QE-PH%3Acalculation/electron%20dos/dos1.png)

qe_band.m需要注意幾個必須要設置的參數:

Several parameters must be set in qe_dos.m:

name = '10Nb'; -> 要讀取的$name.dos的前贅詞[the prefix of the $name.dos file to be read]

material_name = 'Nb atomic layers(bulk)'; -> 圖片band.png的title[the title of the figure band.png]

natom = 1; -> 晶格內的原子數量[the number of atoms in the unit cell]

xmin = -1;    % energy range  -> 繪圖的x軸(能量區間)下限)[the lower bound of the x-axis (energy range)

xmax = 1;                     -> 繪圖的x軸(能量區間)上限[the upper bound of the x-axis (energy range)

ymin =  0;    % DOS range     -> 繪圖的y軸(電子密度強度)下限[the lower bound of the y-axis (density of states intensity)

ymax = 0.55;                  -> 繪圖的y軸(電子密度強度)上限[the upper bound of the y-axis (density of states intensity)
