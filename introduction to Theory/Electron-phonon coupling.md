引入Born-Oppenheimer approximation後,電子的Hamilton被簡化為:

$$
\widehat{H}_{electron}= -\sum_{i=1}^{n} \frac{\nabla^{2} _{r_{i}  }  } {2} +\sum_{i=1 }^{n} \sum_{j>i }^{n} \frac{1 }{r_{ij}}+ \sum_{i=1 }^{n} \sum_{a=1 }^{k} \frac{Z_{a} }{r_{ia}}
$$

第一項為電子的動能,第二項是電子與電子potential項,第三項電子與核之間的potential項.

電子與電子相互作用的存在無法使用分離變量去解上述的Schrödinger equation,因此引入平均場近似,用一個局域的potential來描述和其他電子的作用,這個potential和核之間的potential疊加形成的potential,就是獨立電子在晶格中運動所受到的平均場。

下面為電子在晶格中運動所受到的平均場,這表示電子(位在r_{i})和每一個離子實間(位在R_{j})的相互作用,即kohn-sham potential:

$$
V_{el_{r_{i}-R_{j}} } =\sum_{ij}^{}[-V_{K-S}(r_{i}-R_{j})\hat{r_{j} }]=\sum_{i=1 }^{n} \sum_{a=1 }^{k} \frac{Z_{a} }{r_{ia}} +\sum_{i=1 }^{n} \sum_{j>i }^{n} \frac{1 }{r_{ij}}
$$

因此電子的Hamilton的最終形式為:

$$
\widehat{H}_{electron}= -\sum_{i=1}^{n} \frac{\nabla^{2} _{r_{i}  }  } {2} +V_{el_{r_{i}-R_{j}} } =-\sum_{i=1}^{n} \frac{\nabla^{2} _{r_{i}  }  } {2}+\sum_{ij}^{}[-V_{K-S}(r_{i}-R_{j})\hat{r_{j} }]
$$

$$
現在考慮晶格(離子實間)的振動產生的擾動對電子的Hamilton的影響,若振動較為微弱(偏離平衡點的距離很短),其相對位移為r_{j},電子(位在r_{i})和離子實的相互作用改為:
$$

$$
V_{el_{r_{i}-R_{j}+r_{j}} } =\sum_{ij}^{}[-V_{K-S}(r_{i}-R_{j}+r_{j} )\hat{r_{j} }]
$$

$$
對代表離子實平衡位置R_{j}展開晶格位移r_{j}對kohn-sham{} potential的修正項(泰勒展開式):
$$

$$
V_{el_{r_{i}-R_{j}+r_{j}} }=-V_{K-S }(r_{i}-R_{j}+r_{j}) =\sum_{ij}^{}[-V_{K-S}(r_{i}-R_{j})\hat{r_{j} }-\frac{\partial V_{K-S}(r_{i}-R_{j})}{\partial R_{j} } r_{j}\hat{r_{j}} -\frac{1}{2!}\frac{\partial^{2}  V_{K-S}(r_{i}-R_{j})}{\partial^{2} R_{j}} (r_{j})^{2} \hat{r_{j}} +...  ]
$$

$$
第一項為電子和固定晶格的相互作用,即週期性potential,第二項代表晶格偏移平衡位置引起的potential變化,其中R_{j}為平衡點的位置(lattice的晶格向量),r_{j}是晶格偏離平衡點位置的位移.
$$

$$
V_{el_{r_{i}-R_{j}+r_{j}} }=-V_{K-S }(r_{i}-R_{j}+r_{j}) =\sum_{ij}^{}[-V_{K-S}(r_{i}-R_{j})\hat{r_{j} }-\frac{\partial V_{K-S}(r_{i}-R_{j})}{\partial R_{j} } r_{j}\hat{r_{j}} -\frac{1}{2!}\frac{\partial^{2}  V_{K-S}(r_{i}-R_{j})}{\partial^{2} R_{j}} (r_{j})^{2} \hat{r_{j}} +...  ]
$$

$$
第二項代表的物理意義可以從位能和微分的基本意義出發:-V_{K-S}(r_{i}-R_{j})代表電子從原子核位置R_{j} 移動到r_{i}時庫侖力做的功,對R_{j}微分表明當原子核位置微小變化時,電子和原子核間的勢能做功變化,從力學的角度來說,當原本固定的位能產生變化時,表示兩者間受到了一股額外的吸引力,現在\frac{\partial V_{K-S}(r_{i}-R_{j})}{\partial R_{j} }乘上原子核的位移r_{j}後,為系統因這股額外的力產生的Energy變化,與就是Hamilton的修正項,描述小位移對電子的線性影響,對應「電子-聲子耦合」（electron-phonon{} coupling）:
$$

$$
V_{el-ph }=-\frac{\partial V_{K-S}(r_{i}-R_{j})}{\partial R_{j} } r_{j}\hat{r_{j}} 
$$

$$
將electron-phonon{} coupling項中的\hat{r_{j}}進行Fouier{}transfrom (實空間->q空間),再將r_{j}以phonon的算符形式展開:
$$

$$
r_{j}\hat{r_{j}}=\frac{1}{\sqrt{N_{p} } } \sum_{q}^{} e^{iqR_{j}  } r_{j}\hat{r_{q}} = \frac{1}{\sqrt{N_{p} } } \sum_{q}^{} e^{iqR_{j}  }\frac{1}{\sqrt{2M\omega _{q}} }(a_{q}+a_{-q}^{+}) \hat{r_{q}}
$$

