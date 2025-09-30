引入Born-Oppenheimer approximation後,電子的Hamilton被簡化為:

$$
\widehat{H}_{electron}= -\sum_{i=1}^{n} \frac{\nabla^{2} _{r_{i}  }  } {2} +\sum_{i=1 }^{n} \sum_{j>i }^{n} \frac{1 }{r_{ij}}+ \sum_{i=1 }^{n} \sum_{a=1 }^{k} \frac{Z_{a} }{r_{ia}}
$$

第一項為電子的動能,第二項是電子與電子potential項,第三項電子與核之間的potential項.

電子與電子相互作用的存在無法使用分離變量去解上述的Schrödinger equation,因此引入平均場近似,用一個局域的potential來描述和其他電子的作用,這個potential和核之間的potential疊加形成的potential,就是獨立電子在晶格中運動所受到的平均場。

下面為電子在晶格中運動所受到的平均場,這表示電子(位在$r_{i}$)和每一個離子實間(位在$R_{j}$)的相互作用,即kohn-sham potential:

$$
V_{el_{r_{i}-R_{j}} } =\sum_{ij}^{}[-V_{K-S}(r_{i}-R_{j})\hat{r_{j} }]=\sum_{i=1 }^{n} \sum_{a=1 }^{k} \frac{Z_{a} }{r_{ia}} +\sum_{i=1 }^{n} \sum_{j>i }^{n} \frac{1 }{r_{ij}}
$$

因此電子的Hamilton的最終形式為:

$$
\widehat{H}_{electron}= -\sum_{i=1}^{n} \frac{\nabla^{2} _{r_{i}  }  } {2} +V_{el_{r_{i}-R_{j}} } =-\sum_{i=1}^{n} \frac{\nabla^{2} _{r_{i}  }  } {2}+\sum_{ij}^{}[-V_{K-S}(r_{i}-R_{j})\hat{r_{j} }]
$$

現在考慮晶格(離子實間)的振動產生的擾動對電子的Hamilton的影響,若振動較為微弱(偏離平衡點的距離很短),其相對位移為$r_{j}$,電子(位在$r_{i}$)和每一個離子實間的相互作用為:

$$
現在考慮晶格(離子實間)的振動產生的擾動對電子的Hamilton的影響,若振動較為微弱(偏離平衡點的距離很短),其相對位移為r_{j},電子(位在r_{i})和每一個離子實間的相互作用為:
$$

$$
V_{el_{r_{i}-R_{j}+r_{j}} } =\sum_{ij}^{}[-V_{K-S}(r_{i}-R_{j}+r_{j} )\hat{r_{j} }]
$$
