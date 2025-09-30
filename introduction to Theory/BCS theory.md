在BCS理論中,Cooper發現:

$$
若Fermi{}surface外有兩顆電子,位在r_{1}和r_{2},其相互作用為V(r_{1}-r_{2})並和自旋無關,且和Fermi{}surface內的電子無相互作用,那兩電子的Hamilition為:
$$

$$
H=-\frac{1}{2m} (\frac{\partial^{2} }{\partial r_{1}^{2}} +\frac{\partial^{2} }{\partial r_{2}^{2}})+V(r_{1}-r_{2})
$$

$$
將電子座標換成質心座標(r_{1}+r_{2})/2和相對座標r=r_{1}-r_{2}:
$$

$$
\frac{\partial }{\partial r_{1}}=\frac{\partial  }{\partial R}\frac{\partial R }{\partial r_{1}}+\frac{\partial  }{\partial r}\frac{\partial r }{\partial r_{1}}=\frac{1}{2}\frac{\partial  }{\partial R}+\frac{\partial  }{\partial r}
$$

$$
\frac{\partial }{\partial r_{2}}=\frac{\partial  }{\partial R}\frac{\partial R }{\partial r_{2}}+\frac{\partial  }{\partial r}\frac{\partial r }{\partial r_{2}}=\frac{1}{2}\frac{\partial  }{\partial R}-\frac{\partial  }{\partial r} 
$$

Hamilition可改為:

$$
H=-\frac{1}{2m} (\frac{\partial^{2} }{\partial r_{1}^{2}} +\frac{\partial^{2} }{\partial r_{2}^{2}})+V(r_{1}-r_{2})=-\frac{1}{4m} \frac{\partial^{2} }{\partial R^{2}}-\frac{1}{m} \frac{\partial^{2} }{\partial r^{2}}+V(r) 
$$

可發現質心運動和相對運動分離,而質心運動屬於自由運動,系統波函數和eigenfuction可寫成:

$$
\Psi (r_{1} ,r_{2})=\Psi (R ,r)=\frac{e^{iqR} }{\sqrt{N_{p} } } \psi (r);H\Psi (R ,r)=E\Psi (R ,r)
$$

Hamilition作用在波函數後,eigenfuction為:

$$
[\frac{q^{2} }{4m} -2\frac{1}{2m} \frac{\partial^{2} }{\partial r^{2}}+V(r)]\psi (r)\Longrightarrow [-2\frac{1}{2m} \frac{\partial^{2} }{\partial r^{2}}+V(r)]\psi (r) =[E-\frac{q^{2} }{4m}]\psi (r)
$$

$$
兩個電子的總能為E=\frac{q^{2} }{4m} -2\frac{1}{2m} \frac{\partial^{2} }{\partial r^{2}}+V(r),接著對相對運動波函數和相互作用進行fouier{}trnsform:設兩個電子的動量分別為\vec{k}和\vec{k'},具有下列性質:
$$

$$
|\vec{k}|= |\vec{k'}|,\Delta k=\vec{k'}-\vec{k}
$$

$$
\psi (r)=\frac{1}{\sqrt{N_{p} } } \sum_{k}^{} e^{ikr} \psi (k);V(r)=\sum_{\Delta k}^{} e^{i\Delta kr} V (\Delta k)
$$

Hamilition作用在相對運動波函數後,eigenfuction為:

$$
2\frac{k^{2} }{2m}\sum_{k}^{}\frac{e^{ikr} }{\sqrt{N_{p}} }\psi (k)+\sum_{k,\Delta k}^{} \frac{e^{i(k+\Delta k)r} }{\sqrt{N_{p}} }\psi (k)V( \Delta k) =[E-\frac{q^{2} }{4m}]\frac{1}{\sqrt{N_{p} } } \sum_{k}^{} e^{ikr} \psi (k)
$$

可改寫為:

$$  
\sum_{k}^{}[2\frac{k^{2}}{2m}-E+\frac{q^{2} }{4m}]\frac{e^{ikr} }{\sqrt{N_{p}} }\psi (k)+\sum_{k,k'}^{} \frac{e^{ik'r} }{\sqrt{N_{p}} }\psi (k')V( \vec{k'}-\vec{k}) =0
$$

接下來:

$$
\sum_{k}^{}[(2\frac{k^{2}}{2m}-E+\frac{q^{2} }{4m})\psi (k)+\sum_{k'}^{}V( \vec{k'}-\vec{k})\psi (k')]\frac{e^{ikr} }{\sqrt{N_{p}} } =0
$$

$$
設自由單電子的能量為\frac{k^{2} }{2m},Fermi{}surface的電子能量為E_{F},則相對於Fermi{}surface的單電子能量為\varepsilon _{k} = \frac{k^{2} }{2m} -E_{F} ,則式子變為:
$$

$$
(2\varepsilon _{k}+2E_{F} -E+\frac{q^{2} }{4m})\psi (k)+\sum_{k'}^{}V( \vec{k'}-\vec{k})\psi (k') =0
$$

$$
從前面已知電子非直接相互作用H_{eff}在|\varepsilon _ {k} -\varepsilon _{k'}| <\omega _{q}時,也就是在Fermi-surface附近上下一點的範圍內,V_{kq}<0存在吸引相互作用,所以相互作用項可設為:
$$

$$
V(\vec{k}' - \vec{k}) =
\begin{cases}
  -V_{kq}, & |\varepsilon_{k} - \varepsilon_{k'}| < \omega_q \\
  0, & \text{otherwise}
\end{cases}
$$

