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

 這個輸入檔案便是DFT中的
