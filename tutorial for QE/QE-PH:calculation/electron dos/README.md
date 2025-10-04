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

2. pseudo_dir  = './':pseudopotential:Nb.pbe-spn-kjpaw_psl.1.0.0.UPF讀取位置,目前設置為當前目錄

3. ibrav= -3 celldm(1)=5.671987:定義晶格參數,詳情請看https://www.quantum-espresso.org/Doc/INPUT_PW.html

4. nat= 1:晶格內的原子數為1個

5. ntyp = 1:晶格內的原子種類為1種

6. ecutwfc = 50.0: 用來展開平面波基底的截斷能,截斷能越大,計算越精準,耗時也會加大

7. Nb 92.90638 Nb.pbe-spn-kjpaw_psl.1.0.0.UPF:原子種類 原子質量 原子pseudopotential

8. Nb  0.0000000000  0.0000000000  0.0000000000:原子名稱 該原子在晶格內的相對位置

9. 12 12 12 0 0 0 BZ內K空間三個維度的切點數(用來積化求和),切點數越大,計算越精準,耗時也會加大

運行scf計算的指令為:mpiexec pw.x -in pw.$name.scf.in > pw.$name.scf.out


# 第2個輸入檔案為pw.$name.nscf.in:

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

需要注意幾個必須要設置的參數:

1. calculation = 'nscf':運行計算非自洽計算

4. 72 72 72 0 0 0:設置更密的K點網格,其切點數越多,最終畫出來的電子態密度越準確,耗時也會加大

運行nscf計算的指令為:mpiexec pw.x -in pw.$name.nscf.in > pw.$name.nscf.out

# 第3個輸入檔案為dos.$name.in:

 &DOS
 
    prefix = '$name'
    
    outdir = './',
    
    fildos = '$name.dos'
    
    degauss = 0.012,
    
    DeltaE = 0.001
    
 /

這個輸入檔案的目的是讀取前面nscf計算的eigenvalue,統計出能量分佈並輸出成可以讀取數值的檔案.

需要注意幾個必須要設置的參數:

1. fildos = '$name.dos':最終輸出可以讀取數值的檔案名:$name.dos

2. outdir = './',:前面nscf計算後的數據讀取位置,目前設置為當前目錄

3. degauss = 0.012:控制積分平滑程度的參數,具體可以看(https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/introduction%20to%20The%20theory%20of%20First%20principle/4.Delta%20function%20Approxima.mdte%20method.md)

4. DeltaE = 0.001: 控制繪圖取樣間距的參數,能量軸上每隔0.001Ry取一個能量點，繪製電子態密度

運行bands計算的指令為:mpiexec dos.x < dos.$name.in > dos.$name.out

便能得到材料的能帶數值檔案$name.dos

# qe_band.m分析

$name.dos和pw.10Nb.nscf.out放到具有qe_dos.m的資料夾中 運行qe_dos.m 便可得到Nb(unit-cell)的電子能帶:dos1.png

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/QE-PH%3Acalculation/electron%20dos/dos1.png)

qe_band.m需要注意幾個必須要設置的參數:

name = 'V'; -> 要讀取的bands.dat的前贅詞

material_name = 'V w/o soc'; -> 圖片band.png的title

high_symmetry_point_name = {'\Gamma','H','N','\Gamma','P','H','P','N','interpreter','LaTex'}; -> bands計算設置的高對稱點座標名稱

hs = 8; -> bands計算設置的高對稱點座標數量

ymin = -8; -> 繪圖的能量區間下限

ymax = 10; -> 繪圖的能量區間上限
