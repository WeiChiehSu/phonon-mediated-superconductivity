# 電子態密度

本次計算的材料為Nb(unit-cell)的電子態密度,運行計算只需把pseudopotential:Nb.pbe-spn-kjpaw_psl.1.0.0.UPF和腳本:qe_pbspro_dos.sh放進已經安裝好QE的pbs系統機器,運行:

qsub qe_pbspro_dos.sh

稍等一段時間後,計算便完成了.

接下來將V.bands.dat和pw.10Nb.nscf.out放到具有qe_dos.m的資料夾中 運行qe_dos.m 便可得到Nb(unit-cell)的態密度:band.png
