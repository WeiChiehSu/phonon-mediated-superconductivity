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

準備計算電聲耦合係數(broadening法)中雙重\delta積分近似的能量採樣區間的資訊保存在V.a2Fsave中

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

   2. K_POINTS設置的切點密度(18*18*18)須可整除第一步K_POINTS設置(72*72*72)和第三步q點設置的整數倍,否則計算電聲耦合係數時,將無法進行插值!

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

 每個不可約的q點內根據晶格內原子數量(n),計算3*n次DFPT自洽運算,並解Hellman-Feynman Theory:

 $$
\varepsilon _{R} =\varepsilon _{0}+\sum_{k\gamma }^{}  R_{k\gamma} (r)\int n_{0} (r)\frac{\partial V_{SCF}(r) }{\partial R_{k\gamma} (r)}dr+\frac{1}{2}\sum_{R_{k,k'\gamma} }^{} R_{k\gamma} (r)R_{k'\gamma} (r) \int [\frac{\partial n(r)}{\partial R_{k'\gamma} (r)}\frac{\partial V_{SCF}(r) }{\partial R_{k\gamma} (r)}+n_{0}(r) \frac{\partial^2 V_{SCF}(r) }{\partial R_{k\gamma} (r)\partial R_{k'\gamma} (r)}]dr
$$
 
得到每個q點內聲子頻率,聲子振動模態和動力學矩陣(聲子頻率,聲子振動模態和動力學矩陣資訊存放在$name.dyn中):

     Diagonalizing the dynamical matrix

     q = (    0.000000000   0.192450090   0.000000000 ) 

 **************************************************************************
     freq (    1) =       2.172434 [THz] =      72.464606 [cm-1]
     freq (    2) =       2.642275 [THz] =      88.136817 [cm-1]
     freq (    3) =       3.642637 [THz] =     121.505275 [cm-1]
     freq (    4) =       4.396171 [THz] =     146.640492 [cm-1]
     freq (    5) =      10.070692 [THz] =     335.922131 [cm-1]
     freq (    6) =      10.079520 [THz] =     336.216602 [cm-1]
     freq (    7) =      10.092794 [THz] =     336.659363 [cm-1]
     freq (    8) =      10.107983 [THz] =     337.166012 [cm-1]
     freq (    9) =      16.458589 [THz] =     548.999450 [cm-1]
     freq (   10) =      16.481533 [THz] =     549.764749 [cm-1]
     freq (   11) =      16.509299 [THz] =     550.690930 [cm-1]
     freq (   12) =      16.530485 [THz] =     551.397619 [cm-1]
     freq (   13) =      25.352131 [THz] =     845.656048 [cm-1]
     freq (   14) =      25.405751 [THz] =     847.444636 [cm-1]
     freq (   15) =      25.459875 [THz] =     849.250029 [cm-1]
     freq (   16) =      25.482942 [THz] =     850.019457 [cm-1]
     freq (   17) =      45.730147 [THz] =    1525.393527 [cm-1]
     freq (   18) =      45.747224 [THz] =    1525.963136 [cm-1]
     freq (   19) =      45.776907 [THz] =    1526.953273 [cm-1]
     freq (   20) =      45.806344 [THz] =    1527.935175 [cm-1]
     freq (   21) =      48.350397 [THz] =    1612.795628 [cm-1]
     freq (   22) =      48.398957 [THz] =    1614.415418 [cm-1]
     freq (   23) =      48.450081 [THz] =    1616.120759 [cm-1]
     freq (   24) =      48.485580 [THz] =    1617.304872 [cm-1]
 **************************************************************************

 (這邊範例是8原子晶格的聲子頻率[可在ph.$name.out查找])

 $$
 並透過ph.$name.in設置的 el_{}ph_{}sigma =  0.002(Ry) [\sigma(degauss)便是雙重\delta積分近似中控制費米-狄拉克分布參數平緩或陡峭的參數] 和 el_{}ph_{}nsigma=30[0.002{}0.004{}0.006....總共設置30個值]和第一步保存在V.a2Fsave中計算電聲耦合係數(broadening法)中雙重\delta積分近似的能量採樣區間的資訊結合:
 $$

$$
I\simeq \frac{\Omega _{BZ}^{2} }{N_{K} N_{q}} \sum_{k}^{} \sum_{q}^{}  \frac{1}{\sqrt{2\pi \sigma } }e^{-\frac{(\epsilon _{k}-\epsilon _{F})^{2}   }{\sigma ^{2} } } \frac{1}{\sqrt{2\pi \sigma } }e^{-\frac{(\epsilon _{k^{'}}-\epsilon _{F})^{2}   }{\sigma ^{2} } }   
$$

$$
並結合前面得到的頻率和第二步得到的波函數,對角化出電聲耦合矩陣元G_{q}:
$$

$$
g_{nn^{'}}(k,q)=< \psi _{n,k}|-iq\frac{1}{N_{p} }e^{i(k+q-k^{'} )r_{i} }\frac{1}{\sqrt{2M\omega _{q}} }V_{K-S}(q)   |\psi _{n^{'} ,k^{'}}>
$$

$$
最終計算出30個不同\sigma(degauss)值的電聲耦合係數\lambda _{q}:
$$

$$
\lambda _{q}=\frac{\sum_{nn^{'}}^{} \int_{BZ}^{} \left | g_{nn^{'}}(k,q) ^{2} \right | \delta (\epsilon _{n,K}-\epsilon _{F})\delta (\epsilon _{n^{'} ,k^{'}}-\epsilon _{F})d\epsilon}{g_{electron} (\epsilon _{n^{'} ,k^{'}}-\epsilon _{F})\omega _{q}\Omega _{BZ}} 
$$

     Gaussian Broadening:   0.096 Ry, ngauss=   0
     DOS =  3.000182 states/spin/Ry/Unit Cell at Ef=  0.766207 eV
     lambda(    1)=  0.0002   gamma=    0.04 GHz
     lambda(    2)=  0.0002   gamma=    0.04 GHz
     lambda(    3)=  0.0004   gamma=    0.09 GHz
     lambda(    4)=  0.0006   gamma=    0.13 GHz
     lambda(    5)=  0.0004   gamma=    0.33 GHz
     lambda(    6)=  0.0003   gamma=    0.25 GHz
     lambda(    7)=  0.0002   gamma=    0.19 GHz
     lambda(    8)=  0.0002   gamma=    0.18 GHz
     lambda(    9)=  0.0001   gamma=    0.12 GHz
     lambda(   10)=  0.0001   gamma=    0.08 GHz
     lambda(   11)=  0.0000   gamma=    0.06 GHz
     lambda(   12)=  0.0000   gamma=    0.06 GHz
     lambda(   13)=  0.0007   gamma=    1.74 GHz
     lambda(   14)=  0.0006   gamma=    1.58 GHz
     lambda(   15)=  0.0006   gamma=    1.49 GHz
     lambda(   16)=  0.0006   gamma=    1.54 GHz
     lambda(   17)=  0.0022   gamma=   11.58 GHz
     lambda(   18)=  0.0018   gamma=    9.84 GHz
     lambda(   19)=  0.0017   gamma=    8.88 GHz
     lambda(   20)=  0.0016   gamma=    8.84 GHz
     lambda(   21)=  0.0007   gamma=    4.51 GHz
     lambda(   22)=  0.0006   gamma=    3.95 GHz
     lambda(   23)=  0.0006   gamma=    3.42 GHz
     lambda(   24)=  0.0005   gamma=    3.31 GHz

  (這邊範例是8原子晶格的電聲耦合係數計算[Gaussian Broadening:0.096 Ry][可在ph.$name.out查找])

  進行ph.$name.in有幾個要點:

$$
1.tr2_{}ph=1.0d-16,當DFPT的scf計算的|\Delta n_{\text{new}}(r)|^2和上一次scf計算的|\Delta n(r)|^2能量差低於1.0d-16時,電子密度對聲子擾動的響應已經完全收斂,停止計算(非常重要!若精度不夠高,會在\Gamma點有虛頻,影響計算精確度)
$$

   2. amass(1) = 50.9415:晶格內第一種原子(遵循pw.$name.scf-2.in設置)的質量

   3. nq1 = 6,nq2 = 6,nq3 = 6:q點網格的xyz軸切點數(6*6*6)須可整除第一步K_POINTS設置(72*72*72)和第二步K_POINTS設置(18*18*18),否則計算電聲耦合係數時,將無法進行插值!

   4. el_ph_sigma = 0.002:計算電聲耦合係數broadening法的sigma值,其控制函數平緩或陡峭的參數:sigma值越小,費米-函數越陡峭;,sigma值越大,函數越平緩

   5. el_ph_nsigma=30:0.002,0.004,0.006....總共設置30個值

   6. fildyn='$name.dyn':動力學矩陣的檔案名稱為$name.dyn

   7. alpha_mix(5)=0.1:控制scf響應勢混合迭代的參數(非常重要,若alpha_mix過大,將導致計算無法收斂!),默認值是alpha_mix(1)=0.7,alpha_mix(5)=0.1表示在第五步迭代時,混合參數從0.7更換到0.1,alpha_mix=0.1混合的定義是:

$$
\Delta n_{\text{out}}(r) * 0.1+\Delta n_{\text{in}}(r) * (1-0.1)=\Delta n_{\text{new}}(r)
$$

其代表第一次迭代輸入的響應勢X0.9+第一次迭代輸出的響應勢X0.1=第二次迭代輸入的響應勢

運行DFPT的scf計算指令為:mpiexec ph.x -in ph.$name.in > ph.$name.out(注:這個計算最耗時!)

# 第4個輸入檔案為q2r.$name.in:

 &input
 
     zasr='simple',  
  
     fildyn='$name.dyn', 
  
     flfrc='$name.fc', 
  
     la2F=.true.
  
 /

這個輸入檔案的目的是將第三步計算得到的每個q點的動力學矩陣進行Fourier-Transformation,從q空間變換到實空間的原子間相互作用常數 (force constants)!

進行q2r.$name.in有幾個要點:

   1. zasr='simple':聲學求和條件,simple表只施加3個平移聲學條件,並透過修正力常數矩陣（force-constants matrix）的對角元素來實現

   2. fildyn='$name.dyn':第三部計算得到的動力學矩陣檔案名稱

   3. flfrc='$name.fc':Fourier-Transformationc後的力學常數檔案名稱

   4. la2F=.true.:表示計算電聲耦合

運行q2r計算指令為:mpiexec q2r.x -in q2r.$name.in > q2r.$name.out

# 第5個輸入檔案為matdyn.$name.in:

 &input
 
    asr='simple', 
    
    flfrc='$name.fc', 
    
    flfrq='$name.freq', 
    
    amass(1) = 50.9415,
    
    q_in_band_form=.true.,
    
    q_in_cryst_coord=.true.	
    
    la2F=.true.,
    
    dos=.false.
    
 /
 
5

     0.0000    0.0000    0.0000 90 !G
     
     0.5000   -0.5000    0.5000 90 !H
     
     0.2500    0.2500    0.2500 90 !P
     
     0.0000    0.0000    0.0000 90 !G
     
     0.0000    0.0000    0.5000  1 !N

$$
這個輸入檔案的目的是將第四步計算得到的力學常數又進行Fourier-Transformation,從實空間變換到q空間,求得每個q點的動力學矩陣:
$$

$$
C_{k\gamma,k'\gamma'}(r_{\gamma}-r_{\gamma'})=\frac{1}{N}\sum_{q}^{} e^{iq(r_{\gamma}-r_{\gamma'})}C_{k\gamma,k'\gamma'}(q)  \Longrightarrow D_{k\gamma,k'\gamma'}(q)=\frac{C_{k\gamma,k'\gamma'}(q) }{\sqrt{m_{\gamma}m_{\gamma'}  } }
$$

$$
求得每個q點的動力學矩陣後,便能計算出系統的每個q點的聲子頻率.
$$

$$
\sum_{k',\gamma'}^{} D_{k,\gamma;k',\gamma'}(q)u_{k',\gamma'}(q)=\omega _{q}^{2} u_{k',\gamma'}(q)
$$

根據q點設置座標和切點數(0.0000    0.0000    0.0000 90 !G),繪製聲子譜並將將聲子譜保存至V.freq中,V.freq的內容為:

      &plot nbnd=   3, nks= 361 /            <-3條聲子譜(和晶格內的原子數量n有關:3 * n條) , 總共361個q點
 
            0.000000  0.000000  0.000000     <-第一個q點座標
            
         -0.0000    0.0000    0.0000         <-第一個q點座標的三個聲子頻率(和晶格內的原子數量n有關:3 * n個頻率)
   
            0.000000  0.011111  0.000000     <-第二個q點座標
            
         2.7942    2.7942    8.4798          <-第二個q點座標的三個聲子頻率(和晶格內的原子數量n有關:3 * n個頻率)



$$
得到每個q點的聲子頻率後,結合第二步得到的波函數,對角化出每個q點電聲耦合矩陣元G_{q}:
$$

$$
g_{nn^{'}}(k,q)=< \psi _{n,k}|-iq\frac{1}{N_{p} }e^{i(k+q-k^{'} )r_{i} }\frac{1}{\sqrt{2M\omega _{q}} }V_{K-S}(q)   |\psi _{n^{'} ,k^{'}}>
$$

$$
最終計算出30個不同\sigma(degauss)值的每個q點的電聲耦合係數\lambda _{q}(也可稱聲子線寬):
$$

$$
\lambda _{q}=\frac{\sum_{nn^{'}}^{} \int_{BZ}^{} \left | g_{nn^{'}}(k,q) ^{2} \right | \delta (\epsilon _{n,K}-\epsilon _{F})\delta (\epsilon _{n^{'} ,k^{'}}-\epsilon _{F})d\epsilon}{g_{electron} (\epsilon _{n^{'} ,k^{'}}-\epsilon _{F})\omega _{q}\Omega _{BZ}} 
$$

根據q點設置座標和切點數(0.0000    0.0000    0.0000 90 !G),繪製對應聲子譜的電聲耦合係數保存在elph.gamma.1,elph.gamma.2.......elph.gamma.30中(和第三步設置的el_ph_nsigma值有關),elph.gamma.5(這個是8個原子晶體的範例)的內容為:

      &plot nbnd=  24, nks= 601 /                                   <-24條聲子譜(和晶格內的原子數量8有關:3 * 8條) , 總共601個q點(和聲子譜設置一致)
    
               0.000000  0.000000  0.000000                         <-第一個q點座標
            
       -0.0000   -0.0000   -0.0000   -0.1824   -0.1824   -0.4844    <-第一個q點座標的24個聲子頻率(和晶格內的原子數量n有關:3 * n個頻率)
   
       -0.4844   -0.9939   -0.9939    0.1958   -0.0026    0.0228
   
        0.7218    0.0600    0.5054    0.0248   15.8819   15.8819
    
       12.2200   12.2200  120.8180  120.8180    4.9217    4.9217
   
               0.002500  0.001443  0.000000                         <-第二個q點座標
        -0.0004   -0.0010   -0.0013   -0.1833   -0.1830   -0.4851   <-第二個q點座標的24個聲子頻率(和晶格內的原子數量n有關:3 * n個頻率)
    
        -0.4853   -0.9945   -0.9948    0.1957   -0.0026    0.0227
   
         0.7215    0.0599    0.5051    0.0247   15.8747   15.8729
    
        12.2144   12.2127  120.7618  120.7569    4.9204    4.9299

進行matdyn.$name.in有幾個要點:

   1. zasr='simple':聲學求和條件,simple表只施加3個平移聲學條件,並透過修正力常數矩陣（force-constants matrix）的對角元素來實現

   2. flfrc='$name.fc':要讀取的第四步Fourier-Transformationc後的力學常數檔案名稱

   3. flfrq='$name.freq':根據q點設置座標和切點數(0.0000    0.0000    0.0000 90 !G),繪製的聲子譜檔案名稱:$name.freq

   4. q_in_band_form=.true.:在$name.freq中繪製每個q點的座標

   5. q_in_cryst_coord=.true.:在$name.freq中繪製的q點座標為晶體座標

   6. la2F=.true.:表示計算電聲耦合

   7. dos=.false.:表示不計算聲子態密度

   8. 5:總共要計算幾個BZ內的高對稱點

   9. 0.0000    0.0000    0.0000 90 !G:第一個要計算的高對稱點(Gamma點)座標和切點數(從G->H共切90點,因此最後一個高對稱點只切1點:總共切點數為90*5+1),切點數越多,最終畫出來的能帶越平滑,耗時也會加大

運行matdyn計算指令為:mpiexec matdyn.x -in matdyn.$name.in > matdyn.$name.out

# 第6個輸入檔案為matdyn.$name.in.dos:

   &input
 
    asr='simple', 
    
    flfrc='$name.fc',
    
    amass(1) = 50.9415,
    
    la2F=.true.,
    
    dos=.ture.,
    
    fldos='$name.dos',
    
    nk1=120,
    
    nk2=120,
    
    nk3=120,
    
    ndos=200,
    
 /

$$
這個輸入檔案的目的是讀取第四步計算得到的力學常數,在新的且更密的q點網格上,計算系統的eigenvalue(聲子頻率),統計出能量(聲子)分佈,得到每個頻率的聲子態密度g_{phonon}(\omega _{q}):
$$

$$
g_{phonon}(\omega _{q})= \int_{BZ}^{} \delta (\omega -\omega _{q})d\omega _{q}
$$

$$
得到每個頻率的聲子態密度g_{phonon}(\omega _{q})後,繪製系統的聲子態密度:V.dos,V.dos的內容為:
$$

       Frequency[cm^-1] DOS PDOS                  
   
     -3.2823913417E-06  0.0000000000E+00  0.0000E+00
 
      1.3060833847E+00  4.9657481957E-07  4.9657E-07
  
      2.6121700519E+00  1.9863022119E-06  1.9863E-06
  
      3.9182567190E+00  5.9372345402E-06  5.9372E-06
  
      5.2243433861E+00  1.4160024103E-05  1.4160E-05
  
      6.5304300533E+00  2.4078027412E-05  2.4078E-05
  
      7.8365167204E+00  3.4106552577E-05  3.4107E-05
  
      9.1426033875E+00  4.8856382114E-05  4.8856E-05

第1行為聲子的頻率(單位是cm^-1),第2行為材料的總聲子態密度,第3行為材料的每個原子的投影態密度


$$
統計第五步每個q點的電聲耦合係數,結合每個頻率的聲子態密度g_{phonon}(\omega _{q}),得到全部頻率的Eliashberg{}spectral{}function{} \alpha ^{2}F(\omega _{q} ):
$$

$$
\alpha ^{2}F(\omega _{q} ) =\frac{1}{2\Omega _{BZ} } \int_{BZ}^{} \omega _{q}\lambda _{q}\delta (\omega -\omega _{q})d\omega _{q}
$$

$$
得到30個不同\sigma(degauss)值的Eliashberg{}spectral{}function{} \alpha ^{2}F(\omega _{q} )後,將全部頻率的Eliashberg{}spectral{}function{} \alpha ^{2}F(\omega _{q} )保存在a2F.dos1,a2F.dos2.......a2F.dos30中(和第三步設置的el{}ph{}nsigma值有關),a2F.dos1的內容為:
$$

             Eliashberg function a2F (per both spin)
             
             frequencies in Rydberg  
             
             DOS normalized to E in Rydberg: a2F_total, a2F(mode) 
 
       0.595094E-05    0.551100E-07    0.452289E-07    0.953829E-08    0.342743E-09
       
       0.178529E-04    0.148797E-05    0.122118E-05    0.257538E-06    0.925426E-08
       
       0.297548E-04    0.980391E-05    0.856876E-05    0.119231E-05    0.428440E-07
       
       0.416568E-04    0.296306E-04    0.205884E-04    0.892469E-05    0.117564E-06
       
       0.535587E-04    0.732196E-04    0.537836E-04    0.191861E-04    0.249867E-06
       
       0.654606E-04    0.127891E-03    0.912062E-04    0.362288E-04    0.456204E-06
       
       0.773626E-04    0.224081E-03    0.160648E-03    0.626799E-04    0.753029E-06
       
       0.892645E-04    0.341527E-03    0.244525E-03    0.950084E-04    0.199347E-05
       
       0.101166E-03    0.514270E-03    0.370515E-03    0.140801E-03    0.295452E-05
       
       0.113068E-03    0.720216E-03    0.512733E-03    0.203307E-03    0.417591E-05
       
       0.124970E-03    0.995221E-03    0.710205E-03    0.279327E-03    0.568917E-05

第1行為聲子的頻率(單位是Ry),第2行為材料的總a2F,第3,4,5行為材料的每條聲子譜貢獻的a2F

$$
得到全部頻率的Eliashberg{}spectral{}function{} \alpha ^{2}F(\omega _{q} )後,將全部頻率Eliashberg{}spectral{}function加起來,得到系統的電子-聲子耦合強度\lambda:
$$

$$
\lambda=2\int \frac{\alpha ^{2}F(\omega _{q} )}{\omega}d\omega= \sum_{q}^{} \lambda _{q}
$$

$$
得到\lambda後,便能計算電子-聲子耦合權重\omega _{log}:
$$

$$
\omega _{log}=e^{[\frac{2}{\lambda } \int_{}^{ }d\omega \alpha ^{2}F(\omega )\frac{log\omega }{\omega }   ]}
$$

$$
30個不同\sigma(degauss)值的\lambda和\omega _{log},被保存在lambda檔案中,lambda檔案的內容為:
$$

         Electron-phonon coupling constant, lambda 
 
     Broadening   0.0020 lambda       1.4908 dos(Ef) 12.0273 omega_ln [K]    200.4114
 
     Broadening   0.0040 lambda       1.4816 dos(Ef) 12.2432 omega_ln [K]    200.6053
 
     Broadening   0.0060 lambda       1.4771 dos(Ef) 12.2834 omega_ln [K]    201.1737
     
     Broadening   0.0080 lambda       1.4738 dos(Ef) 12.2808 omega_ln [K]    201.1172
 
     Broadening   0.0100 lambda       1.4715 dos(Ef) 12.2670 omega_ln [K]    200.7874
 
     Broadening   0.0120 lambda       1.4685 dos(Ef) 12.2412 omega_ln [K]    200.3566
 
     Broadening   0.0140 lambda       1.4628 dos(Ef) 12.1932 omega_ln [K]    199.8876
 
第1行為Broadening,第2行為Broadening的值(由el_ph_sigma和el_ph_nsigma決定),第3行為lambda,第4行為lambda值,第5行為費米能級的電子態密度,第6行為費米能級的電子態密度值(單位Ry),第7行為電子-聲子耦合權重,第8行為電子-聲子耦合權重值

運行matdyn.dos計算指令為mpiexec matdyn.x -in matdyn.$name.in.dos > matdyn.$name.out.dos(注:這個計算第二耗時!)

# 第7個輸入檔案為lambda.$name.in:

     10 0.1 1                                       <- 最高的聲子頻率(單位THz),聲子態密度的degauss,smearing method
     
        16                                          <-總共計算了16個q點的動力學矩陣
        
        0.000000000   0.000000000   0.000000000  1  <-q點的座標和權重(在BZ中有幾個具有一樣對稱性的q點)
        
        0.166666667   0.166666667   0.000000000 12
        
        0.333333333   0.333333333   0.000000000 12
        
       -0.500000000  -0.500000000   0.000000000  6
       
        0.333333333   0.166666667   0.166666667 24
        
        0.500000000   0.333333333   0.166666667 48
        
        0.666666667   0.333333333   0.333333333  8
        
        0.333333333   0.333333333   0.333333333  8
        
        0.500000000   0.500000000   0.333333333 12
        
        0.000000000   0.000000000   0.333333333  6
        
       -0.000000000  -0.166666667   0.500000000 24
       
       -1.000000000  -0.333333333  -0.333333333 12
       
       -0.833333333  -0.166666667  -0.333333333 24
       
       -0.000000000  -0.000000000   0.666666667  6
       
       -1.000000000  -0.166666667  -0.166666667 12
       
       -1.000000000  -1.000000000  -1.000000000  1
       
     elph_dir/elph.inp_lambda.1                     <- 第三步PH計算保存的第一個q點的電聲耦合係數
     
     elph_dir/elph.inp_lambda.2
     
     elph_dir/elph.inp_lambda.3
     
     elph_dir/elph.inp_lambda.4
     
     elph_dir/elph.inp_lambda.5
     
     elph_dir/elph.inp_lambda.6
     
     elph_dir/elph.inp_lambda.7
     
     elph_dir/elph.inp_lambda.8
     
     elph_dir/elph.inp_lambda.9
     
     elph_dir/elph.inp_lambda.10
     
     elph_dir/elph.inp_lambda.11
     
     elph_dir/elph.inp_lambda.12
     
     elph_dir/elph.inp_lambda.13
     
     elph_dir/elph.inp_lambda.14
     
     elph_dir/elph.inp_lambda.15
     
     elph_dir/elph.inp_lambda.16
     
      0.3                                           <- McMillan-Allen Dynes function中的屏蔽庫侖pseudo-potential參數值

這個輸入檔案的目的是用第二步自洽運算得到的電荷密度和波函數,進行DFPT自洽運算:
