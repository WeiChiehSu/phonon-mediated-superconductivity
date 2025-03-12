The Schrödinger equation and Hamiltonian of the (electron + nucleus) system:

(電子+核)運動系統的Schrödinger equation和Hamilton:


$$
\widehat{H}\Psi (r_{i} ;R_{a} )=\varepsilon \Psi (r_{i} ;R_{a} )
$$


$$ \widehat{H} = -\sum_{a=1 }^{k} \frac{\nabla^{2} {R_{a} } } {2m_{a}} +\sum_{a=1 }^{k} \sum_{b>a }^{k} \frac{Z_{a}Z_{b} }{R_{ab}} -\sum_{i=1}^{n} \frac{\nabla^{2} {r_{i} } } {2} +\sum_{i=1 }^{n} \sum_{j>i }^{n} \frac{1 }{r_{ij}}+ \sum_{i=1 }^{n} \sum_{a=1 }^{k} \frac{Z_{a} }{r_{ia}} $$



The first two terms in the equation represent the kinetic energy of the nuclei and the Coulomb interaction between the nuclei. The last three terms represent the kinetic energy of the electrons and the Coulomb interactions between the electrons and between the electrons and the nuclei (potential). 
It can be seen that due to the presence of the fifth term, the variables of the electrons and nuclei cannot be separated. Therefore, the adiabatic approximation (Born-Oppenheimer approximation) must be introduced.

式子中前兩項代表核的動能和核與核之間的庫倫交互作用項,後三項為電子的動能和電子與電子,電子與核之間的庫倫交互作用項(potential),可以看到因第五項的存在,無法將電子與核的變量分離,因此要引入絕熱近似(Born-Oppenheimer approximation).


In the Born-Oppenheimer approximation, due to the large mass difference between the atomic nuclei and the electrons, and the fact that the electrons move very quickly, they respond adiabatically to the nuclei, which vibrate slowly around the equilibrium point. As a result, the system’s wavefunction can adjust in real-time. Therefore, the electronic and nuclear motions in the total wavefunction can be separated.

在Born-Oppenheimer approximation中,由於原子核和電子的質量差距非常大,且電子的速度非常快,會對在平衡點附近緩慢振動的原子核具有絕熱響應,可及時調整系統的wavefunction,所以可以將總波函數中的電子運動和核運動分離開來:

$$ \Psi (r_{i} ;R_{a} )=\phi (r_{i} ,R_{a})\chi (R_{a}) $$

$\phi (r_{i} ,R_{a})$ represents the electron wavefunction when the atomic nuclei are displaced from the equilibrium position $R_{a}$, and $\chi (R_{a})$ represents the wavefunction of the nuclear motion. By substituting $\phi (r_{i} ,R_{a})\chi (R_{a})$ into $\widehat{H}\Psi (r_{i} ;R_{a} )$, solve the Schrödinger equation:

$\phi (r_{i} ,R_{a})$代表原子核偏離平衡點$R_{a}$時的電子wavefunction,而$\chi (R_{a})$代表原子核運動的wavefunction. 將 $\phi (r_{i} ,R_{a})\chi (R_{a})$ 代入 $\widehat{H}\Psi (r_{i} ;R_{a} )$ 中，解 Schrödinger equation:

$$ 
\widehat{H}\phi (r_{i} ,R_{a})\chi (R_{a}) = \left( -\sum_{a=1 }^{k} \frac{\nabla^{2} {R_{a}}}{2m_{a}} + \sum_{a=1 }^{k} \sum_{b>a }^{k} \frac{Z_{a}Z_{b}}{R_{ab}} - \sum_{i=1}^{n} \frac{\nabla^{2} {r_{i}}}{2} + \sum_{i=1}^{n} \sum_{j>i }^{n} \frac{1}{r_{ij}} + \sum_{i=1}^{n} \sum_{a=1 }^{k} \frac{Z_{a}}{r_{ia}} \right)\phi (r_{i} ,R_{a})\chi (R_{a})
$$

Assume that the electron wavefunction $\phi (r_{i} ,R_{a})$ satisfies:

假設代表電子的$\phi (r_{i} ,R_{a})$滿足:

$$ 
\left( -\sum_{i=1}^{n} \frac{\nabla^{2} {r_{i}} }{2} + \sum_{i=1}^{n} \sum_{j>i }^{n} \frac{1}{r_{ij}} + \sum_{i=1}^{n} \sum_{a=1}^{k} \frac{Z_{a}}{r_{ia}} \right) \phi (r_{i} ,R_{a}) = \varepsilon_{\text{electron}} \phi (r_{i} ,R_{a})
$$

Then, the Schrödinger equation can be simplified to the following form:

