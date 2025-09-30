# Harmonic approximation : Harmonic potential

簡諧近似:原子振動可以近似成在平衡點周圍微小振動,感受到的勢能可以近似成諧和勢

原子勢能振動曲線$V(r_{i}-R_{0})$:

![公式](https://latex.codecogs.com/png.latex?V(r_{i}-R_{0})%3D-V(r_{i}-R_{0})|_{r_{i}%3DR_{0}}-\frac{\partial%20V(r_{i}-R_{0})}{\partial%20r_{i}}%20(r_{i}-R_{0})|_{r_{i}%3DR_{0}}-\frac{1}{2!}%20\frac{\partial^{2}%20V(r_{i}-R_{0})}{\partial^{2}%20r_{i}}%20(r_{i}-R_{0})^{2}-\frac{1}{n!}%20\frac{\partial^{n}%20V(r_{i}-R_{0})}{\partial^{n}%20r_{i}}%20(r_{i}-R_{0})^{n}+....)

$$
V(r_{i}-R_{0})= -V(r_{i}-R_{0})|_{r_{i}=R_{0}} -\frac{\partial V(r_{i}-R_{0})}{\partial r_{i}} (r_{i}-R_{0})|_{r_{i}=R_{0}}-\frac{1}{2!} \frac{\partial^{2}  V(r_{i}-R_{0})}{\partial^{2}  r_{i}} (r_{i}-R_{0})^{2}-\frac{1}{n!} \frac{\partial^{n}  V(r_{i}-R_{0})}{\partial^{n}  r_{i}} (r_{i}-R_{0})^{n}+....
$$

$V(r_{i}-R_{0})$可以近似成:

![公式](https://latex.codecogs.com/png.latex?V(r_{i}-R_{0})\cong%20\frac{1}{2}%20C(r_{i}-R_{0})^2-\frac{1}{6}%20\gamma%20(r_{i}-R_{0})^3;%20C=\frac{\partial^{2}%20V(r_{i}-R_{0})}{\partial^{2}%20r_{i}})

C 稱為諧和力常數

$$
harmonic-phonon\left\{\begin{matrix} energy-temperature:independent\\ infinite-lifetime\end{matrix}\right.\Longrightarrow harmonic-defect
$$

$$
\text{harmonic-phonon: } 
\begin{cases}
  \text{energy-temperature: independent} \\
  \text{infinite-lifetime}
\end{cases}
\;\Longrightarrow\;
\text{harmonic-defect}
$$


$$
Anharmonicity-effect\left\{\begin{matrix} energy-phonon-coupling\\ phonon-phonon-coupling\end{matrix}\right.\Longrightarrow \left\{\begin{matrix} energy-temperature:dependent\\ have-finite-lifetime\end{matrix}\right.
$$

$$
Anharmonicity < harmonic \Longrightarrow Perturbation-theory;Anharmonicity > harmonic \Longrightarrow lose-efficacy
$$
$$
Anharmonicity-effect\left\{\begin{matrix}light-ions-exist \\system-close-melting \\ferroelectric-phase-transition \\charge-density wave (CDW)\end{matrix}\right.
$$

# Harmonic approximation : phonon-dynamics matrix

原子間存在諧和勢的一維原子鍊的示意圖,第j個cell內有兩個原子j,1和j,2,質量為m$_1$和m$_2$,偏移平衡點的位移為$u_{j_{1} }$和$u_{j_{2} }$,其Kinetic energy和potential為:


![Kinetic Energy](https://latex.codecogs.com/svg.latex?Kinetic-energy:\sum_{j}^{}%20\left(\frac{m_{1}%20}{2}%20\dot{u}_{j,1}^{2}%20+%20\frac{m_{2}%20}{2}%20\dot{u}_{j,2}^{2}\right))


![Potential Energy](https://latex.codecogs.com/svg.latex?potential:\sum_{j}^{}%20\frac{c}{2}%20\left[(u_{j,1}-u_{j-1,2})^{2}+(u_{j,2}-u_{j,1})^{2}+(u_{j+1,1}-u_{j,2})^{2}\right])

c代表force constant,計算該系統的Lagrangian(L),並解Lagrange equation:

![Lagrange Equation](https://latex.codecogs.com/svg.latex?L=K-U;\quad\text{Lagrange-equation:}\quad\frac{d}{dt}%20\frac{\partial%20L}{\partial%20\dot{r}%20}%20=%20\frac{\partial%20L}{\partial%20r})

得該系統的兩個原子j,1和j,2的運動方程:

![Equation](https://latex.codecogs.com/svg.latex?j,1%3A%20-m_{1}\ddot{u}_{j,1}%20=%20c[%20{u}_{j-1,2}-2{u}_{j,1}+{u}_{j,2}]%5C%5Cj,2%3A%20-m_{2}\ddot{u}_{j,2}%20=%20c[%20{u}_{j,1}-2{u}_{j,2}+{u}_{j+1,1}])

設運動方程的解為平面波:

![Equation](https://latex.codecogs.com/png.latex?u_{j,1}(t)%20=%20A_{1}%20e^{i(qja%20-%20\omega_q%20t)},%20\ddot{u}_{j,1}(t)%20=%20-\omega_q^2%20A_{1}%20e^{i(qja%20-%20\omega_q%20t)})

![Equation](https://latex.codecogs.com/png.latex?u_{j,2}(t)%20=%20A_{2}%20e^{i(qja%20-%20\omega_q%20t)},%20\ddot{u}_{j,2}(t)%20=%20-\omega_q^2%20A_{1}%20e^{i(qja%20-%20\omega_q%20t)})

第$j\pm 1$個晶格內第n個原子的平面波解為:

![Equation](https://latex.codecogs.com/png.latex?u_{j\pm%201,n}=A_{n}e^{i[q(j\pm%201)a-\omega%20_{q}t]}%20=%20A_{n}e^{\pm%20iqa}%20e^{i[qja-\omega%20_{q}t]})

a為晶格的間距,將${u}_{j,n}$和$\ddot{u}_{j,1}$代入運動方程中,並寫成矩陣形式:
