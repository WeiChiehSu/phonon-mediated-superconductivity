# Phonon-mediated-superconductivity
This is a tutorial on QE calculations for phonon-mediated superconductivity 

(to help personal understanding and knowledge transfer). 

If you have any questions,welcome use discussion.



# introduction to Theory

1.BCS theory:Cooper pair

2.Born-Oppenheimer approximation

3.Harmonic approximation : phonon-dynamics matrix

4.Electron-phonon coupling

5.Canonical transformation

6.McMillan-Allen Dynes function

這裡是超導理論基礎,介紹了BCS theory:Cooper pair,Born-Oppenheimer approximation,Harmonic approximation,Electron-phonon coupling,Canonical transformation,McMillan-Allen Dynes function的物理圖像和推導過程.

This section covers the fundamentals of superconductivity theory, including the BCS theory:Cooper pairs, the Born–Oppenheimer approximation, the harmonic approximation, electron–phonon coupling, the canonical transformation, and the McMillan–Allen–Dynes function, along with their physical interpretations and derivations.

若覺得理論推導過於困難,可以只看理論最後的物理圖像構建,先構建超導的基礎邏輯運行.

If you find the theoretical derivations are too challenging, you may focus on the final physical pictures presented by the theory first, in order to build a foundational understanding of the logical framework of superconductivity.

# introduction to The theory of First principle

1.Density functional theory and Density-functional-perturbation theory

2.Hellman-Feynman Theory

3.Connected electron-phonon coupling

4.Delta function Approxima.mdte method

這裡是第一原理理論介紹,裡面介紹了DFT的基礎,從dft延伸到dfpt,如何計算材料力學常數,怎麼和電子聲子耦合連結.

This section introduces first-principles theory covering the fundamentals of Density Functional Theory (DFT) and its extension to Density Functional Perturbation Theory (DFPT). It explains how to calculate mechanical constants of materials and how these are connected to electron–phonon coupling.

倘若覺得公式過於複雜,可以只看最後的物理圖像構建,先構建DFPT基礎邏輯運行.

If the mathematical formulas appear too complicated, you may focus on the final physical pictures to first establish a basic logical understanding of DFPT.

# tutorial for QE

1.How to install quantum-espresso

2.QE-PH:calculation

3.Discussion on Convergence Properties

這裡是QE實作toturial,裡面介紹了如何安裝QE,如何計算材料的電子能帶,如何計算材料的電子態密度,如何計算材料的電子投影軌域能帶,如何對晶格結構進行放鬆,如何計算聲子譜,聲子態密度和Eliashberg譜函數且使用Mcmillan Allen Dynes function去計算材料的超導轉溫度.

This tutorial introduces how to install QE, calculate the electronic band structure, density of states (DOS), projected orbital band structure, and how to relax crystal structures. It also demonstrates how to compute phonon dispersion relations, phonon density of states (PDOS), and the Eliashberg spectral function, as well as how to use the McMillan–Allen–Dynes function to evaluate the superconducting transition temperature (Tc) of materials.

Toturial裡面附有運行腳本,範例和畫圖的Matlab code,其中最重要的算超導轉變溫度的toturial(electron-phonon coupling),我把第一部分和第二部分的超導理論基礎和腳本結合,詳細介紹了每次運算是在對應哪些理論公式的運行!

The tutorial includes execution scripts, examples, and MATLAB codes for visualization.Among them, the most important part is the electron–phonon coupling tutorial, which focuses on calculating the superconducting transition temperature. In this section, I have integrated the theoretical foundations of superconductivity introduced in Parts I and II with the practical QE scripts, providing a detailed explanation of how each computational step corresponds to the relevant theoretical equations.

Toturial裡面還有超導性質收斂探討,介紹了如何判斷超導計算是否收斂,哪些參數對超導溫度影響最大.

Furthermore, the tutorial discusses the convergence of superconducting properties, explaining how to determine whether the superconductivity calculations are converged and which parameters have the greatest influence on the superconducting transition temperature


# Special Cases : Phonon Anharmonicity effect - SSCHA

1.SSCHA Theory : readme.md

2.How to install SSCHA

3.tutorial for 1BL stanene

# Reference

My Master's Thesis:https://thesis.lib.ncku.edu.tw/thesis/detail/55982d7b9fd66505eadfc9673f2c098d/

鐘寅 凝聚态物理導論 2023.3.22版

[arXiv:cond-mat/0504077](https://arxiv.org/abs/cond-mat/0504077)

https://journals.aps.org/prb/abstract/10.1103/PhysRevB.43.7231
