# Harmonic approximation : Harmonic potential

簡諧近似:原子振動可以近似成在平衡點周圍微小振動,感受到的勢能可以近似成諧和勢

$$
原子勢能振動曲線V(r_{i}-R_{0}):
$$

![公式](https://latex.codecogs.com/png.latex?V(r_{i}-R_{0})%3D-V(r_{i}-R_{0})|_{r_{i}%3DR_{0}}-\frac{\partial%20V(r_{i}-R_{0})}{\partial%20r_{i}}%20(r_{i}-R_{0})|_{r_{i}%3DR_{0}}-\frac{1}{2!}%20\frac{\partial^{2}%20V(r_{i}-R_{0})}{\partial^{2}%20r_{i}}%20(r_{i}-R_{0})^{2}-\frac{1}{n!}%20\frac{\partial^{n}%20V(r_{i}-R_{0})}{\partial^{n}%20r_{i}}%20(r_{i}-R_{0})^{n}+....)

$$
V(r_{i}-R_{0})= -V(r_{i}-R_{0})|_{r_{i}=R_{0}} -\frac{\partial V(r_{i}-R_{0})}{\partial r_{i}} (r_{i}-R_{0})|_{r_{i}=R_{0}}-\frac{1}{2!} \frac{\partial^{2}  V(r_{i}-R_{0})}{\partial^{2}  r_{i}} (r_{i}-R_{0})^{2}-\frac{1}{n!} \frac{\partial^{n}  V(r_{i}-R_{0})}{\partial^{n}  r_{i}} (r_{i}-R_{0})^{n}+....
$$

$$
V(r_{i}-R_{0})可以近似成:
$$

![公式](https://latex.codecogs.com/png.latex?V(r_{i}-R_{0})\cong%20\frac{1}{2}%20C(r_{i}-R_{0})^2-\frac{1}{6}%20\gamma%20(r_{i}-R_{0})^3;%20C=\frac{\partial^{2}%20V(r_{i}-R_{0})}{\partial^{2}%20r_{i}})

C 稱為諧和力常數

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
\text{Anharmonicity-effect: }
\begin{cases}
  \text{electron-phonon-coupling} \\
  \text{phonon-phonon-coupling}
\end{cases}
\;\Longrightarrow\;
\begin{cases}
  \text{energy-temperature: dependent} \\
  \text{have finite lifetime}
\end{cases}
$$

$$
\text{Anharmonicity-effect: }
\begin{cases}
  \text{light ions exist} \\
  \text{system close to melting} \\
  \text{ferroelectric phase transition} \\
  \text{charge density wave (CDW)}
\end{cases}
$$

# Harmonic approximation : phonon-dynamics matrix

$$
原子間存在諧和勢的一維原子鍊的示意圖,第j個cell內有兩個原子j,1和j,2,質量為m_1和m_2,偏移平衡點的位移為u_{j_{1} }和u_{j_{2} },其Kinetic energy和potential為:
$$

$$
Kinetic-energy:\sum_{j}^{} (\frac{m_{1} }{2} \dot{u}_{j,1}^{2} + \frac{m_{2} }{2} \dot{u}_{j,2}^{2})
$$

$$
potential:\sum_{j}^{} \frac{c}{2} [(u_{j,1}- u_{j-1,2})^{2}+(u_{j,2}- u_{j,1})^{2} +(u_{j+1,1}- u_{j,2})^{2}]   
$$

c代表force constant,計算該系統的Lagrangian(L),並解Lagrange equation:

$$
L=K-U;Lagrange-equation:\frac{d}{dt} \frac{\partial L}{\partial \dot{r} } =\frac{\partial L}{\partial r}
$$

得該系統的兩個原子j,1和j,2的運動方程:

$$
j,1: -m_{1}\ddot{u}_{j,1} = c[ {u}_{j-1,2}-2{u}_{j,1}+{u}_{j,2}]
$$

$$
j,2: -m_{2}\ddot{u}_{j,2} = c[ {u}_{j,1}-2{u}_{j,2}+{u}_{j+1,1}]
$$


設運動方程的解為平面波:

$$
\begin{cases}
u_{j,1}(t) = A_1 e^{i(q j a - \omega_q t)}, & \ddot{u}_{j,1}(t) = -\omega_q^2 A_1 e^{i(q j a - \omega_q t)} \\
u_{j,2}(t) = A_2 e^{i(q j a - \omega_q t)}, & \ddot{u}_{j,2}(t) = -\omega_q^2 A_2 e^{i(q j a - \omega_q t)}
\end{cases}
$$

$$
第j\pm 1個晶格內第n個原子的平面波解為:
$$

$$
u_{j\pm 1,n}=A_{n}e^{i[q(j\pm 1)a-\omega _{q}t] }=A_{n}e^{\pm iqa}   e^{i[qja-\omega _{q}t] }
$$

$$
a為晶格的間距,將{u}_{j,n}和\ddot{u}_{j,1}代入運動方程中,並寫成矩陣形式:
$$

$$
\begin{cases}
(2c - \omega_q^2 m_1) A_1 - c(e^{-iqa} + 1) A_2 = 0 \\
(2c - \omega_q^2 m_2) A_2 - c(e^{iqa} + 1) A_1 = 0
\end{cases}
\;\Longrightarrow\;
\begin{bmatrix}
2c - \omega_q^2 m_1 & -c(e^{-iqa}+1) \\
-c(e^{iqa}+1) & 2c - \omega_q^2 m_2
\end{bmatrix}
\begin{bmatrix} A_1 \\ A_2 \end{bmatrix} = 0
$$

$$
可以定義該系統的[c_{q}],[m]和eigenvector:
$$

$$
[c_q] = 
\begin{bmatrix}
2c & -c(e^{-iqa}+1) \\
-c(e^{iqa}+1) & 2c
\end{bmatrix}, \\
\text{eigenvector: } \vec{A} = 
\begin{bmatrix} A_1 & A_2 \end{bmatrix}, \\
[m] = 
\begin{bmatrix}
m_1 & 0 \\
0 & m_2
\end{bmatrix}
$$
