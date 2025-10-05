# 聲子譜,聲子態密度,Eliashberg譜函數和超導轉變溫度

本次計算的材料為V(unit-cell)的聲子譜,聲子態密度,Eliashberg譜函數和超導轉變溫度,運行計算只需把pseudopotential:V.pbe-spnl-kjpaw_psl.1.0.0.UPF和腳本:qe_twnia3_elph_all.sh和qe_twnia3_lambda.sh放進已經安裝好QE的slurm系統機器,先運行:

sbatch qe_twnia3_elph_all.sh

先等很長一段時間,確認qe_twnia3_elph_all.sh的計算任務完成後,再運行:

sbatch qe_twnia3_lambda.sh

稍等一段時間後,整個計算便完成了.

接下來將banddos資料夾下載下來,再將qephonon.m,qephonondos.m,qea2fdos.m和Tclambda.m放置到banddos資料夾中 運行 qephonon.m,qephonondos.m,qea2fdos.m和Tclambda.m,便可得到V(unit-cell)的聲子譜,聲子態密度,Eliashberg譜函數和超導轉變溫度

# QE腳本分析

腳本內總共創遭了7種輸入檔:pw.$name.scf-1.in pw.$name.scf-2.in ph.$name.in q2r.$name.in matdyn.$name.in matdyn.$name.in.dos lambda.$name.in 並進行了7次運算:

# 第1個輸入檔案為pw.$name.scf.in:

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

進行pw.$name.scf.in有幾個要點:

   1.必須設置:la2F = .true.表示計算電聲耦合!

   2.
