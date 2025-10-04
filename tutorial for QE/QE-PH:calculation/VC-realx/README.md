# 晶格結構放鬆

本次計算的材料為Al(fcc)的晶格結構放鬆,運行計算只需把pseudopotential:Al.pbe-n-kjpaw_psl.1.0.0.UPF和腳本:qencku_relax.sh放進已經安裝好QE的pbs系統機器,運行:

qsub qencku_relax.sh

稍等一段時間後,計算便完成了.

# QE腳本分析

腳本內總共創遭了一種輸入檔:pw.$name.vc-relax.in 並進行了三次運算:

# 輸入檔案為pw.$name.vc-relax.in:

cat > pw.$name.$calcul.in << EOF

 &CONTROL
 
    calculation = 'vc-relax',
    
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
這個輸入檔案的目的是進行DFT中的自洽運算(scf),得到結構的總能和受力,透過拉伸晶格常數和調整原子位置,進行多次自洽運算,去尋找能量最低的結構

需要注意幾個必須要設置的參數:

1. prefix='$name':運行計算工作的名字

2. calculation = 'vc-relax':結構放鬆時需要同時拉伸晶格常數和調整原子位置;若設置calculation = 'relax'則表示結構放鬆時只調整原子位置,不拉伸晶格常數

3. conv_thr = 1.0d-8:當scf計算的總能和上一次scf計算的總能能量差低於1.0d-8時,默認找到了能量最低結構,達成收斂,停止計算

4  etot_conv_thr = 1.0d-7:當scf計算的離子能和上一次scf計算的離子能能量差低於1.0d-7時,默認找到了能量最低結構,達成收斂,停止計算

5. forc_conv_thr = 1.0d-6:當scf計算的原子力和上一次scf計算的原子力力差低於1.0d-6時,默認找到了能量最低結構,達成收斂,停止計算

6. outdir = './':輸出檔案pw.$name.vc-relax.out的存放位置

運行scf計算的指令為:mpiexec pw.x -in pw.$name.vc-relax.in > pw.$name.vc-relax.out

計算完後,會得到pw.$name.vc-relax.out檔案,使用(https://www.densityflow.com/en/pwout.php)的功能,便能得到能量最低的結構
