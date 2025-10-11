QE計算材料超導轉變溫度的方法有兩種:QE自帶的PH模塊和EPW

There are two main methods in Quantum ESPRESSO (QE) to calculate the superconducting transition temperature of a material: the built-in PHonon (PH) module and the EPW code.

其中QE自帶的PH模塊使用double delta approximation(只考慮電子散射後,電子仍留在費米能級的散射幅,不考慮電子散射後,電子散射到費米能級的超導態仍允許存在的薄層的散射幅,會略為低估電聲耦合係數)去計算電聲耦合係數並使用Mcmillan Allen Dynesfunction去計算超導轉變溫度.

Among them, the PH module built into QE uses the double-delta approximation (which considers only the scattering processes where electrons remain on the Fermi level after scattering, and neglects the contributions from processes where electrons scatter into the thin energy shell around the Fermi level that still allows for superconducting states).As a result, this approximation slightly underestimates the electron–phonon coupling constant.
The module then uses the McMillan–Allen–Dynes formula to calculate the superconducting transition temperature.

Mcmillan Allen Dynesfunction只適合使用非強耦合且具超導各同向性(穿越費米能的電子均由同種原子同種軌域貢獻)的材料.

The McMillan–Allen–Dynes function is applicable only to materials with weak electron–phonon coupling and isotropic superconductivity ( electrons crossing the Fermi level originate from the same type of atom and the same type of orbital).

EPW可以使double delta approximation和非double delta approximation方法去計算電聲耦合係數並使用Migdal-Eliashberg理論去計算超導配對,解出超導轉變溫度.

EPW allows both the double-delta approximation and the non–double-delta (full) approach to calculate the electron–phonon coupling constant. It then uses the Migdal–Eliashberg theory to compute superconducting pairing and determine the superconducting transition temperature.

Migdal-Eliashberg理論支持強耦合且具超導各異向性(穿越費米能的電子由不同種原子不同種軌域貢獻)的材料.

The Migdal–Eliashberg theory supports strong-coupling superconductors and materials with anisotropic superconductivity ( electrons crossing the Fermi level originate from different types of atoms and different orbitals).

EPW的計算較為複雜,本教程暫時不寫EPW,不過EPW的計算方法的基礎仍是電子-聲子耦合,若是您已經成功構建了電子-聲子耦合的物理圖像,對於您理解EPW底層計算邏輯的幫助非常大.

EPW calculations are more complicated, so this tutorial will not cover EPW for now. However, the foundation of EPW calculations is still the electron–phonon coupling. If you have already successfully built a physical picture of electron–phonon coupling, it will greatly help you understand the underlying computational logic of EPW.
