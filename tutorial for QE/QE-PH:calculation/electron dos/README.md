# 電子態密度

本次計算的材料為Nb(unit-cell)的電子態密度,運行計算只需把pseudopotential:Nb.pbe-spn-kjpaw_psl.1.0.0.UPF和腳本:qe_pbspro_dos.sh放進已經安裝好QE的pbs系統機器,運行:

qsub qe_pbspro_dos.sh

稍等一段時間後,計算便完成了.

接下來將V.bands.dat和pw.V.scf.out放到具有qe_band.m的資料夾中 運行qe_band.m 便可得到V(unit-cell)的電子能帶:band.png
