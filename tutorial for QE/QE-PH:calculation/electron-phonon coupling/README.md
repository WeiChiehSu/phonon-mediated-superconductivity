# 聲子譜,聲子態密度,Eliashberg譜函數和超導轉變溫度

本次計算的材料為V(unit-cell)的聲子譜,聲子態密度,Eliashberg譜函數和超導轉變溫度,運行計算只需把pseudopotential:V.pbe-spnl-kjpaw_psl.1.0.0.UPF和腳本:qe_twnia3_elph_all.sh和qe_twnia3_lambda.sh放進已經安裝好QE的slurm系統機器,先運行:

sbatch qe_twnia3_elph_all.sh

先等很長一段時間,確認qe_twnia3_elph_all.sh的計算任務完成後,再運行:

sbatch qe_twnia3_lambda.sh

稍等一段時間後,整個計算便完成了.

接下來將banddos資料夾下載下來,再將qephonon.m,qephonondos.m,qea2fdos.m和Tclambda.m放置到banddos資料夾中 運行 qephonon.m,qephonondos.m,qea2fdos.m和Tclambda.m 便可得到V(unit-cell)的聲子譜,聲子態密度,Eliashberg譜函數和超導轉變溫度
