# 電子軌域投影能帶

本次計算的材料為4層 Rhombohedral Multilayer Graphene (ABCA堆疊)的電子軌域投影能帶,運行計算只需把pseudopotential:C.pbe-n-kjpaw_psl.1.0.0.UPF和腳本:qe_pband.sh放進已經安裝好QE的pbs系統機器,運行:

qsub qe_pband.sh

稍等一段時間後,計算便完成了.

接下來將$name.bands.dat,pw.$name.scf.out和projwfc.$name.out放到具有qe_band.m和qe_projected_band.m的資料夾中,先運行qe_band.m 得到4層 Rhombohedral Multilayer Graphene (ABCA堆疊)的能帶:band.png和band_data ,再運行qe_projected_band.m,會創建一個projected_band_all資料夾,裡面會有晶格內每顆原子每個軌域的投影強度圖

# QE腳本分析

腳本內總共創遭了四種輸入檔:pw.$name.scf.in pw.$name.bands.in projwfc.$name.in bands.$name.in 並進行了四次運算:

# 第1個輸入檔案為pw.$name.scf.in:

 &CONTROL
 
    prefix='$name',
    
    pseudo_dir  = './',	
    
 /
 &SYSTEM    
 
    ibrav= 4,
    
    celldm(1) = 4.64769327,
    
    celldm(3) = 12.18080231,
    
    nat= 8,
    
    ntyp= 1,
    
    ecutwfc = 80.0,
    
    ecutrho = 800.0,

    occupations='smearing',
    
    smearing='mp',
    
    degauss=0.02,
    
 /
 &ELECTRONS
 
 /
ATOMIC_SPECIES

    C 12.0107 C.pbe-n-kjpaw_psl.1.0.0.UPF
  
ATOMIC_POSITIONS (crystal)

    C   0.00000000   0.00000000   0.32395289 
 
    C   0.66666669   0.33333334   0.32398609 
 
    C   0.66666669   0.33333334   0.43452922 
 
    C   0.33333331   0.66666663   0.43459648 
 
    C   0.33333334   0.66666669   0.54501938 
 
    C  -0.00000000  -0.00000000   0.54508728 
 
    C   0.00000000   0.00000000   0.65529043 
 
    C   0.66666669   0.33333334   0.65532433 
K_POINTS (automatic)
    12 12 1 0 0 0

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

透過自洽運算得到V(unit-cell)的電荷密度和波函數

需要注意幾個必須要設置的參數:

1. prefix='$name':運行計算工作的名字

2. pseudo_dir  = './':pseudopotentialC.pbe-n-kjpaw_psl.1.0.0.UPF讀取位置為當前目錄

3. ibrav= 4, celldm(1) = 4.64769327,celldm(3) = 12.18080231:定義晶格參數,詳情請看https://www.quantum-espresso.org/Doc/INPUT_PW.html

4. nat= 1:晶格內的原子數為1個

5. ntyp = 1:晶格內的原子種類為1種

6. ecutwfc = 80.0: 用來展開平面波基底的截斷能,截斷能越大,計算越精準,耗時也會加大

7. C 12.0107 C.pbe-n-kjpaw_psl.1.0.0.UPF:原子種類 原子質量 原子pseudopotential

8. 12 12 1 0 0 0 BZ內K空間三個維度的切點數(用來積化求和),切點數越大,計算越精準,耗時也會加大(4層 Rhombohedral Multilayer Graphene為二維材料,z方向只需設1)

運行scf計算的指令為:mpiexec pw.x -in pw.$name.scf.in > pw.$name.scf.out


# 第2個輸入檔案為pw.$name.bands.in:

 &CONTROL
 
    calculation = 'bands'
    
    prefix='$name',
    
    pseudo_dir  = './',	
    
 /
 &SYSTEM    
 
    ibrav= 4,
    
    celldm(1) = 4.64769327,
    
    celldm(3) = 12.18080231,
    
    nat= 8,
    
    ntyp= 1,
    
    ecutwfc = 80.0,
    
    ecutrho = 800.0,

    occupations='smearing',
    
    smearing='mp',
    
    degauss=0.02,
    
    nbnd = 30,
    
 /
 &ELECTRONS
 
 /
