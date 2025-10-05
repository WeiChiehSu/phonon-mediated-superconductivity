# 聲子譜,聲子態密度,Eliashberg譜函數和超導轉變溫度

本次計算的材料為V(unit-cell)的聲子譜,聲子態密度,Eliashberg譜函數和超導轉變溫度,運行計算只需把pseudopotential:V.pbe-spnl-kjpaw_psl.1.0.0.UPF和腳本:qe_twnia3_elph_all.sh和qe_twnia3_lambda.sh放進已經安裝好QE的slurm系統機器,先運行:

sbatch qe_twnia3_elph_all.sh

先等很長一段時間,確認qe_twnia3_elph_all.sh的計算任務完成後,再運行:

sbatch qe_twnia3_lambda.sh

稍等一段時間後,整個計算便完成了.

接下來將banddos資料夾下載下來,再將qephonon.m,qephonondos.m,qea2fdos.m和Tclambda.m放置到banddos資料夾中 運行 qephonon.m,qephonondos.m,qea2fdos.m和Tclambda.m,便可得到V(unit-cell)的聲子譜,聲子態密度,Eliashberg譜函數和超導轉變溫度

# QE腳本分析

腳本內總共創遭了7種輸入檔:pw.$name.scf-1.in pw.$name.scf-2.in ph.$name.in q2r.$name.in matdyn.$name.in matdyn.$name.in.dos lambda.$name.in 並進行了7次運算:

# 第1個輸入檔案為pw.$name.scf-1.in:

 &CONTROL
 
    calculation = 'scf',
    
    prefix = '$name'
    
    outdir = './',
    
    pseudo_dir  = './',
    
    disk_io = 'low'
    
    wf_collect = .true.
    
 /

 &system
 
    ibrav= -3,
    
    celldm(1)=5.670829,
    
    nat= 1,
    
    ntyp = 1,
    
    ecutwfc = 100.0,
    
    ecutrho = 800.0, 
    
    la2F = .true.

    occupations =  'smearing',
    
    smearing    =  'mp',
    
    degauss     =  0.02,

 /
 
 &electrons
 
    conv_thr =  1.0d-8
    
    startingpot = 'file'
    
 /
 
ATOMIC_SPECIES

      V 50.9415 V.pbe-spn-rrkjus_psl.1.0.0.UPF
  
ATOMIC_POSITIONS (crystal)

      V  0.0000000000  0.0000000000  0.0000000000
   
K_POINTS {automatic}

      72 72 72  0  0  0

$$
這個輸入檔案的目的是透過較密的k點密度進行自洽運算(scf)得到材料的費米能級和準備計算電聲耦合係數(broadening法)中雙重\delta積分近似的能量採樣區間:
$$

