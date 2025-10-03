得到響應電荷密度和響應擾動勢後,便能透過Hellman-Feynman Theory得到系統所受的力. Hellman-Feynman Theory描述能量對參數的導數和勢能(對參數的導數)的期望值間的關係:

$$
\frac{\partial \varepsilon_{electron} }{\partial R_{k:direction,\gamma:atom }(r) }=\int n_{0}\frac{\partial V_{SCF} }{\partial R_{k:direction,\gamma:atom }(r)}dr\Longrightarrow \Delta \varepsilon_{electron}(r)=\int n_{0}\Delta V_{SCF}(r)dr  
$$

以簡單的功能定理W=F.r來解釋,便是F外加了一個小力,導致作功位移r產生了小位移,那計算出這個小力和小位移對系統總作功的產生的變化,便是Hellman-Feynman Theory的目的;小力和小位移可以簡單當成響應擾動勢和響應電荷密度.

將公式展開後,能量對參數的導數可以寫成下面的形式:

$$
\varepsilon _{R} =\varepsilon _{0}+\sum_{k\gamma }^{}  R_{k\gamma} (r)\int n_{0} (r)\frac{\partial V_{SCF}(r) }{\partial R_{k\gamma} (r)}dr+\frac{1}{2}\sum_{R_{k,k'\gamma} }^{} R_{k\gamma} (r)R_{k'\gamma} (r) \int [\frac{\partial n(r)}{\partial R_{k'\gamma} (r)}\frac{\partial V_{SCF}(r) }{\partial R_{k\gamma} (r)}+n_{0}(r) \frac{\partial^2 V_{SCF}(r) }{\partial R_{k\gamma} (r)\partial R_{k'\gamma} (r)}]dr
$$
