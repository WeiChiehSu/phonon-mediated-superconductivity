# 電子態密度

本次計算的材料為Nb(unit-cell)的電子態密度,運行計算只需把pseudopotential:Nb.pbe-spn-kjpaw_psl.1.0.0.UPF和腳本:qe_pbspro_dos.sh放進已經安裝好QE的pbs系統機器,運行:

qsub qe_pbspro_dos.sh

稍等一段時間後,計算便完成了.

接下來將10Nb.dos和pw.10Nb.nscf.out放到具有qe_dos.m的資料夾中 運行qe_dos.m 便可得到Nb(unit-cell)的態密度:dos1.png

# QE腳本分析

腳本內總共創遭了三種輸入檔:pw.$name.scf.in pw.$name.nscf.in dos.$name.in 並進行了三次運算:

# 第1個輸入檔案為pw.$name.scf.in:

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

需要注意幾個必須要設置的參數:

1. prefix='$name':運行計算工作的名字

2. pseudo_dir  = './':pseudopotential:Nb.pbe-spn-kjpaw_psl.1.0.0.UPF讀取位置為當前目錄

3. ibrav= -3 celldm(1)=5.671987:定義晶格參數,詳情請看https://www.quantum-espresso.org/Doc/INPUT_PW.html

4. nat= 1:晶格內的原子數為1個

5. ntyp = 1:晶格內的原子種類為1種

6. ecutwfc = 50.0: 用來展開平面波基底的截斷能,截斷能越大,計算越精準,耗時也會加大

7. Nb 92.90638 Nb.pbe-spn-kjpaw_psl.1.0.0.UPF:原子種類 原子質量 原子pseudopotential

8. Nb  0.0000000000  0.0000000000  0.0000000000:原子名稱 該原子在晶格內的相對位置

9. 12 12 12 0 0 0 BZ內K空間三個維度的切點數(用來積化求和),切點數越大,計算越精準,耗時也會加大

運行scf計算的指令為:mpiexec pw.x -in pw.$name.scf.in > pw.$name.scf.out


# 第2個輸入檔案為pw.$name.bands.in:

 &CONTROL
 
    calculation = 'bands'
    
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
    
    nbnd = 30,
 /
 &ELECTRONS
 
 /
ATOMIC_SPECIES

  V 50.9415 V.pbe-spnl-kjpaw_psl.1.0.0.UPF
  
ATOMIC_POSITIONS (crystal)

   V  0.0000000000  0.0000000000  0.0000000000
   
K_POINTS {crystal_b}

8

     0.0000    0.0000    0.0000 90 !G
     
     0.5000   -0.5000    0.5000 90 !H
     
     0.0000    0.0000    0.5000 90 !N
     
     0.0000    0.0000    0.0000 90 !G
     
     0.2500    0.2500    0.2500 90 !P
     
     0.5000   -0.5000    0.5000 90 !H
     
     0.2500    0.2500    0.2500 90 !P
     
     0.0000    0.0000    0.5000  1 !N

這個輸入檔案的目的是讀取前面scf計算的電荷密度和波函數 用來計算材料的電子能帶,也就是系統的eigenvalue.

需要注意幾個必須要設置的參數:

1. calculation = 'bands':運行計算電子能帶

2. nbnd = 30:總共要計算幾條能帶 (可以在pw.V.scf.out找number of Kohn-Sham states=           11 進行參考)

3. K_POINTS {crystal_b}中的8:總共要計算幾個BZ內的高對稱點

4. 0.0000    0.0000    0.0000 90 !G:第一個要計算的高對稱點(Gamma點)座標和切點數(從G->H共切90點,因此最後一個高對稱點只切1點:總共切點數為90*7+1),切點數越多,最終畫出來的能帶越平滑,耗時也會加大

運行bands計算的指令為:mpiexec pw.x -in pw.$name.bands.in > pw.$name.bands.out

# 第3個輸入檔案為bands.$name.in:

 &BANDS
 
    prefix='$name',
    
    filband = '$name.bands.dat'
    
    lsym = .true.,
 /

這個輸入檔案的目的是讀取前面bands計算的eigenvalue,並輸出成可以讀取數值的檔案.

需要注意幾個必須要設置的參數:

1. filband = '$name.bands.dat':最終輸出可以讀取數值的檔案名:$name.bands.dat

2. lsym = .true.:數值輸出遵循bands計算設置的高對稱點座標和切點數

運行bands計算的指令為:mpiexec bands.x < bands.$name.in > bands.$name.out

便能得到材料的能帶數值檔案$name.bands.dat

# qe_band.m分析

V.bands.dat和pw.V.scf.out放到具有qe_band.m的資料夾中 運行qe_band.m 便可得到V(unit-cell)的電子能帶:band.png

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/QE-PH%3Acalculation/electron%20band/band.png)

qe_band.m需要注意幾個必須要設置的參數:

name = 'V'; -> 要讀取的bands.dat的前贅詞

material_name = 'V w/o soc'; -> 圖片band.png的title

high_symmetry_point_name = {'\Gamma','H','N','\Gamma','P','H','P','N','interpreter','LaTex'}; -> bands計算設置的高對稱點座標名稱

hs = 8; -> bands計算設置的高對稱點座標數量

ymin = -8; -> 繪圖的能量區間下限

ymax = 10; -> 繪圖的能量區間上限
