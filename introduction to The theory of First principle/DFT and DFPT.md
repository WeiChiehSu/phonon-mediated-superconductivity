# Density Functional Theory (密度泛函理論)

想要得到材料的電子性質,需要計算材料中的薛丁格方程式:

$$
H\Psi (r)=\varepsilon \Psi (r)
$$

$$
H =-\sum_{a=1 }^{k} \frac{\nabla^{2} _{R_{a}  }  } {2m_{a}} +\sum_{a=1 }^{k} \sum_{b>a }^{k} \frac{Z_{a}Z_{b} }{R_{ab}}-\sum_{i=1}^{n} \frac{\nabla^{2} _{r_{i}  }  } {2} +\sum_{i=1 }^{n} \sum_{j>i }^{n} \frac{1 }{r_{ij}}+ \sum_{i=1 }^{n} \sum_{a=1 }^{k} \frac{Z_{a} }{r_{ia}}
$$

$$
其中 \Psi (r)為N個電子波函數的乘積:
$$

$$
\Psi (r)=\psi _{1}(r) \psi _{2}(r)\psi _{3}(r).....
$$

這個方程式非常複雜,計算的成本非常高,近乎無法計算.

但在1964年,Hohenberg和Kohn發現了材料的基態電荷密度決定了材料基態的能量和波函數的性質,這表示我們可以用一個具有3個維度的電荷密度波函數來解薛丁格方程式,而不需要解有3N個變量的電子波函數,這讓計算複雜材料的電子能帶成為了可行,這便是密度泛函理論.

$$
\begin{aligned}
H \Psi(r) &= \varepsilon(\psi_{1}, \psi_{2}, \psi_{3}, \ldots) \, \Psi(r) \\
\Downarrow \\
H \Psi(r) &= \varepsilon[n(r)] \, \Psi(r)
\end{aligned}
$$

考慮絕熱近似和單電子近似後,材料的哈密頓量可改寫為下列的形式:

$$
-\sum_{a=1 }^{k} \frac{\nabla^{2} _{R_{a}  }  } {2m_{a}} +\sum_{a=1 }^{k} \sum_{b>a }^{k} \frac{Z_{a}Z_{b} }{R_{ab}}-\sum_{i=1}^{n} \frac{\nabla^{2} _{r_{i}  }  } {2} +\sum_{i=1 }^{n} \sum_{j>i }^{n} \frac{1 }{r_{ij}}+ \sum_{i=1 }^{n} \sum_{a=1 }^{k} \frac{Z_{a} }{r_{ia}}\Longrightarrow -\frac{\nabla^{2}r }{2}+V_{SCF}(r)+V_{Hatree}(r)
$$

這個公式被稱為Kohn–Sham equation,描述在「有效單電子勢」下，電子如何運動,其第一項為電子動能,第二項為電子和原子核間的勢能項,第三項為Hatree項:

$$
V_{Hatree}(r)=e^{2} \int \frac{n(r_{i}) }{\left | r-r_{i} \right | } d^{3} r_{i}
$$

Hatree項代表單個電子和由全部電子組成的電荷密度間產生的庫倫排斥.

DFT的數值計算方式如下:

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

$$
第1步為猜一個初始電子密度:解電子系統的Kohn–Sham{}equation,需要知道電子密度n(r)才能算出有效勢,問題是：一開始根本不知道真實的n(r)，所以只好先猜一個初始電子密度.
$$

$$
第2步為解Poisson{}equation:電子密度會產生庫倫靜電場,這步便是從目前的電子密度n(r)去計算Hartree勢,得到電子-電子之間的平均排斥作用.
$$

$$
第3步為解Kohn–Sham{}equation:得到Hartree勢後,便知道了系統的Hamiltonian,使用數值方法（例如:plane-wave 展開、基組展開、數值對角化,找到Hamiltonian的eigenvalue和eigenstate.
$$

$$
第4步為更新電子密度:電子密度就是所有電子波函數的平方和,用解出來的eigenstate重新計算,得到新的電子密度.
$$

$$
第5步為檢查收斂:如果新算出的電子密度 n_{\text{new}}(r) 和之前猜的n(r) 一致 -> 就找到一個「自洽」解;如果不一致,就把 n_{\text{new}}(r) 當作新的密度,再回到第2步重複計算，直到收斂
$$

使用密度泛函理論(DFT),我們可以得到材料的基態電荷密度,以此解出材料的基態能量和基態波函數,我們也可以對DFT理論延伸,考慮對材料引入微擾時,材料的性質將產生甚麼樣的變化,這理論被稱為密度泛函微擾理論(DFPT).

# Density Functional Perturbation Theory(密度泛函微擾理論)

$$
當對離子勢引入一個具有q向量效應的擾動\Delta V_{per}^{q}時,系統的勢能項V_{SCF}將產生一個響應擾動勢;同時系統電荷密度n(r)也會產生一個對應的響應電荷密度\Delta n(r):
$$

$$
\Delta V_{per}^{q} \Longrightarrow V_{SCF} \to V_{SCF}+\Delta V_{SCF}
$$

$$
我們可以透過這個擾動\Delta V_{per}^{q}和響應電荷密度\Delta n(r)來解出響應擾動勢:
$$

$$
\Delta V_{SCF}(r)=\Delta V_{_{per}}^{q} (r)+e^{2} \int \frac{\Delta n(r')}{|r-r'|} dr'
$$

$$
將解出響應擾動勢\Delta V_{SCF}(r)進行傅立葉變換,從實空間轉換成動量空間:
$$

$$
\Delta V_{K-S}(r)=-\frac{1}{\sqrt{N_{p} } } \sum_{k}^{} e^{-i(q+G).r} \Delta V_{K-S}(q+G)
$$

$$
得到以動量為變數的響應擾動勢\Delta V_{K-S}(q+G)後,引入微擾理論,用DFT解出的波函數和能量進行對角化,解出響應電荷密度\Delta n(q+G):
$$

$$
\Delta n(q+G) = \frac{4}{N\Omega } \sum_{k}^{} \sum_{c,v}^{} \frac{\left \langle \psi_{v,k}  \right |e^{-i(q+G).r } \left | \psi_{c,k+q}   \right \rangle \left \langle \psi_{c,k+q} \right |\Delta V_{SCF}(q+G)\left | \psi_{v,k}   \right \rangle    }{\varepsilon_{v,k}-\varepsilon _{c,k+q}   } 
$$

再對解出響應電荷密度進行傅立葉變換,得到以實空間為變數的響應電荷密度後,和初始的響應電荷密度進行比較:如果和初始的響應電荷密度相差過大,將初始的響應電荷密度和最後得到的響應電荷密度進行混合,得到新的響應電荷密度後再次進行運算;若得到的響應電荷密度和初始的響應電荷密度誤差很小,表示得到的響應電荷密度和響應擾動勢是正確的.

整個計算流程可以寫成和DFT類似的迭代步驟:

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

得到響應電荷密度和響應擾動勢後,可以透過Hellman-Feynman Theory解出材料的振動性質,並解出材料的電子-聲子耦合係數.