$$
I\simeq \frac{\Omega _{BZ}^{2} }{N_{K} N_{q}} \sum_{k}^{} \sum_{q}^{}  \frac{1}{\sqrt{2\pi \sigma } }e^{-\frac{(\epsilon _{k}-\epsilon _{F})^{2}   }{\sigma ^{2} } } \frac{1}{\sqrt{2\pi \sigma } }e^{-\frac{(\epsilon _{k^{'}}-\epsilon _{F})^{2}   }{\sigma ^{2} } }   
$$

類似於費米-狄拉克分布:

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/introduction%20to%20The%20theory%20of%20First%20principle/degauss.png)

$$
\sigma(degauss)便是控制費米-狄拉克分布參數平緩或陡峭的參數:\sigma值越小,費米-狄拉克分布越陡峭;,\sigma值越大,費米-狄拉克分布越平緩
$$

k點網格平均切割成的區間,可以當成k(0.8-1.2)的範圍:k點網格切點值越疏,範圍越大;k點網格切點值越密,範圍越小

進行pw.$name.scf-1.in有幾個要點:

   1. 必須設置:la2F = .true.,表示計算電聲耦合!

   2. K_POINTS設置的切點密度(72*72*72)須為第二步K_POINTS設置和第三步q點設置的整數倍,否則計算電聲耦合係數時,將無法進行插值!

運行scf計算的指令為:mpiexec pw.x -in pw.$name.$calcul-1.in > pw.$name.$calcul-1.out

# 第2個輸入檔案為pw.$name.scf-2.in:

 &CONTROL
 
    calculation = '$calcul',
    
    prefix = '$name'
    
    outdir = './',
    
    pseudo_dir  = './',
    
    disk_io = 'low'
    
    wf_collect = .true.
    
    tstress = .true.
    
    tprnfor = .true.
    
 /

 &system
 
    ibrav= -3,
    
    celldm(1)=5.670829,
    
    nat= 1,
    
    ntyp = 1,
    
    ecutwfc = 100.0,
    
    ecutrho = 800.0, 

    occupations =  'smearing',
    
    smearing    =  'mp',
    
    degauss     =  0.02,
    
 /
 
 &electrons
 
    conv_thr =  1.0d-10
    
    startingpot = 'file'
    
 /
 
ATOMIC_SPECIES

     V 50.9415 V.pbe-spn-rrkjus_psl.1.0.0.UPF
  
ATOMIC_POSITIONS (crystal)

     V  0.0000000000  0.0000000000  0.000000000
  
K_POINTS {automatic}

       18  18  18  0  0  0

這個輸入檔案的目的是透過一次較疏k點密度進行自洽運算(scf):

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

得到下一步用來算DFPT的電荷密度和波函數!

進行pw.$name.scf-2.in有幾個要點:

   1. 不設置:la2F = .true.!

   2. K_POINTS設置的切點密度(18*18*18)須可整除第-步K_POINTS設置(72*72*72)和第三步q點設置的整數倍,否則計算電聲耦合係數時,將無法進行插值!

   3. 設置 tstress = .true.和 tprnfor = .true. 去計算材料內原子受力,應力和壓力,輸出內容可在force.txt中檢查

運行scf計算的指令為:mpiexec pw.x -in pw.$name.$calcul-2.in > pw.$name.$calcul-2.out

# 第3個輸入檔案為ph.$name.in:

 &inputph
 
    tr2_ph=1.0d-16,
  
    prefix='$name',
  
    outdir='./'
  
    fildyn='$name.dyn',
  
    ldisp = .true.
  
    trans = .true.
  
    fildvscf = 'dvscf'
  
    electron_phonon = 'interpolated'  
  
    amass(1) = 50.9415
  
    nq1      = 6
  
    nq2      = 6
  
    nq3      = 6
  
    el_ph_sigma =  0.002
  
    el_ph_nsigma=30,
  
    alpha_mix(5)=0.1

/

這個輸入檔案的目的是用第二步自洽運算得到的電荷密度和波函數,進行DFPT自洽運算:

$$
\begin{aligned}
\text{Obtain-grand-state-charge-density:} \, n(r) \\
\Downarrow \\
\text{Guess-perturbate-charge-density:} \, \Delta n(r) \\
\Downarrow \\
\Delta V_{\text{SCF}}(r) = \Delta V_{\text{per}}^{q} (r) + e^2 \int \frac{\Delta n(r')}{|r - r'|} dr' \\
\Downarrow \\
\text{Fourier-Transformation:} \, \Delta V_{K-S}(r) = -\frac{1}{\sqrt{N_{p}}} \sum_{k} e^{-i(q+G)\cdot r} \Delta V_{K-S}(q+G) \\
\Downarrow \\
\Delta n_{\text{new}}(q+G) = \frac{4}{N \Omega} \sum_{k} \sum_{c,v} \frac{\langle \psi_{v,k} | e^{-i(q+G)\cdot r} | \psi_{c,k+q} \rangle \langle \psi_{c,k+q} | \Delta V_{\text{SCF}}(q+G) | \psi_{v,k} \rangle}{\varepsilon_{v,k} - \varepsilon_{c,k+q}} \\
\Downarrow \\
\text{Fourier-Transformation:} \, \Delta n_{\text{new}}(q+G) \Longrightarrow \Delta n_{\text{new}}(r) \\
\Downarrow \\
\Delta n(r) = \Delta n_{\text{new}}(r) \vee \Delta n(r) \neq \Delta n_{\text{new}}(r)
\end{aligned}
$$

QE會從ph.$name.in內讀取q點網格密度(nq1 nq2 nq3 ) 使用晶格對稱操作後,得到幾個不可約的q點.

不可約的q點可以在ph.$name.out內查找:

Dynamical matrices for ( 6, 6, 1)  uniform grid of q-points


     (   7 q-points):
     
       N         xq(1)         xq(2)         xq(3) 
       
       1   0.000000000   0.000000000   0.000000000
       
       2   0.000000000   0.192450090   0.000000000
       
       3   0.000000000   0.384900179   0.000000000
       
       4   0.000000000  -0.577350269   0.000000000
       
       5   0.166666667   0.288675135   0.000000000
       
       6   0.166666667   0.481125224   0.000000000
       
       7   0.333333333   0.577350269   0.000000000

 (這邊範例是六角晶格用q:6, 6, 1網格)

 每個不可約的q點內根據晶格內原子數量(n),計算3*n次DFPT自洽運算,並解:
 
 
 得到每個q點內聲子頻率和聲子振動模態