則Schrödinger equation可以化簡成下面的形式:

$$ 
\widehat{H} \phi (r_{i} ,R_{a}) \chi (R_{a}) = \left( -\sum_{a=1 }^{k} \frac{\nabla_{R_{a}}^{2}}{2m_{a}} + \sum_{a=1 }^{k} \sum_{b>a }^{k} \frac{Z_{a}Z_{b}}{R_{ab}} + \varepsilon_{\text{electron}} \right) \phi (r_{i} ,R_{a}) \chi (R_{a})
$$

The kinetic energy term for nuclear motion can eventually be simplified into three terms:

處理核運動的動能項部分,最後能變成三項:

$$
-\sum_{a=1 }^{k} \frac{1}{2m_{a}} \nabla_{R_{a}}^2 \left[ \phi (r_{i} ,R_{a}) \chi (R_{a}) \right] = -\sum_{a=1 }^{k} \frac{1}{2m_{a}} \nabla_{R_{a}} \left[ \nabla_{R_{a}}^2 \phi (r_{i}, R_{a}) \chi (R_{a}) + 2 \nabla_{R_{a}} \phi (r_{i}, R_{a}) \nabla_{R_{a}} \chi (R_{a}) + \phi (r_{i}, R_{a}) \nabla_{R_{a}}^2 \chi (R_{a}) \right]
$$

If considering the normalization of the electron wavefunction, the second term can be eliminated:

若考慮對電子wavefunction歸一化,則第二項可以消去:

$$
\int \phi* (r_{i} ,R_{a}) \frac{\partial }{\partial R_{a}} \phi(r_{i} ,R_{a}) \, dr_{i} = \frac{1}{2} \frac{\partial }{\partial R_{a}} \int \phi^{*}(r_{i} ,R_{a}) \phi(r_{i} ,R_{a}) \, dr_{i}= 0
$$

Assuming that the electron is bound near the atomic nucleus, $\phi(r_{i} ,R_{a})$->$\phi(r_{i}-R_{a})$ and the first term can be written as:

假設電子被束縛在原子核附近的話,則$\phi(r_{i} ,R_{a})$->$\phi(r_{i}-R_{a})$,那第一項能改為:

$$
-\sum_{a=1}^{k} \frac{1}{2m_{a}} \frac{\partial^2}{\partial R_{a}^2} \phi(r_{i}, R_{a}) \chi(R_{a}) 
= -\sum_{a=1}^{k} \frac{1}{2m_{a}} \frac{\partial^2}{\partial r_i^2} \phi(r_{i}, R_{a}) \chi(R_{a}) 
= -\frac{m_{\text{electron}}}{m_{a}} \sum_{a=1}^{k} \frac{1}{2m_{\text{electron}}} \frac{\partial^2}{\partial r_i^2} \phi(r_{i}, R_{a}) \chi(R_{a})
$$

This term represents the kinetic energy of the electron at $R_{a}$. Due to the significant mass difference between the electron and the atomic nucleus, the value of $\frac{m_{electron}}{m_{a} }$ is approximately $10^{-4}$ to $10^{-5}$ times the electron's kinetic energy, so this term can also be neglected.

這項代表電子處於$R_{a}$的動能,由於電子和原子核的質量差距非常大,因此$\frac{m_{electron}}{m_{a} }$的值約為電子動能的$10^{-4} $ 至 $10^{-5} $倍,所以這項也能略去.

Therefore,$\widehat{H}\phi (r_{i} ,R_{a})\chi (R_{a})$ can be written as:

因此$\widehat{H}\phi (r_{i} ,R_{a})\chi (R_{a})$可改為:

$$
\widehat{H} \phi(r_{i}, R_{a}) \chi(R_{a}) = \phi(r_{i}, R_{a}) \left[ \nabla_{R_{a}}^2 \chi(R_{a}) + \sum_{a=1}^{k} \sum_{b>a}^{k} \frac{Z_{a} Z_{b}}{R_{ab}} \chi(R_{a}) + \varepsilon_{\text{electron}} \chi(R_{a}) \right]
$$

It can be concluded that the terms for electronic motion and nuclear motion in the total wavefunction can be effectively separated. First, solve for the electronic eigenvalue -$\varepsilon _{n}(R_{a})$ with fixed $R_{a}$ 
 (considering only the electron wavefunction, without needing to consider the nuclear wavefunction) as a reference, and then solve for the eigenvalue.

 
可以得知,總波函數中的電子運動和核運動的項可以有效分開,先求解固定$R_{a}$的電子eigenvalue-$\varepsilon _{n}(R_{a})$(只考慮電子的wavefunction,不須考慮核的wavefunction)作為參照,再來求解eigenvalue.













11
