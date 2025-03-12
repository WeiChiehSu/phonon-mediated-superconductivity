In order to calculate the effects of electron-phonon coupling, it is necessary to understand the Schrödinger equation and Hamiltonian of the (electron + nucleus) system:
為了計算電子聲子耦合的影響，要了解(電子+核)運動系統的Schrödinger equation和Hamilton:
```latex
$$
\widehat{H}\Psi (r_{i} ;R_{a} )=\varepsilon \Psi (r_{i} ;R_{a} )
$$
```
```latex
$$
\widehat{H} =-\sum_{a=1 }^{k} \frac{\nabla^{2} _{R_{a}  }  } {2m_{a}} +\sum_{a=1 }^{k} \sum_{b>a }^{k} \frac{Z_{a}Z_{b} }{R_{ab}}-\sum_{i=1}^{n} \frac{\nabla^{2} _{r_{i}  }  } {2} +\sum_{i=1 }^{n} \sum_{j>i }^{n} \frac{1 }{r_{ij}}+ \sum_{i=1 }^{n} \sum_{a=1 }^{k} \frac{Z_{a} }{r_{ia}}
$$
```
The first two terms in the equation represent the kinetic energy of the nuclei and the Coulomb interaction between the nuclei. The last three terms represent the kinetic energy of the electrons and the Coulomb interactions between the electrons and between the electrons and the nuclei (potential). 
It can be seen that due to the presence of the fifth term, the variables of the electrons and nuclei cannot be separated. Therefore, the adiabatic approximation (Born-Oppenheimer approximation) must be introduced.
式子中前兩項代表核的動能和核與核之間的庫倫交互作用項,後三項為電子的動能和電子與電子,電子與核之間的庫倫交互作用項(potential),可以看到因第五項的存在,無法將電子與核的變量分離,因此要引入絕熱近似(Born-Oppenheimer approximation).



