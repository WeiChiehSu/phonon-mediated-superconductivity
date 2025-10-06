# 超導轉變溫度收斂問題討論

$$
由於計算\lambda _{q}和\alpha ^{2}F(\omega )需要在Fermi-surface進行雙重\delta積分計算電子態密度,但電腦無法計算\delta方程,為了處理\delta方程,需要使用broadening(展寬)方法進行\delta方程近似:
$$

$$
broadening:I=\int_{BZ}^{}dq \int_{BZ}^{}d\epsilon f(k,q)\delta (\epsilon _{n,K}-\epsilon _{F})\delta (\epsilon _{n^{'} ,k^{'}}-\epsilon _{F})
$$

$$
QE中使用broadening法時,先將k點網格平均切割成的好幾個區間,每個區間中用一組'類似,模糊'的光滑連率函數去近似成尖銳地\delta方程(\sigma=degauss),去計算系統的電子佔據數,最終得到電子態密度.
$$

$$
將broadening引入後,雙重\delta積分近似為:
$$

$$
I\simeq \frac{\Omega _{BZ}^{2} }{N_{K} N_{q}} \sum_{k}^{} \sum_{q}^{}  \frac{1}{\sqrt{2\pi \sigma } }e^{-\frac{(\epsilon _{k}-\epsilon _{F})^{2}   }{\sigma ^{2} } } \frac{1}{\sqrt{2\pi \sigma } }e^{-\frac{(\epsilon _{k^{'}}-\epsilon _{F})^{2}   }{\sigma ^{2} } }   
$$

broadening法可以用費米-狄拉克分布去進行理解:

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/introduction%20to%20The%20theory%20of%20First%20principle/degauss.png)

$$
\sigma(degauss)便是控制費米-狄拉克分布參數平緩或陡峭的參數:\sigma值越小,費米-狄拉克分布越陡峭;,\sigma值越大,費米-狄拉克分布越平緩
$$

k點網格平均切割成的區間,可以當成k(0.8-1.2)的範圍:k點網格切點值越疏,範圍越大;k點網格切點值越密,範圍越小

$$
從費米-狄拉克分布的圖可以注意到:k點網格切點密度需要和\sigma值匹配!倘若k點網格切點密度很高,\sigma很低,會造成低估電子態密度;倘若k點網格切點密度很小,\sigma很高,會造成嚴重高估電子態密度和導致數值計算補償,讓計算出的電子佔據數出現負值!
$$


這裡列出了用plot_compare_tc.m讀取不同參數設置保存的全部degauss電聲耦合係數,電聲耦合權重和超導轉變溫度(V_61248_data.mat....),進行比較:

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/Discussion%20on%20Convergence%20Properties/lambda1.png)

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/Discussion%20on%20Convergence%20Properties/omega_log1.png)

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/Discussion%20on%20Convergence%20Properties/T_c2%20.png)

以61248設置為例:第一個參數6是指ph.x計算的q點網格切點數,第二個參數12是第二步用來DFPT自洽的K點網格切點數,第三個參數48是第一步自準備計算電聲耦合係數(broadening法)中雙重狄拉克函數積分近似的能量採樣區間的較密K點網格切點數

探討k點網格切點密度和degauss收斂只需調整第三個參數值,因此我們選了61854,61872和61890三個設置去進行比較全部degauss電聲耦合係數,電聲耦合權重和超導轉變溫度:

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/Discussion%20on%20Convergence%20Properties/lambda3.png)

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/Discussion%20on%20Convergence%20Properties/omega_log3.png)

![圖片描述](https://github.com/WeiChiehSu/phonon-mediated-superconductivity/blob/main/tutorial%20for%20QE/Discussion%20on%20Convergence%20Properties/T_c3%20.png)

可以看到61872在 degauss = 0.008 Ry 時,61872設置計算出來的電聲耦合強度,電聲耦合權重和超導轉變溫度值與最密的61890設置計算出來的值開始吻合,達成收斂,表示(72 * 72 * 72)的能量採樣區間和degauss = 0.008 Ry的平滑函數匹配!而61854則在 degauss = 0.012 Ry 時,61854設置計算出來的電聲耦合強度,電聲耦合權重和超導轉變溫度值與較密的61890和61872設置計算出來的值開始吻合,達成收斂,表示(54 * 54 * 54)的能量採樣區間和degauss = 0.012 Ry的平滑函數匹配!

最終我們可以得到,61872設置配合degauss = 0.008 Ry得到的準確電聲耦合強度為1.4685,電聲耦合權重為200.335和超導轉變溫度為5.83433 K ,和V的實驗超導轉變溫度(5.4 K)相差不大!

# 影響超導轉變溫度問題幾個主要參數:屏蔽庫侖pseudo-potential

$$
根據McMillan-Allen{}Dynes{}function,得到\lambda和\omega _{log}後,便能初步推算材料的超導轉變溫度T_{c}:
$$

$$
T_{c}=\frac{\omega _{log} }{1.2}e^{[\frac{-1.04(1+\lambda ) }{\lambda-\mu ^{*}(1+0.62\lambda)   }] }
$$

$$
其中\mu ^{*}是屏蔽庫侖pseudo-potential,是半經驗參數,通常設值為0.1
$$


