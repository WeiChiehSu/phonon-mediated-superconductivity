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

但在1964年,Hohenberg和Kohn發現了材料的基態電荷密度決定了材料基態的能量和波函數的性質,這表示我們可以用一個具有3個維度的電荷密度波函數來解薛丁格方程式,而不需要解有3N個變量的電子波函數,這讓計算複雜材料的電子能帶成為了可行.

$$
\begin{aligned}
H \Psi(r) &= \varepsilon(\psi_{1}, \psi_{2}, \psi_{3}, \ldots) \, \Psi(r) \\
\Downarrow \\
H \Psi(r) &= \varepsilon[n(r)] \, \Psi(r)
\end{aligned}
$$

考慮絕熱近似和單電子近似後,材料的哈密頓量可改寫為下列的形式:


$$
\begin{aligned}
\text{Guess-charge-density:} \, n(r) \\
\Downarrow \\
\text{Poisson-eq:} \, \nabla^2 V_{\text{Hatree}}(r) = -4 \pi n(r) \\
\Downarrow \\
\text{KS-eq:} \left[ -\frac{\nabla^2 r}{2} + V_{\text{SCF}}(r) + V_{\text{Hatree}}(r) \right] \Psi(r) = \varepsilon \Psi(r) \\
\Downarrow \\
n_{\text{new}}(r) = \sum \left| \Psi(r) \right|^2 \\
\Downarrow \\
n(r) = n_{\text{new}}(r) \vee n(r) \neq n_{\text{new}}(r)
\end{aligned}
$$


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