ATOMIC_SPECIES

     C 12.0107 C.pbe-n-kjpaw_psl.1.0.0.UPF
  
ATOMIC_POSITIONS (crystal)

    C   0.00000000   0.00000000   0.32395289 
 
    C   0.66666669   0.33333334   0.32398609 
 
    C   0.66666669   0.33333334   0.43452922 
 
    C   0.33333331   0.66666663   0.43459648 
 
    C   0.33333334   0.66666669   0.54501938 
 
    C  -0.00000000  -0.00000000   0.54508728 
 
    C   0.00000000   0.00000000   0.65529043 
 
    C   0.66666669   0.33333334   0.65532433   

K_POINTS {crystal_b}

4

       0.0000    0.0000    0.0000 90 !G
     
       0.5000    0.0000    0.0000 90 !M
     
       0.3333    0.3333    0.0000 90 !K
       
       0.0000    0.0000    0.0000  0 !G

這個輸入檔案的目的是讀取前面scf計算的電荷密度和波函數 用來計算材料的電子能帶,也就是系統的eigenvalue.

需要注意幾個必須要設置的參數:

1. calculation = 'bands':運行計算電子能帶

2. nbnd = 30:總共要計算幾條能帶

3. K_POINTS {crystal_b}中的8:總共要計算幾個BZ內的高對稱點

4. 0.0000    0.0000    0.0000 90 !G:第一個要計算的高對稱點(Gamma點)座標和切點數(從G->H共切90點,因此最後一個高對稱點只切1點:總共切點數為90*3+1),切點數越多,最終畫出來的能帶越平滑,耗時也會加大

運行bands計算的指令為:mpiexec pw.x -in pw.$name.bands.in > pw.$name.bands.out

# 第3個輸入檔案為projwfc.$name.in:

 &projwfc
 
    outdir='./'
    
    prefix='$name'
    
    ngauss=1, 
    
    degauss=0.02, ! Ry
    
    DeltaE=0.01,
    
    kresolveddos=.true.,
    
    filpdos='$name.prijected.band',
 /

這個輸入檔案的目的是把原子軌域投影至能帶上,得到每個原子每個軌域的強度分布

運行projwfc計算的指令為:mpiexec projwfc.x < projwfc.$name.in > projwfc.$name.out

需要注意幾個必須要設置的參數:

1. outdir='./':輸出檔案projwfc.$name.out放置在當前目錄中

2. kresolveddos=.true.

# 第4個輸入檔案為bands.$name.in:

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

band_data,pw.4layers-graphene.scf.out和projwfc.4layers-graphene.out放到具有qe_projected_band.m的資料夾中 運行qe_projected_band.m,便可在projected_band_all資料夾內得到4層 Rhombohedral Multilayer Graphene (ABCA堆疊)的電子軌域投影能帶:X atom_ X.png

下圖為projected_band_all資料夾內的第1個原子P軌域的投影:1 atom_ p.png

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/QE-PH%3Acalculation/electron%20pband/projected_band_all/1%20atom_%20p.png)

可以看到P軌域的主要貢獻是在費米能級附近.

qe_projected_band.m需要注意幾個必須要設置的參數:

name = '4layers-graphene';

material_name = 'ABCA-4layers-graphene without soc';

high_symmetry_point_name = {'\Gamma','M','K','\Gamma','interpreter','LaTex'};

hs = 4;

name_compare = { 'C' };

%name_compare = { 'C' ; 'S' };

which_atom = [ 1:4]; % which atom to plot. when use name_compare, select 2 atom

ymin = -20;    % energy range [eV]

ymax = 13;

isSO = 0;    % 0 : w/o soc, 1 : spin polarized, 2 : w/ soc

name = 'V'; -> 要讀取的bands.dat的前贅詞

material_name = 'V w/o soc'; -> 圖片band.png的title

high_symmetry_point_name = {'\Gamma','H','N','\Gamma','P','H','P','N','interpreter','LaTex'}; -> bands計算設置的高對稱點座標名稱

hs = 8; -> bands計算設置的高對稱點座標數量

ymin = -8; -> 繪圖的能量區間下限

ymax = 10; -> 繪圖的能量區間上限

