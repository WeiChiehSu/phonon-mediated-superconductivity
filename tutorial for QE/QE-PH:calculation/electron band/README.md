# 電子能帶

本次計算的材料為V(unit-cell)的電子能帶,運行計算只需把pseudopotential:V.pbe-spnl-kjpaw_psl.1.0.0.UPF和腳本:qe_twnia3_pbspropwtk.sh放進已經安裝好QE的slurm系統機器,運行:

sbatch qe_twnia3_pbspropwtk.sh

稍等一段時間後,計算便完成了.

接下來將V.bands.dat放到具有qe_band.m的資料夾中 運行qe_band.m 便可得到V(unit-cell)的電子能帶:band.png

# QE腳本分析

腳本內總共創遭了三種輸入檔:pw.$name.scf.in pw.$name.bands.in bands.$name.in 並進行了三次運算:

第一個輸入檔案為pw.$name.scf.in:

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

 這個輸入檔案便是DFT中的自洽運算:

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

透過自洽運算得到V(unit-cell)的電荷密度和波函數
